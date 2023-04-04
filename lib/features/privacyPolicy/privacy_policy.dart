import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/state/legend_state.dart';

/*
Privacy Policy

Last updated: [DATE]

Smartchef ("we", "us", or "our") is committed to protecting the privacy of our users ("you", "your"). This Privacy Policy outlines the types of information we collect, how we use and protect it, and your rights and choices regarding your information when using our Smartchef Cooking Assistant (the "Service"), which is powered by OpenAI.

By accessing or using the Service, you agree to this Privacy Policy. If you do not agree to this Privacy Policy, please do not use the Service.

1. Information We Collect

a. Personal Information

When you interact with the Service, we may collect personal information, which is information that can be used to identify you individually, such as your name, email address, and phone number.

b. Non-Personal Information

We may also collect non-personal information, which is information that cannot be used to identify you individually, such as your device type, browser type, language preferences, and usage data (including recipes searched, cooking preferences, and dietary restrictions). This information helps us understand how our users engage with the Service and allows us to improve the Service.

2. How We Use Your Information

We use the information we collect to:

- Provide, maintain, and improve the Service;
- Respond to your inquiries and provide customer support;
- Analyze usage patterns and trends to enhance the user experience and improve the Service;
- Personalize the content and features of the Service based on your preferences;
- Communicate with you about updates, promotions, and other news related to the Service;
- Protect the security and integrity of the Service; and
- Fulfill any other purpose for which you provided the information.

3. Information Sharing and Disclosure

We may share your information with third parties in the following circumstances:

- With our service providers who perform services on our behalf, such as hosting or data storage services;
- With OpenAI, which powers our Service, to improve their technology and provide better service;
- If required by law or in response to legal processes, such as subpoenas or court orders;
- In connection with a merger, acquisition, or sale of assets, in which case the successor entity would be bound by this Privacy Policy;
- To protect our rights, property, or the safety of our users or the public; and
- With your consent or at your direction.

4. Data Security

We take the security of your information seriously and implement appropriate technical and organizational measures to protect your information against unauthorized access, loss, theft, or misuse. However, no method of data transmission or storage is completely secure, so we cannot guarantee the absolute security of your information.

5. Your Rights and Choices

You may have certain rights under applicable privacy laws, including the right to access, correct, or delete your personal information. To exercise these rights, please contact us at [CONTACT EMAIL].

6. Third-Party Links

The Service may contain links to third-party websites, products, or services. We are not responsible for the privacy practices or content of these third parties, and this Privacy Policy does not apply to their information practices.

7. Changes to This Privacy Policy

We may update this Privacy Policy from time to time to reflect changes in our practices or applicable laws. We will provide notice of any material changes by updating the "Last updated" date at the top of this Privacy Policy. Your continued use of the Service after an update constitutes your acceptance of the revised Privacy Policy.

8. Contact Us

If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at [CONTACT EMAIL].
  
  */

class PrivacyPolicyPage extends LegendWidget {
  static String route = "/privacy-policy";
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    const spacer = SizedBox(height: 16);
    const spacer2 = SizedBox(height: 32);
    return LegendRouteBody(
      builder: (context, s) {
        return Container();
      },
    );
  }
}
