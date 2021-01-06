using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Office.Core;
using Microsoft.Office.Interop.PowerPoint;
using System.IO;
using System.Collections;
using ns;

namespace ppt2htm
{
    class Program
    {
        static void Main(string []args)
        {
            String path = System.IO.Directory.GetCurrentDirectory();
            String rpath=path+"\\copy\\";
            String path1 = path + "\\copy\\pptimg";
            
            string[] filePaths = Directory.GetFiles(path1, "*.jpg");
            foreach (string filePath in filePaths)
            {
                //if (filePath.Contains(".bmp"))
                File.Delete(filePath);
            }
            
            Microsoft.Office.Interop.PowerPoint.Application app = new Microsoft.Office.Interop.PowerPoint.Application();

            Console.WriteLine("Specify the complete path of the Powerpoint file...");

            String spath = Console.ReadLine();

            Presentation pres = app.Presentations.Open(spath, MsoTriState.msoTrue, MsoTriState.msoFalse, MsoTriState.msoFalse);
           
            pres.SaveAs(path1, PpSaveAsFileType.ppSaveAsJPG, MsoTriState.msoFalse);

            pres.Close();

            string folder = path1;
            string[] files = Directory.GetFiles(folder);
            NumericComparer ns = new NumericComparer();
            Array.Sort(files, ns);
            int count1 = 0;
            foreach (string file in files)
            {
                count1++;
            }

            TextReader tr = new StreamReader("begin.html");
            TextWriter tw = new StreamWriter(path+"\\copy\\op.html");
            tw.WriteLine(tr.ReadToEnd());
            String int_str;
            for (int i = 0; i < count1; i++)
            {
                int_str=files[i].Replace(rpath, "");
                tw.WriteLine("<div class=\"slide\" id=\"landing-slide" + i + "\"> <style>#landing-slide p {font-size: 35px;}#landing-slide li{font-size: 25px;}</style><section class=\"middle\"><img id=\"imgBamburgh" + i + "\" alt=\"\"src=\"" + int_str + "\"pbshowcaption=\"true\"pbcaption=\""+int_str+"\"style=\"width: 750px; height: 550px;\"class=\"PopBoxImageSmall\" title=\"Click to magnify/shrink\" onclick=\"Pop(this,50,'PopBoxImageLarge');\" /></section> </div> ");
                tw.WriteLine();
            }
                tr.Close();
            tw.Close();

            string fname=path + "\\copy\\op.html";
            TextReader tr2 = new StreamReader("end.html");
   FileInfo file1=new FileInfo(fname);
   StreamWriter sw = File.AppendText(fname);
   sw.WriteLine(tr2.ReadToEnd());
   tr2.Close();
   sw.Close(); 
        }
    }
}
