import 'dart:io';

import 'package:chat/core/constants/exceptions.dart';
import 'package:chat/core/constants/form.dart';
import 'package:chat/core/constants/images.dart';
import 'package:chat/core/constants/strings.dart';
import 'package:chat/core/constants/validation.dart';
import 'package:chat/models/user_profile.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/db_service.dart';
import 'package:chat/services/media_service.dart';
import 'package:chat/services/storage_service.dart';
import 'package:chat/utils/routing/app_router.dart';
import 'package:chat/utils/toast.dart';
import 'package:chat/widgets/account_question.dart';
import 'package:chat/widgets/app_elevated_button.dart';
import 'package:chat/widgets/app_form_field.dart';
import 'package:chat/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetIt getIt = GetIt.instance;
  late MediaService _mediaService;
  late AuthService _authService;
  late StorageService _storageService;
  late DatabaseService _databaseService;

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    _mediaService = getIt.get<MediaService>();
    _authService = getIt.get<AuthService>();
    _storageService = getIt.get<StorageService>();
    _databaseService = getIt.get<DatabaseService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const AuthHeader(
                  title: kLoginRegisterHeaderTitle,
                  subTitle: kRegisterHeaderSubTitle,
                ),
                const SizedBox(height: 32.0),
                UserAvatar(
                  selectedImage: selectedImage,
                  onTap: () async {
                    File? file = await _mediaService.getImageFromGallery();
                    if (file != null) {
                      setState(() {
                        selectedImage = file;
                      });
                    }
                  },
                ),
                const SizedBox(height: 32.0),
                RegisterForm(
                  registerFormKey: registerFormKey,
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 32.0),
                AppElevatedButton(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          kRegister,
                          style: TextStyle(fontSize: 16),
                        ),
                  onPressed: () async {
                    try {
                      if (registerFormKey.currentState!.validate() && (selectedImage != null)) {
                        setState(() {
                          isLoading = true;
                        });
                        final String email = emailController.text.trim();
                        final String password = passwordController.text.trim();
                        final String name = nameController.text.trim();
                        bool result = await _authService.register(email: email, password: password);
                        if (result) {
                          String? pfpUrl = await _storageService.uploadUserPfp(
                            file: selectedImage!,
                            uid: _authService.user!.uid,
                          );

                          if (pfpUrl != null) {
                            await _databaseService.creteUserProfile(
                              userProfile: UserProfile(
                                  uid: _authService.user!.uid, name: name, pfpURL: pfpUrl),
                            );
                          } else {
                            throw Exception(kUnableToYplaodPicture);
                          }
                          setState(() {
                            isLoading = false;
                          });

                          if (mounted) {
                            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                            AppToasts.showSuccessToast(message: kAccountCreated, context: context);
                          }
                        } else {
                          throw Exception(kUnableToRegisterUser);
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        AppToasts.showErrorToast(message: kPleaseFillForm, context: context);
                      }
                    } catch (e) {
                      if (mounted) {
                        AppToasts.showErrorToast(message: e.toString(), context: context);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
                AccountQuestion(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
                  text: kAlreadyHaveAccount,
                  textButton: kLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> registerFormKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const RegisterForm({
    super.key,
    required this.registerFormKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        children: [
          AppFormField(
            hint: kName,
            label: kName,
            controller: nameController,
            validationRegExp: nameValidationRegex,
          ),
          const SizedBox(height: 16.0),
          AppFormField(
            hint: kEmail,
            label: kEmail,
            controller: emailController,
            validationRegExp: emailValidationRegex,
          ),
          const SizedBox(height: 16.0),
          AppFormField(
            hint: kPassword,
            label: kPassword,
            isObsecure: true,
            controller: passwordController,
            validationRegExp: passwordValidtionRegex,
          ),
        ],
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onTap;

  const UserAvatar({super.key, this.selectedImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 80,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : const NetworkImage(placeholderPfp) as ImageProvider<Object>?,
      ),
    );
  }
}
