import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/data/models/product_model.dart';
import 'package:qr_code/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamProdutcs(),
          builder: (context, snappProducts) {
            if (snappProducts.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snappProducts.data!.docs.isEmpty) {
              return const Center(
                child: Text("Tidak Ada Produk"),
              );
            }

            List<ProductModel> allProducts = [];

            for (var element in snappProducts.data!.docs) {
              allProducts.add(ProductModel.fromJson(element.data()));
            }

            return ListView.builder(
              itemCount: allProducts.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                ProductModel product = allProducts[index];
                return Card(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.detailProduct);
                      },
                      borderRadius: BorderRadius.circular(9),
                      child: Container(
                        height: 110,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kode Barang : ${product.code}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Nama Barang :  ${product.name}",
                                  ),
                                  Text(
                                    "Jumlah Barang :  ${product.qty}",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: QrImageView(
                                data: product.code,
                                size: 200.0,
                                version: QrVersions.auto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            );
          }),
    );
  }
}
