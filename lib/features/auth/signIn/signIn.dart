import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/legend_design_core.dart' as l;
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/rich/legend_rich_text.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/auth/signup/signup.dart';
import 'package:smart_chef_app/features/auth/state/auth_process_state.dart';
import 'package:smart_chef_app/features/auth/widgets/backbutton.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_checkbox.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';
import 'package:smart_chef_app/services/auth_service.dart';

final emailValidProvider = StateProvider.autoDispose<EmailValidation>((ref) {
  return EmailValidation.none;
});

final passwordValidProvider =
    StateProvider.autoDispose<PasswordValidation>((ref) {
  return PasswordValidation.none;
});

final authstateProvider = StateProvider.autoDispose<String?>((ref) {
  return null;
});

final savedInfo = FutureProvider<SavedUser?>((ref) async {
  return AuthService.readUser();
});

final rememberMeProvider = StateProvider<bool>((ref) {
  return ref.watch(savedInfo).when(
        data: (data) => data != null,
        loading: () => false,
        error: (_, __) => false,
      );
});

class SignInScreen extends HookConsumerWidget {
  static String route = "/signin";

  const SignInScreen({Key? key}) : super(key: key);

  Future<bool> _signIn(
    WidgetRef ref,
    TextEditingController emailCtrl,
    TextEditingController passwordCtrl,
    BuildContext context,
  ) async {
    final email = emailCtrl.text;
    final password = passwordCtrl.text;
    final emailValidation = validateEmail(email);
    final passwordValidation = validatePassword(password);

    ref.read(authstateProvider.notifier).state = null;
    ref.read(emailValidProvider.notifier).state = emailValidation;
    ref.read(passwordValidProvider.notifier).state = passwordValidation;

    if (emailValidation == EmailValidation.valid &&
        passwordValidation == PasswordValidation.valid) {
      final state =
          await ref.read(authProvider.notifier).login(email, password);
      if (state is AuthError) {
        ref.read(authstateProvider.notifier).state = state.message;
        return false;
      }

      final rememberMe = ref.read(rememberMeProvider);
      if (rememberMe) {
        AuthService.saveUserInfo(SavedUser(email, password));
      } else {
        AuthService.deleteInfo();
      }

      return state is Authenticated;
    }
    return false;
  }

  @override
  Widget build(BuildContext context, ref) {
    const spacer = SizedBox(height: 16);
    final theme = LegendTheme.of(context);
    final emailState = ref.watch(emailValidProvider);
    final passwordState = ref.watch(passwordValidProvider);
    final emailValid = emailState == EmailValidation.valid ||
        emailState == EmailValidation.none;
    final passwordValid = passwordState == PasswordValidation.valid ||
        passwordState == PasswordValidation.none;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authErrorMessage = ref.watch(authstateProvider);
    final collapsed = SizeInfo.of(context).width < 800;

    ref.watch(savedInfo).whenData((value) {
      if (value != null) {
        emailController.text = value.email;
        passwordController.text = value.password;
      }
    });

    return LegendRouteBody(
      singlePage: true,
      disableContentDecoration: true,
      builder: (context, s) {
        final scrollController = RouteBodyInfo.of(context).scrollController;
        return Stack(
          fit: StackFit.expand,
          children: [
            Row(
              children: [
                if (!collapsed)
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF4E76A8),
                            Color(0xFF4EC4A8),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/logo.svg",
                          height: 164,
                          width: 164,
                          color: theme.colors.primary,
                        ),
                        //     const SizedBox(height: 12),
                        Container(
                          width: 380,
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: LegendText(
                                  "Welcome Back",
                                  style: theme.typography.h5,
                                  color: theme.colors.foreground1,
                                ),
                              ),
                              const SizedBox(height: 32),
                              LegendText(
                                "Email Address",
                                style: theme.typography.h1,
                                color: theme.colors.foreground2,
                              ),
                              const SizedBox(height: 6),
                              LegendInput(
                                ctrl: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: geLoginDecoration(
                                  theme,
                                  emailState.errorMessage,
                                  hintText: "Enter your email address",
                                ),
                                error: true,
                              ),
                              SizedBox(
                                height: emailValid ? 16 : 8,
                              ),
                              LegendText(
                                "Password",
                                style: theme.typography.h1,
                                color: theme.colors.foreground2,
                              ),
                              const SizedBox(height: 6),
                              LegendInput(
                                ctrl: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: geLoginDecoration(
                                  theme,
                                  passwordState.errorMessage,
                                  hintText: "Enter your password",
                                ),
                              ),
                              SizedBox(
                                height: passwordValid ? 16 : 12,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  LegendCheckbox(
                                    borderRadius: BorderRadius.circular(4),
                                    initalValue: ref.read(rememberMeProvider),
                                    onChanged: (value) {
                                      ref
                                          .read(rememberMeProvider.notifier)
                                          .state = value;
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  LegendText(
                                    "Remember me",
                                    style: theme.typography.h1,
                                    color: theme.colors.foreground2,
                                  ),
                                  const Spacer(),
                                  LegendText(
                                    "Recover password",
                                    style: theme.typography.h1.copyWith(
                                      color: theme.colors.primary,
                                    ),
                                    //   hoverColor: theme.colors.selection,
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 48,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOutExpo,
                                  opacity: authErrorMessage == null ? 0 : 1,
                                  child: LegendText(
                                    authErrorMessage,
                                    style: theme.typography.h1,
                                    color: theme.colors.error,
                                  ),
                                ),
                              ),
                              LegendButton(
                                background: theme.colors.primary,
                                borderRadius: theme.sizing.radius1.asRadius(),
                                height: 56,
                                selBackground: theme.colors.selection,
                                onTap: () => _signIn(
                                  ref,
                                  emailController,
                                  passwordController,
                                  context,
                                ).then((success) {
                                  if (success) {
                                    l.LegendRouter.of(context).popPage();
                                  }
                                }),
                                text: LegendText(
                                  "Login",
                                  style: theme.typography.h2,
                                  color: theme.colors.background2,
                                  selectable: false,
                                ),
                              ),
                              spacer,
                              Center(
                                child: LegendRichText(
                                  text: [
                                    RichTextItem(
                                      text: "Don't have an account? ",
                                      style: theme.typography.h1,
                                    ),
                                    RichTextItem(
                                        text: "Sign up",
                                        style: theme.typography.h1.copyWith(
                                            color: theme.colors.primary),
                                        hoverColor: theme.colors.selection,
                                        onTap: () => l.LegendRouter.of(context)
                                            .replacePage(SignUpScreen.route)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: SmartBackButton(),
            ),
          ],
        );
      },
    );
  }
}
