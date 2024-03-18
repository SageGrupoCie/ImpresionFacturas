using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;

namespace UnificarPDFs
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // Rutas de los archivos PDF que quieres unificar
            string pdf1Path = args[0];
            string pdf2Path = args[1];

            // Ruta del archivo de salida
            string outputPath = args[2];

            // Llama al método para unificar los archivos PDF
            UnificarPDFs(pdf1Path, pdf2Path, outputPath);

        }

        static void UnificarPDFs(string pdf1Path, string pdf2Path, string outputPath)
        {
            PdfSharp.Pdf.PdfDocument outputDocument = new PdfDocument();

            // Abre el primer archivo PDF y agrega sus páginas al documento de salida
            PdfDocument pdf1 = PdfReader.Open(pdf1Path, PdfDocumentOpenMode.Import);
            foreach (PdfPage page in pdf1.Pages)
            {
                outputDocument.AddPage(page);
            }

            // Abre el segundo archivo PDF y agrega sus páginas al documento de salida
            PdfDocument pdf2 = PdfReader.Open(pdf2Path, PdfDocumentOpenMode.Import);
            foreach (PdfPage page in pdf2.Pages)
            {
                outputDocument.AddPage(page);
            }

            // Guarda el documento de salida como un archivo unificado
            outputDocument.Save(outputPath);
        }
    }
}

