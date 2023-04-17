import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:get/get.dart';

class InformationsPage extends StatelessWidget {
  InformationsPage({Key? key}) : super(key: key);

  final EditingController editingController = Get.put(EditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.delete<EditingController>();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                editingController.isEditing.value =
                    !editingController.isEditing.value;
              },
              icon: editingController.isEditing.value
                  ? const Icon(Icons.check)
                  : const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.width15, vertical: Dimensions.height15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildField('Name', 'Mehdi'),
              _buildField('Email', 'mehdi@mehdi.com'),
              _buildField('Phone', '0666666666'),
              _buildField('Address', 'Rue de la paix'),
              _buildField('City', 'Paris'),
              _buildField('Zip code', '75000'),
              _buildField('Country', 'France'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String titleField, String valueField) {
    final controller = TextEditingController(text: valueField);
    return Obx(
      () => Container(
        margin: EdgeInsets.only(bottom: Dimensions.height20),
        child: TextField(
          controller: controller,
          enabled: editingController.isEditing.value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Get.isDarkMode
                    ? AppColors.mainDarkColor.withOpacity(0.5)
                    : AppColors.mainColor.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: titleField,
          ),
        ),
      ),
    );
  }
}

class EditingController extends GetxController {
  final RxBool isEditing = false.obs;
}
