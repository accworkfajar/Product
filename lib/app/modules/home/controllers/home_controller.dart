import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  void downloadkatalog() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Padding(
                  padding: pw.EdgeInsets.all(20),
                  child: pw.Text(
                    textAlign: pw.TextAlign.center,
                    "Catalog Products",
                    style: const pw.TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColor.fromHex("#000000"),
                  width: 2,
                ),
                children: [
                  pw.TableRow(
                    children: [
                      //no
                      pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "No",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      //kode barang
                      pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "Kode Barang",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      // nama barang
                      pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "Nama Barang",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      //qty
                      pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "Jumlah Barang",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      //qr code
                      pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Text(
                          textAlign: pw.TextAlign.center,
                          "QR Code",
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ISI DATA
                  ...List.generate(
                    5,
                    (index) {
                      return pw.TableRow(
                        children: [
                          //no
                          pw.Padding(
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Text(
                              textAlign: pw.TextAlign.center,
                              "${index + 1}",
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          //kode barang
                          pw.Padding(
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Text(
                              textAlign: pw.TextAlign.center,
                              "1234567890",
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          // nama barang
                          pw.Padding(
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Text(
                              textAlign: pw.TextAlign.center,
                              "APA COBA",
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          //qty
                          pw.Padding(
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Text(
                              textAlign: pw.TextAlign.center,
                              "${index + 123} ",
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          //qr code
                          pw.Padding(
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Text(
                              textAlign: pw.TextAlign.center,
                              "QR Code",
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    //simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationCacheDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // memasukkan data bytes ke file kosong
    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }
}
