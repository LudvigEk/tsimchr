/*******************************************************************************
 *
 *   tsimchr.exe - 
 *
 *   Björn Nilsson, 2016
 *
 */

#include "types/tablefun.h"
#include "system/consoleapp.h"
#include "system/filesystem.h"
#include "types/stringfun.h"
#include "math/statfun.h"
#include "math/rand.h"
#include <float.h>

int g_nRefs= 0;

/******************************************************************************/

class CApp : public CConsoleApp
{
protected:
	bool m_bHelpShown;
	CTableIndex m_Index;

	void DisplayHelp();
	void SetDefaultParameters();
	bool CheckParameters();

	double m_Pmajor;
	double m_Ppoint;
	double m_Predup;
	int m_nAccepted;

	virtual bool OnSwitch(const char *ach, CString &sSwitch);
	void DisplayInfo();
	bool DisplayInfo_RES();

	void EnumClasses(int nAnnotRows, int nAnnotCols);
public:
	virtual int Main(int argc, TCHAR* argv[], TCHAR* envp[]);
};

void CApp::DisplayHelp()
{
	m_bHelpShown=true;

	CString sName= g_FileSystem.GetExecutableFileName();
	sName= g_FileSystem.GetNameWithoutExtension(g_FileSystem.GetStrippedName(sName));
	printf("Usage: %s <dataset>\n", sName);
	printf("-h\tDisplays column headers at first row.\n"); 
	printf("-h:nnn\tDisplays column headers at row nnn (zero-based).\n");
	printf("-?\tDisplay help text.\n");
}

bool CApp::OnSwitch(const char *ach, CString &sSwitch)
{
	if (sSwitch=="?")
	{
		DisplayHelp();
		return true;
	}
	else if (sSwitch=="n")
	{
		m_nAccepted= atoi(ach);
		return true;
	}
	else if (sSwitch=="pmajor") // Prob(first hit = major/whole-chromosome event)
	{
		m_Pmajor= atof(ach)/100;
		return true;
	}
	else if (sSwitch=="ppoint") // Prob(second hit = point mutation/undetectable)
	{
		m_Ppoint= atof(ach)/100;
		return true;
	}
	else if (sSwitch=="predup") // Prob(second hit = reduplication)
	{
		m_Predup= atof(ach)/100;
		return true;
	}

	CString s= sSwitch;
	if (ach && *ach)
		s += ":" + CString(ach);
	ReportError("Illegal switch", s);
	return false;
}

void CApp::SetDefaultParameters()
{
	m_bHelpShown= false;

	m_Pmajor= 0;
	m_Ppoint= 0;
	m_Predup= 0;
	m_nAccepted= 1000;
}

bool CApp::CheckParameters()
{
	if (m_bHelpShown)
		return false;

	if (m_Ppoint+m_Predup+m_Pmajor>1.0)
	{
		ReportError("ppoint+predup+pmajor > 1.0", 0);
		return false;
	}
	return true;
}


/******************************************************************************/
// Main application

bool ContainsEssential(const CVector<int> &v_gene_start, 
					  const CVector<int> &v_gene_end,
					  const CVector<bool> &v_essential,
					  int i0, int i1)
{
	for (int i=0;i<v_gene_start.GetSize();i++)
	{
		if (v_essential[i])
		{
			int j0= v_gene_start[i];
			int j1= v_gene_end[i];
			if (!((i1<=j0) || (i0>=j1)))
				return true;
		}
	}

	return false;
}

bool ContainsEssential2(const CVector<int> &v_gene_start, 
					  const CVector<int> &v_gene_end,
					  const CVector<bool> &v_essential,
					  int a0, int a1,
					  int b0, int b1)
{
	for (int i=0;i<v_gene_start.GetSize();i++)
	{
		if (v_essential[i])
		{
			int x0= v_gene_start[i];
			int x1= v_gene_end[i];
			if (!((a1<=x0) || (a0>=x1)))
				if (!((b1<=x0) || (b0>=x1)))
					return true; // both (a0,a1) and (b0,b1) cover the same essential gene = homozyg del.
		}
	}

	return false;
}

void Fill_cn(int *p, int i0, int i1)
{
	for (int i=i0;i<=i1;i++)
		p[i]++;
}

