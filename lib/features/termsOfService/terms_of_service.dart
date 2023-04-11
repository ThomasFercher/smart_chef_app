import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/input/text/paragraph/legendParagraph.dart';

/*
Terms of Use

1. Acceptance of Terms

Welcome to Smartchef, an AI-powered Cooking Assistant (hereinafter referred to as "Smartchef", "we", "us", or "our"). By accessing, using, or participating in the Smartchef platform (which includes the website, mobile application, or any other services provided by Smartchef), you ("User", "you", or "your") agree to be bound by these Terms of Use ("Terms"). Please read these Terms carefully before using the services provided by Smartchef.

If you do not agree to these Terms, you are not authorized to access or use the Smartchef platform. We reserve the right to modify, update or change these Terms at any time, and it is your responsibility to review these Terms regularly.

2. Eligibility

By using the Smartchef platform, you affirm that you are at least 18 years of age or older, or have the consent of a parent or guardian if you are under 18 years old. You also represent that you have the legal capacity to enter into these Terms.

3. Description of Service

Smartchef is an AI-powered Cooking Assistant designed to provide you with personalized recipe recommendations, cooking guidance, and other related services. We strive to offer accurate and reliable
information, but we cannot guarantee the completeness or accuracy of the information provided. The use of Smartchef services is at your own risk, and we are not responsible for any errors or inaccuracies in the content.

4. User Accounts

To use certain features of Smartchef, you may need to create a user account. You are responsible for maintaining the confidentiality of your account credentials and for any activities that occur under your account. You agree to provide accurate and complete information when creating your account and to keep this information up-to-date. You must notify Smartchef immediately if you suspect any unauthorized access or use of your account.

5. User Content

Smartchef may allow you to submit, post, or share content, including recipes, images, comments, or other materials ("User Content"). By submitting User Content, you grant Smartchef a non-exclusive, worldwide, royalty-free, sublicensable, and transferable license to use, reproduce, modify, distribute, and display your User Content in connection with the Smartchef platform and its services.

You represent and warrant that you have the necessary rights and permissions to submit your User Content and that your User Content does not violate any intellectual property rights, privacy rights, or any other rights of third parties.

6. Prohibited Conduct

You agree not to use the Smartchef platform for any unlawful purposes or engage in any prohibited conduct, including but not limited to:

- Submitting false or misleading information;
- Harassing, threatening, or abusing other users;
- Violating any applicable laws or regulations;
- Spamming, phishing, or engaging in any other fraudulent activities;
- Attempting to interfere with, compromise, or disrupt the Smartchef platform or its services;
- Reverse engineering, decompiling, or disassembling any part of the Smartchef platform;
- Infringing on the intellectual property rights of Smartchef or any third parties.

7. Intellectual Property

All content and materials on the Smartchef platform, including but not limited to text, graphics, logos, images, and software, are the property of Smartchef or its licensors and are protected by copyright, trademark, and other intellectual property laws. You may not copy, reproduce, distribute, or create derivative works from such content without the express written permission of Smartchef or its licensors.

8. Disclaimer of Warranties

The Smartchef platform and its services are provided "as is" and without warranties of any kind, either express or implied. Smartchef disclaims all warranties, including but not limited to, implied warranties of merchantability, fitness for a particular purpose, and non-infringement.

9. Limitation of Liability

In no event shall Smartchef, its affiliates, or their respective officers, directors, employees, or agents be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the Smartchef platform or its services, even if advised of the possibility of such damages. In no event shall Smartchef's total liability to you for all damages, losses, or causes of action exceed the amount paid by you, if any, for accessing or using the Smartchef platform.

10. Indemnification

You agree to indemnify, defend, and hold harmless Smartchef, its affiliates, and their respective officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, or expenses, including reasonable attorneys' fees, arising out of or in connection with your use of the Smartchef platform or its services, your violation of these Terms, or your infringement of any intellectual property or other rights of any third party.

11. Termination

Smartchef reserves the right, in its sole discretion, to terminate your access to the Smartchef platform and its services, without notice, for any reason or no reason, including but not limited to your violation of these Terms.

12. Governing Law

These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which Smartchef is located, without regard to its conflict of law provisions. You agree to submit to the personal and exclusive jurisdiction of the courts located within that jurisdiction for the resolution of any disputes arising out of or relating to these Terms.

13. Contact Information

If you have any questions, concerns, or comments about these Terms or the Smartchef platform, please contact us at [email protected]

14. Entire Agreement

These Terms, together with any other legal notices and agreements published by Smartchef, constitute the entire agreement between you and Smartchef concerning your use of the Smartchef platform and its services, and supersede all prior or contemporaneous communications, whether electronic, oral, or written, between you and Smartchef.


*/

class TermsOfServicePage extends LegendWidget {
  static String route = "/terms-of-service";
  const TermsOfServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    const spacer = SizedBox(height: 16);
    const spacer2 = SizedBox(height: 32);

    final heading = ParagraphType(theme.typography.h4);
    final body = ParagraphType(theme.typography.h1);

    return LegendRouteBody(
      children: (controller, s) {
        return [
          LegendText(
            "Terms of Service",
            style: theme.typography.h5,
          ),
          LegendParagraph(
            "Welcome to Smartchef, an AI-powered Cooking Assistant (hereinafter referred to as \"Smartchef\", \"we\", \"us\", or \"our\"). By accessing, using, or participating in the Smartchef platform (which includes the website, mobile application, or any other services provided by Smartchef), you (\"User\", \"you\", or \"your\") agree to be bound by these Terms of Use (\"Terms\"). Please read these Terms carefully before using the services provided by Smartchef.\n\nIf you do not agree to these Terms, you are not authorized to access or use the Smartchef platform. We reserve the right to modify, update or change these Terms at any time, and it is your responsibility to review these Terms regularly."
                as List<PEntry>,
            // values: {
            //   heading: "1. Acceptance of Terms",
            //   body:
            //       "Welcome to Smartchef, an AI-powered Cooking Assistant (hereinafter referred to as \"Smartchef\", \"we\", \"us\", or \"our\"). By accessing, using, or participating in the Smartchef platform (which includes the website, mobile application, or any other services provided by Smartchef), you (\"User\", \"you\", or \"your\") agree to be bound by these Terms of Use (\"Terms\"). Please read these Terms carefully before using the services provided by Smartchef.\n\nIf you do not agree to these Terms, you are not authorized to access or use the Smartchef platform. We reserve the right to modify, update or change these Terms at any time, and it is your responsibility to review these Terms regularly.",
            //   heading.withId: "asdasd"
            // },
          ),
        ];
      },
    );
  }
}
