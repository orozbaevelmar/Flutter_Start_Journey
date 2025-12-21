import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:start_journey/cleanArch/core/common/widgets/widgetssss/custom_button.dart';
import 'package:start_journey/cleanArch/core/common/widgets/widgetssss/show_bottom_sheet.dart';
import 'package:start_journey/cleanArch/core/common/widgets/widgetssss/text_field.dart';
import 'package:start_journey/cleanArch/core/theme/app_color.dart';
import 'package:start_journey/cleanArch/core/constants/show_dialog.dart';
import 'package:start_journey/cleanArch/core/constants/text_style_const.dart';
import 'package:start_journey/cleanArch/core/constants/toast.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _buildImage(context),
                Text(
                  'Orozbaev Elmarbek',
                  style: GoogleFonts.frankRuhlLibre(fontSize: 30),
                ),
                SizedBox(height: 40),
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.shade100,
                  ),
                  child: IntlPhoneField(
                    style: MTextStyle.ui_14Regular(Color(0xff000000)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Phone number',
                      hintStyle: MTextStyle.ui_16Medium(AppColor.gray_04),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialCountryCode: 'KG',
                    /*   onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),*/
                    controller: _phoneNumberController,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.shade100,
                  ),
                  child: CustomTextField(
                    title: 'email',
                    keyboardType: TextInputType.emailAddress,
                    controller: TextEditingController(),
                    hintText: 'email@gmail.com',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        _selectedImage != null
            ? ClipOval(
                child: Image.file(
                  fit: BoxFit.cover,
                  _selectedImage!,
                  width: 100,
                  height: 100,
                ),
              )
            : Icon(
                Icons.account_circle,
                size: 100,
              ),
        Positioned(
          bottom: 3,
          right: 3,
          child: GestureDetector(
            onTap: () => _showBottomSheet(context),
            child: Container(
              width: 36,
              height: 36,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.greenPrimary, width: 2),
              ),
              child: Image.asset(
                'images/ic_edit.png',
                color: AppColor.greenSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    ShowBottomSheet.showBottomSheet(
      context: context,
      title: 'Изменить фото',
      list: [
        CustomButton(
          title: "Камера",
          onTap: () => _onTapTakeImage(context),
        ),
        const SizedBox(height: 5),
        CustomButton(
          title: "Открыть галлерею",
          onTap: () => _onTapChangeImage(context),
        ),
        const SizedBox(height: 5),
        CustomButton(
          title: "Удалить фото",
          onTap: () {
            Navigator.pop(context);
            MToast().showRed('Не удалось удалить фото');
          },
        ),
      ],
    );
  }

  Future<void> _onTapTakeImage(BuildContext context) async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (context.mounted && image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        Navigator.pop(context);
      }
    } catch (error) {
      if (context.mounted) {
        await _askPermission(context);
      }
    }
  }

  Future<void> _onTapChangeImage(BuildContext context) async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (context.mounted && image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        Navigator.pop(context);
      }
    } catch (error) {
      if (context.mounted) {
        await _askPermission(context);
      }
    }
  }

  Future<void> _askPermission(BuildContext context) async {
    PermissionStatus status = await Permission.photos.status;
    if (status.isDenied) {
      if (context.mounted) {
        // openAppSettings();
        // The user permanently denied the permission
        // You can open the Settings app to manually grant the permission
        ShowDialog.showDialogSetting(
          context: context,
          title: 'Разрешение отклонено',
          content:
              'Вы можете открыть приложение "Настройки", чтобы вручную предоставить разрешение для приложения на доступ к галерее.',
          onTapYes: () => openAppSettings(),
          yesButtonText: 'Перейти в настройки',
        );
      }
    } else {
      MToast().showRed('Что-то пошло не так');
    }
    /* ShowDialog.showDialogSetting(
      context: context,
      title: 'Доступ запрещен',
      content: 'Пожалуйста, предоставьте разрешение на доступ к галерее.',
      onTapYes: () => Permission.photos.request(),
      yesButtonText: 'Предоставить разрешение',
    ); */
  }
}
