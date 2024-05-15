import 'package:chat/core/constants/strings.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/utils/routing/app_router.dart';
import 'package:chat/utils/toast.dart';
import 'package:chat/widgets/app_elevated_button.dart';
import 'package:chat/widgets/account_question.dart';
import 'package:chat/widgets/login/login_form.dart';
import 'package:chat/widgets/auth_header.dart';
import 'package:chat/widgets/login/login_wrapper_container.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    _authService = _getIt.get<AuthService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LoginWrapperContainer(
          children: [
            const Spacer(),
            const AuthHeader(title: kLoginHeaderTitle, subTitle: kLoginHeaderSubTitle),
            const Spacer(),
            const SizedBox(height: 64.0),
            LoginForm(
              formKey: loginFormKey,
              emailController: emailController,
              passwordController: passwordController,
            ),
            const SizedBox(height: 64.0),
            AppElevatedButton(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(kLogin, style: TextStyle(fontSize: 16)),
                onPressed: () => _validateUserAndLogin()),
            const SizedBox(height: 12),
            AccountQuestion(
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.register),
              text: kDontHaveAnAccount,
              textButton: kRegister,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _validateUserAndLogin() async {
    if (loginFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final bool result = await _authService.login(email: email, password: password);

      if (result) {
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          AppToasts.showErrorToast(message: kLoginFailure, context: context);
        }
      }
    }
  }
}
