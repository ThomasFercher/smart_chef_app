import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/rich/legend_rich_text.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/auth/signIn/signIn.dart';
import 'package:smart_chef_app/features/auth/state/auth_process_state.dart';
import 'package:smart_chef_app/features/auth/widgets/backbutton.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_chef_app/features/auth/widgets/success_dialog.dart';
import 'package:smart_chef_app/features/privacyPolicy/privacy_policy.dart';
import 'package:smart_chef_app/features/termsOfService/terms_of_service.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
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

class SignUpScreen extends HookConsumerWidget {
  static String route = "/signup";

  const SignUpScreen({Key? key}) : super(key: key);

  Future<bool> _signUp(
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

    if (emailValidation != EmailValidation.valid ||
        passwordValidation != PasswordValidation.valid) return false;

    try {
      return await ref.read(authProvider.notifier).register(email, password);
    } on AuthException catch (e) {
      ref.read(authstateProvider.notifier).state = e.message;
      return false;
    } catch (e) {
      ref.read(authstateProvider.notifier).state = e.toString();
      return false;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    const spacer = SizedBox(height: 16);
    const spacer2 = SizedBox(height: 24);
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
                                  "Create an account",
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
                                decoration: geLoginDecoration(
                                  theme,
                                  passwordState.errorMessage,
                                  hintText: "Enter your password",
                                ),
                              ),
                              SizedBox(
                                height: passwordValid ? 16 : 12,
                              ),
                              AnimatedContainer(
                                alignment: Alignment.center,
                                duration: const Duration(milliseconds: 200),
                                height: authErrorMessage == null ? 16 : 48,
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
                                onTap: () => _signUp(
                                  ref,
                                  emailController,
                                  passwordController,
                                  context,
                                ).then((success) {
                                  if (!success) return;
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        const RegistrationSuccessDialog(),
                                  ).then(
                                    (_) => LegendRouter.of(context).popPage(),
                                  );
                                }),
                                text: LegendText(
                                  "Get Started",
                                  style: theme.typography.h2,
                                  color: theme.colors.background2,
                                  selectable: false,
                                ),
                              ),
                              spacer,
                              LegendRichText(
                                text: [
                                  RichTextItem(
                                    text:
                                        "By clicking Get Started, you agree to our",
                                    style: theme.typography.h0,
                                  ),
                                  RichTextItem(
                                    text: "Terms of Service",
                                    style: theme.typography.h0
                                        .copyWith(color: theme.colors.primary),
                                    hoverColor: theme.colors.selection,
                                    onTap: () => LegendRouter.of(context)
                                        .pushPage(TermsOfServicePage.route),
                                  ),
                                  RichTextItem(
                                    text: "and",
                                    style: theme.typography.h0,
                                  ),
                                  RichTextItem(
                                    text: "Privacy Policy",
                                    style: theme.typography.h0
                                        .copyWith(color: theme.colors.primary),
                                    hoverColor: theme.colors.selection,
                                    onTap: () => LegendRouter.of(context)
                                        .pushPage(PrivacyPolicyPage.route),
                                  ),
                                ],
                              ),
                              spacer2,
                              Center(
                                child: LegendRichText(
                                  text: [
                                    RichTextItem(
                                      text: "Already have an account?",
                                      style: theme.typography.h1,
                                    ),
                                    RichTextItem(
                                      text: "Sign In",
                                      style: theme.typography.h1.copyWith(
                                          color: theme.colors.primary),
                                      hoverColor: theme.colors.selection,
                                      onTap: () => LegendRouter.of(context)
                                          .replacePage(SignInScreen.route),
                                    ),
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
