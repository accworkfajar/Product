import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({super.key});

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameProductC = TextEditingController();
  final TextEditingController quantityC = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
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
              if (controller.isLoading.isFalse) {
                controller.isLoading(true);
                // Map<String, dynamic> hasil =
                //     ...;
                controller.isLoading(false);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () =>
                  Text(controller.isLoading.isFalse ? "TAMBAH" : "Loading..."),
            ),
          ),
        ],
      ),
    );
  }
}
