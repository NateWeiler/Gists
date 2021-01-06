using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.IO;

namespace ppt2htm
{
    public class FileComparer : IComparer
    {
        public enum CompareBy
        {
            Name /* a-z */,
            LastWriteTime /* oldest to newest */,
            CreationTime  /* oldest to newest */,
            LastAccessTime /* oldest to newest */,
            FileSize /* smallest first */
        }
        // default comparison
        int _CompareBy = (int)CompareBy.Name;

        public FileComparer()
        {
        }

        public FileComparer(CompareBy compareBy)
        {
            _CompareBy = (int)compareBy;
        }

        int IComparer.Compare(object x, object y)
        {
            int output = 0;
            FileInfo file1 = new FileInfo(x.ToString());
            FileInfo file2 = new FileInfo(y.ToString());
            switch (_CompareBy)
            {
                case (int)CompareBy.LastWriteTime:
                    output = DateTime.Compare(file1.LastWriteTime, file2.LastWriteTime);
                    break;
                case (int)CompareBy.CreationTime:
                    output = DateTime.Compare(file1.CreationTime, file2.CreationTime);
                    break;
                case (int)CompareBy.LastAccessTime:
                    output = DateTime.Compare(file1.LastAccessTime, file2.LastAccessTime);
                    break;
                case (int)CompareBy.FileSize:
                    output = Convert.ToInt32(file1.Length - file2.Length);
                    break;
                case (int)CompareBy.Name:
                default:
                    output = (new CaseInsensitiveComparer()).Compare(file1.Name, file2.Name);
                    break;
            }
            return output;
        }
    }
}
