import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_backbutton.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/rich/legend_rich_text.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/datadisplay/avatar/legend_avatar.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_design_widgets/input/text/legendInputDecoration.dart';
import 'package:legend_design_widgets/input/text/legendTextField.dart';
import 'package:smart_chef_app/features/signIn/widgets/backbutton.dart';
import 'package:smart_chef_app/features/signIn/widgets/legend_checkbox.dart';
import 'package:smart_chef_app/features/signIn/widgets/legend_input.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';

double getTextHeight(TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: 'a', style: style),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size.height;
}

enum EmailValidation {
  valid,
  invalid,
  empty,

  none;

  String? get errorMessage {
    switch (this) {
      case EmailValidation.valid:
        return null;
      case EmailValidation.invalid:
        return "Invalid email";
      case EmailValidation.empty:
        return "Email is required";
      case EmailValidation.none:
        return null;
    }
  }
}

enum PasswordValidation {
  valid,
  toShort,
  toLong,
  noNumberAndSpecialChar,
  empty,
  none;

  String? get errorMessage {
    switch (this) {
      case PasswordValidation.valid:
        return null;
      case PasswordValidation.toShort:
        return "Password must be at least 8 characters";
      case PasswordValidation.noNumberAndSpecialChar:
        return "Password must contain at least one number and one special character";
      case PasswordValidation.empty:
        return "Password is required";
      case PasswordValidation.toLong:
        return "Password must be at most 64 characters";
      case PasswordValidation.none:
        return null;
    }
  }
}

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

class SignInScreen extends HookConsumerWidget {
  static String route = "/signin";

  const SignInScreen({Key? key}) : super(key: key);

  Future<bool> _submit(
    WidgetRef ref,
    TextEditingController emailCtrl,
    TextEditingController passwordCtrl,
    BuildContext context,
  ) async {
    final email = emailCtrl.text;
    final password = passwordCtrl.text;
    final emailValidation = _validateEmail(email);
    final passwordValidation = _validatePassword(password);

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

      return state is Authenticated;
    }
    return false;
  }

  EmailValidation _validateEmail(String email) {
    if (email.isEmpty) {
      return EmailValidation.empty;
    }
    final RegExp regex = RegExp(
      r"^[\w!#$%&'*+/=?`{|}~^-]+(?:\.[\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}$",
    );
    if (!regex.hasMatch(email)) return EmailValidation.invalid;

    return EmailValidation.valid;
  }

  PasswordValidation _validatePassword(String password) {
    if (password.isEmpty) return PasswordValidation.empty;
    if (password.length < 8) return PasswordValidation.toShort;
    if (password.length > 64) return PasswordValidation.toLong;

    final RegExp numberSpecialChar = RegExp(
      r'^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d).+$',
    );

    if (!numberSpecialChar.hasMatch(password)) {
      return PasswordValidation.noNumberAndSpecialChar;
    }

    return PasswordValidation.valid;
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
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/illustrations/sign_in.svg",
                          width: 400,
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
                                decoration: geLoginDecoration(
                                  theme,
                                  emailState.errorMessage,
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
                                    initalValue: true,
                                    onChanged: (value) {
                                      print(value);
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
                                onTap: () => _submit(
                                  ref,
                                  emailController,
                                  passwordController,
                                  context,
                                ).then((success) {
                                  if (success) {
                                    LegendRouter.of(context).popPage();
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

LegendInputDecoration geLoginDecoration(
        LegendTheme theme, String? errorMessage) =>
    LegendInputDecoration(
      errorText: errorMessage,
      cursorColor: theme.colors.selection,
      errorStyle: theme.typography.h0.copyWith(
        color: theme.colors.error,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.error,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.foreground4,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.foreground4,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.selection,
          width: 2,
        ),
      ),
    );
