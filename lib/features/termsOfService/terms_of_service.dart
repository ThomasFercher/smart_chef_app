import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/state/legend_state.dart';
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

    final heading = ParagraphType(
      theme.typography.h3,
      margin: const EdgeInsets.only(bottom: 12, top: 24),
    );
    final heading2 = ParagraphType(
      theme.typography.h4,
      margin: const EdgeInsets.only(bottom: 12),
    );
    final body2 = ParagraphType(theme.typography.h2);
    final body = ParagraphType(theme.typography.h1);
    return LegendRouteBody(
      disableContentDecoration: true,
      maxContentWidth: 720,
      builder: (context, _) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1080),
            padding: const EdgeInsets.all(24),
            child: LegendParagraph(
              [
                heading2.entry("Terms of Service"),
                body2.entry(
                  "Last updated on 4th of April 2023",
                ),
                heading.entry(
                  "1. Acceptance of Terms",
                ),
                body.entry(
                  "Welcome to Smartchef, an AI-powered Cooking Assistant (hereinafter referred to as \"Smartchef\", \"we\", \"us\", or \"our\"). By accessing, using, or participating in the Smartchef platform (which includes the website, mobile application, or any other services provided by Smartchef), you (\"User\", \"you\", or \"your\") agree to be bound by these Terms of Use (\"Terms\"). Please read these Terms carefully before using the services provided by Smartchef.",
                ),
                heading.entry("2. Eligibility"),
                body.entry(
                  "By using the Smartchef platform, you affirm that you are at least 18 years of age or older, or have the consent of a parent or guardian if you are under 18 years old. You also represent that you have the legal capacity to enter into these Terms.",
                ),
                heading.entry("3. Description of Service"),
                body.entry(
                  "Smartchef is an AI-powered Cooking Assistant designed to provide you with personalized recipe recommendations, cooking guidance, and other related services. We strive to offer accurate and reliable information, but we cannot guarantee the completeness or accuracy of the information provided. The use of Smartchef services is at your own risk, and we are not responsible for any errors or inaccuracies in the content.",
                ),
                heading.entry("4. User Accounts"),
                body.entry(
                  "To use certain features of Smartchef, you may need to create a user account. You are responsible for maintaining the confidentiality of your account credentials and for any activities that occur under your account. You agree to provide accurate and complete information when creating your account and to keep this information up-to-date. You must notify Smartchef immediately if you suspect any unauthorized access or use of your account.",
                ),
                heading.entry("5. User Content"),
                body.entry(
                  "Smartchef may allow you to submit, post, or share content, including recipes, images, comments, or other materials (\"User Content\"). By submitting User Content, you grant Smartchef a non-exclusive, worldwide, royalty-free, sublicensable, and transferable license to use, reproduce, modify, distribute, and display your User Content in connection with the Smartchef platform and its services.",
                ),
                body.entry(
                  "You represent and warrant that you have the necessary rights and permissions to submit your User Content and that your User Content does not violate any intellectual property rights, privacy rights, or any other rights of third parties.",
                ),
                heading.entry("6. Prohibited Conduct"),
                body.entry(
                  "You agree not to use the Smartchef platform for any unlawful purposes or engage in any prohibited conduct, including but not limited to:",
                ),
                body.entry(
                  "- Submitting false or misleading information;",
                ),
                body.entry(
                  "- Harassing, threatening, or abusing other users;",
                ),
                body.entry(
                  "- Violating any applicable laws or regulations;",
                ),
                body.entry(
                  "- Attempting to interfere with, compromise, or disrupt the Smartchef platform or its services;",
                ),
                body.entry(
                  "- Reverse engineering, decompiling, or disassembling any part of the Smartchef platform;",
                ),
                body.entry(
                  "- Using any automated means to access the Smartchef platform or its services;",
                ),
                body.entry(
                  "- Using the Smartchef platform or its services to send spam or other unsolicited communications;",
                ),
                body.entry(
                  "- Using the Smartchef platform or its services to promote or advertise any third-party products or services;",
                ),
                body.entry(
                  "- Using the Smartchef platform or its services to collect or store personal data about other users;",
                ),
                body.entry(
                  "- Using the Smartchef platform or its services to infringe the intellectual property rights of any third party;",
                ),
                body.entry(
                  "- Using the Smartchef platform or its services to violate the privacy rights of any third party;",
                ),
                body.entry(
                  "- Using the Smartchef platform or its services to violate any other rights of any third party.",
                ),
                heading.entry("7. Intellectual Property"),
                body.entry(
                  "The Smartchef platform and its services are protected by intellectual property laws. You acknowledge and agree that the Smartchef platform and its services are the exclusive property of Smartchef and its licensors. You agree not to remove, alter, or obscure any proprietary notices (including copyright notices) on the Smartchef platform or its services.",
                ),
                heading.entry("8. Third-Party Services"),
                body.entry(
                  "The Smartchef platform may contain links to third-party websites or services that are not owned or controlled by Smartchef. Smartchef has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third-party websites or services. You further acknowledge and agree that Smartchef shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with the use of or reliance on any such content, goods, or services available on or through any such websites or services.",
                ),
                heading.entry("9. Disclaimer of Warranties"),
                body.entry(
                  "THE SMARTCHEF PLATFORM AND ITS SERVICES ARE PROVIDED \"AS IS\" AND \"AS AVAILABLE\" WITHOUT ANY WARRANTIES OF ANY KIND. SMARTCHEF EXPRESSLY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.",
                ),
                body.entry(
                  "SMARTCHEF MAKES NO WARRANTY THAT (I) THE SMARTCHEF PLATFORM OR ITS SERVICES WILL MEET YOUR REQUIREMENTS, (II) THE SMARTCHEF PLATFORM OR ITS SERVICES WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE, (III) THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF THE SMARTCHEF PLATFORM OR ITS SERVICES WILL BE ACCURATE OR RELIABLE, OR (IV) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIAL PURCHASED OR OBTAINED BY YOU THROUGH THE SMARTCHEF PLATFORM OR ITS SERVICES WILL MEET YOUR EXPECTATIONS.",
                ),
                heading.entry("10. Limitation of Liability"),
                body.entry(
                  "IN NO EVENT SHALL SMARTCHEF, ITS AFFILIATES, OR ITS LICENSORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, INCLUDING WITHOUT LIMITATION, LOSS OF PROFITS, DATA, USE, GOODWILL, OR OTHER INTANGIBLE LOSSES, RESULTING FROM (I) YOUR ACCESS TO OR USE OF OR INABILITY TO ACCESS OR USE THE SMARTCHEF PLATFORM OR ITS SERVICES, (II) ANY CONDUCT OR CONTENT OF ANY THIRD PARTY ON THE SMARTCHEF PLATFORM, INCLUDING WITHOUT LIMITATION, ANY DEFAMATORY, OFFENSIVE, OR ILLEGAL CONDUCT OF OTHER USERS OR THIRD PARTIES, (III) ANY CONTENT OBTAINED FROM THE SMARTCHEF PLATFORM, (IV) UNAUTHORIZED ACCESS, USE, OR ALTERATION OF YOUR TRANSMISSIONS OR CONTENT, OR (V) ANY OTHER MATTER RELATING TO THE SMARTCHEF PLATFORM OR ITS SERVICES, EVEN IF SMARTCHEF HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.",
                ),
                body.entry(
                  "IN NO EVENT SHALL THE AGGREGATE LIABILITY OF SMARTCHEF, ITS AFFILIATES, AND ITS LICENSORS EXCEED THE GREATER OF ONE HUNDRED DOLLARS (\$100) OR THE AMOUNT YOU HAVE PAID SMARTCHEF IN THE PAST SIX MONTHS (IF ANY) FOR THE SMARTCHEF PLATFORM OR ITS SERVICES.",
                ),
                heading.entry("11. Indemnification"),
                body.entry(
                  "You agree to defend, indemnify, and hold harmless Smartchef, its affiliates, and its licensors from and against any claims, liabilities, damages, losses, and expenses, including without limitation reasonable legal and accounting fees, arising out of or in any way connected with (i) your access to or use of the Smartchef platform or its services, (ii) your violation of these Terms of Service, (iii) your violation of any third-party right, including without limitation any intellectual property right, publicity, confidentiality, property, or privacy right, (iv) any claim that your User Content caused damage to a third party, or (v) any other matter relating to the Smartchef platform or its services.",
                ),
                heading.entry("12. Governing Law and Jurisdiction"),
                body.entry(
                    "These Terms of Service shall be governed by and construed in accordance with the laws of the State of California, without regard to its conflict of law provisions."),
                body.entry(
                    "You and Smartchef agree to submit to the personal and exclusive jurisdiction of the courts located within the county of San Francisco, California."),
                heading.entry("13. Severability"),
                body.entry(
                    "If any provision of these Terms of Service is held to be unenforceable or invalid, such provision will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law and the remaining provisions will continue in full force and effect."),
                heading.entry("14. Entire Agreement"),
                body.entry(
                    "These Terms of Service constitute the sole and entire agreement between you and Smartchef regarding the Smartchef platform and supersede all prior and contemporaneous understandings, agreements, representations, and warranties, both written and oral, regarding the Smartchef platform."),
                heading.entry("15. Changes to Terms of Service"),
                body.entry(
                    "Smartchef reserves the right, at its sole discretion, to modify or replace these Terms of Service at any time. If a revision is material, Smartchef will make reasonable efforts to provide at least 30 days' notice prior to any new terms taking effect. What constitutes a material change will be determined at Smartchef's sole discretion."),
                body.entry(
                    "By continuing to access or use the Smartchef platform after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, you are no longer authorized to use the Smartchef platform."),
                heading.entry("16. Contact Us"),
                body.entry(
                  "If you have any questions about these Terms of Service, please contact us at info@smartchef.ai",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
