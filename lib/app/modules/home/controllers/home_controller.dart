import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_code/app/data/models/product_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ProductModel> allProduct = List<ProductModel>.empty().obs;

  void downloadkatalog() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("products").get();

    // reset all product -> untuk mengatasi duplikat
    allProduct([]);

    // isi data from database allProduct
    for (var element in getData.docs) {
      allProduct.add(
        ProductModel.fromJson(
          element.data(),
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData = List.generate(
            allProduct.length,
            (index) {
              ProductModel product = allProduct[index];
              return pw.TableRow(
                children: [
                  //no
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      "${index + 1}",
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  //kode barang
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      product.code,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  // nama barang
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      product.name,
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  //qty
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      textAlign: pw.TextAlign.center,
                      "${product.qty}",
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  //qr code
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.BarcodeWidget(
                      height: 50,
                      width: 50,
                      color: PdfColor.fromHex("#000000"),
                      data: product.code,
                      barcode: pw.Barcode.qrCode(),
                    ),
                  ),
                ],
              );
            },
          );

          return [
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
                          fontSize: 10,
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
                          fontSize: 10,
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
                          fontSize: 10,
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
                          fontSize: 10,
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
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ...allData,
              ],
            ),
          ];
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