int CApp::Main(int argc, TCHAR* argv[], TCHAR* envp[])
{
	int nRes= 100;
	SetDefaultParameters();
	if (ParseCommandLine(argc, argv, envp))
	{
		if (m_vNonSwitchArgs.GetSize()<1)
		{
			ReportError("Not enough arguments", NULL);
			return 1000;
		}

		if (!CheckParameters())
		{
			return 1000;
		}

		int n_genes= 15;
		int n_gene_length= 1000;
		int n_gene_spacing= (100000-n_gene_length)/(n_genes+1);

		CVector<int> v_gene_start(n_genes), v_gene_end(n_genes);
		CVector<bool> v_essential(n_genes);
		for (int i=0;i<n_genes;i++)
		{
			v_gene_start.SetAt(i, (i+1)*n_gene_spacing);
			v_gene_end.SetAt(i, (i+1)*n_gene_spacing+n_gene_length);
			v_essential.SetAt(i, false);
		}

		int n_chr_len= (n_genes+1)*n_gene_spacing+n_gene_length;
		CVector<int> v_del_het(n_chr_len), v_del_hom(n_chr_len);
		v_del_het.Fill(0);
		v_del_hom.Fill(0);

		int i_tsg= (n_genes*2)/3; // index of tumor suppressor gene

		//v_essential.SetAt(n_genes*1/5, true); // indicate essential genes
		//v_essential.SetAt(n_genes*2/5, true);
		//v_essential.SetAt(n_genes*7/8, true);

		int *p_del_het= v_del_het.GetBuffer();
		int *p_del_hom= v_del_hom.GetBuffer();

		//printf("tsg_start= %d\n", v_gene_start[i_tsg]);
		//printf("tsg_end= %d\n", v_gene_end[i_tsg]);
		
		bool bOk= true;
		int n_accepted= 0;
		int n_event_spread= n_chr_len*1;
		for (;n_accepted<m_nAccepted;)
		{
			// first hit
			int a0, a1;
			double r1= rand_real2();
			if (r1<m_Pmajor)
			{
				// first hit major (whole-chromosome or chromosome arm) deletion
				a0= 0;
				a1= n_chr_len; 
			}
			else if (r1<m_Pmajor+m_Ppoint)
			{
				// first hit point mutation 
				a0= a1= v_gene_start[i_tsg] + rand_int31() % (v_gene_start[i_tsg]-v_gene_end[i_tsg]);
			}
			else
			{
				// first hit segmental, regional deletion
				a0= v_gene_start[i_tsg] - rand_int31() % n_event_spread; // p-term of tsg
				if (a0<0)
					a0= 0;
				a1= v_gene_end[i_tsg]   + rand_int31() % n_event_spread; // q-term of tsg
				if (a1>=n_chr_len)
					a1= n_chr_len-1;
			}
			
			// second hit
			int b0, b1;
			double r2= rand_real2(); 
			if (r2<m_Pmajor)
			{
				// second hit major deletion
				b0= 0;
				b1= n_chr_len; 
			}
			else if (r2<m_Pmajor+m_Ppoint)
			{
				// second hit point mutation
				b0= b1= v_gene_start[i_tsg] + rand_int31() % (v_gene_start[i_tsg]-v_gene_end[i_tsg]);
			}
			else if (r2<m_Pmajor+m_Ppoint+m_Predup)
			{
				// second hit reduplication accompanied by loss of the other/normal chromosome.
				b0= a0;
				b1= a1;
			}
			else 
			{
				// second hit segmental, regional deletion
				b0= v_gene_start[i_tsg] - rand_int31() % n_event_spread; // p-term of tsg
				if (b0<0)
					b0= 0;
				b1= v_gene_end[i_tsg]   + rand_int31() % n_event_spread; // q-term of tsg
				if (b1>=n_chr_len)
					b1= n_chr_len-1;
			}

			// if (!ContainsEssential(v_gene_start, v_gene_end, v_essential, a0, a1) || !ContainsEssential(v_gene_start, v_gene_end, v_essential, b0, b1))
			// if (!ContainsEssential2(v_gene_start, v_gene_end, v_essential, a0, a1, b0, b1))
			if (!ContainsEssential(v_gene_start, v_gene_end, v_essential, __max(a0,b0), __min(a1,b1)))
			{
				// accepted
				Fill_cn(p_del_het, __min(a0,b0), __max(a1,b1)); // at least one copy deleted
				Fill_cn(p_del_hom, __max(a0,b0), __min(a1,b1)); // both copies deleted
				n_accepted++;
			}
			else
			{
				// not viable --> do nothing.
			}
		}
		printf("\n");

		CString sBasename_out= m_vNonSwitchArgs[0];
		CString sFilename_cn= sBasename_out + ".txt";
		FILE *pf= OpenOutputFile(sFilename_cn);
		if (pf)
		{
			for (int i=0;i<v_del_het.GetSize();i++)
				fprintf(pf, "%d\t%d\t%d\t%d\t%g\t%g\n", i, v_del_het[i], v_del_hom[i], n_accepted, double(v_del_het[i])/n_accepted, double(v_del_hom[i])/n_accepted);
			CloseFile(pf);
		}

		CString sFilename_genes= sBasename_out + ".genes.txt";
		FILE *pf_g= OpenOutputFile(sFilename_genes);
		if (pf_g)
		{
			for (int i=0;i<v_gene_start.GetSize();i++)
			{
				fprintf(pf_g, "%d\t%d\t%d\t", i, v_gene_start[i], v_gene_end[i]);
				if (v_essential[i])
					fprintf(pf_g, "1");
				else if (i==i_tsg)
					fprintf(pf_g, "2");
				else
					fprintf(pf_g, "0");
				fprintf(pf_g, "\n");
			}
			CloseFile(pf);
		}

		/*
		if (m_vNonSwitchArgs.GetSize()<1)
		{
			ReportError("Not enough arguments", NULL);
			return 1000;
		}

		CString sErr;
		CLoadBuf *pLB= Table_LoadTabDataset(m_vNonSwitchArgs[0], m_Index, sErr);
		if (pLB)
		{
			if (CheckParameters())
			{
				// Display basic info
				DisplayInfo();

				// Display format-specific info
				if (strcmp_nocase(g_FileSystem.GetFileExtension(m_vNonSwitchArgs[0]), "RES")==0 && DisplayInfo_RES()) 
				{}
				else // Add next format here...
				{}

				nRes= 0;
			}

			g_FileSystem.FreeBuf(pLB);
		}
		else
			ReportError(sErr, m_vNonSwitchArgs[0]);
		*/
	}

	return nRes;
}

/******************************************************************************/

int main(int argc, TCHAR* argv[], TCHAR* envp[])
{
	/*
	CVector<CString> v;
	for (int i=0;i<10000;i++)
		v.Add(::Format("Nisse %d ", i));

	for (int i=0;i<v.GetSize();i++)
		printf(v[i]);
	return 0;

	*/

	CApp app;
	return app.Main(argc, argv, envp);
}
