import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/data/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({super.key});

  final ProductModel product = Get.arguments;
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameProductC = TextEditingController();
  final TextEditingController quantityC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    codeC.text = product.code;
    nameProductC.text = product.name;
    quantityC.text = "${product.qty}";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: product.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: "Kode Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameProductC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nama Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: quantityC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Jumlah Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoadingUpdate.isFalse) {
                if (nameProductC.text.isNotEmpty && quantityC.text.isNotEmpty) {
                  controller.isLoadingUpdate(true);
                  //proses update data
                  Map<String, dynamic> hasil = await controller.editProduct({
                    "id": product.productId,
                    "name": nameProductC.text,
                    "qty": int.tryParse(quantityC.text) ?? 0,
                  });
                  controller.isLoadingUpdate(false);

                  Get.snackbar(
                    hasil["error"] == true ? "Error" : "Berhasil",
                    hasil["message"],
                    duration: Duration(seconds: 2),
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    "Data Tidak Boleh Kosong",
                    duration: Duration(seconds: 2),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(
                  controller.isLoadingUpdate.isFalse ? "UPDATE" : "Loading..."),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Product",
                middleText: "Apakah kamu yakin ingin menghapus produk ?",
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: Text("Batal"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.isLoadingDelete(true);
                      Map<String, dynamic> hasil =
                          await controller.deleteProduct(product.productId);
                      controller.isLoadingDelete(false);
                      Get.back();
                      Get.back();
                      Get.snackbar(
                        hasil["error"] == true ? "Error" : "Berhasil",
                        hasil["message"],
                        duration: Duration(seconds: 2),
                      );
                    },
                    child: Obx(
                      () => controller.isLoadingDelete.isFalse
                          ? Text("HAPUS")
                          : Container(
                              padding: EdgeInsets.all(2),
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                strokeWidth: 1,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
            child: Text(
              "Delete Product",
              style: TextStyle(color: Colors.red.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
