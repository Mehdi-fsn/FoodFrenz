import 'package:flutter/material.dart';
import 'package:foodfrenz/app/core/theme/colors.dart';
import 'package:foodfrenz/app/core/utils/dimensions.dart';
import 'package:foodfrenz/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class InformationsPage extends StatelessWidget {
  InformationsPage({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find();
  final EditingController editingController = Get.put(EditingController());

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String name = profileController.userChanges.value!.displayName ??
        profileController.userChanges.value!.email!.split('@').first;
    final String email = profileController.userChanges.value!.email!;
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
              Form(
                child: Column(
                  children: [
                    _buildField('Name', name, nameTextController),
                    _buildField('Email', email, emailTextController),
                    Obx(
                      () => editingController.isEditing.value == true
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Get.isDarkMode
                                    ? AppColors.mainDarkColor.withOpacity(0.3)
                                    : AppColors.mainColor.withOpacity(0.3),
                              ),
                              onPressed: () async {
                                if (nameTextController.text != name) {
                                  if (emailTextController.text != email) {
                                    await profileController.updateUserProfile(
                                        displayName: nameTextController.text,
                                        email: emailTextController.text);
                                  }
                                } else {
                                  if (emailTextController.text != email) {
                                    await profileController.updateUserProfile(
                                        email: emailTextController.text);
                                  }
                                }
                                editingController.isEditing.value = false;
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? AppColors.mainDarkColor
                                      : AppColors.mainColor,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
      String titleField, String valueField, TextEditingController controller) {
    controller.text = valueField;
    final TextInputType keyboardType =
        titleField == 'Email' ? TextInputType.emailAddress : TextInputType.text;
    return Obx(
      () => Container(
        margin: EdgeInsets.only(bottom: Dimensions.height20),
        child: TextFormField(
          controller: controller,
          enabled: editingController.isEditing.value,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: titleField,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Get.isDarkMode
                    ? AppColors.mainDarkColor.withOpacity(0.5)
                    : AppColors.mainColor.withOpacity(0.7),
              ),
              borderRadius: BorderRadius.circular(Dimensions.radius30),
            ),
          ),
          cursorColor:
              Get.isDarkMode ? AppColors.mainDarkColor : AppColors.mainColor,
        ),
      ),
    );
  }
}

class EditingController extends GetxController {
  final RxBool isEditing = false.obs;
}
