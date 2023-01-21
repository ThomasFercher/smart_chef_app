import 'package:flutter/material.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_widgets/input/text/paragraph/legendParagraph.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LegendRouteBody(
      builder: (context, s) {
        final theme = LegendTheme.of(context);
        final headline = ParagraphType(theme.typography.h5, bottom: 12);
        final subHeadline = ParagraphType(theme.typography.h4, bottom: 12);
        final subSubHeadline = ParagraphType(theme.typography.h3, bottom: 12);
        final text = ParagraphType(theme.typography.h1, bottom: 24);
        return Container(
          padding: EdgeInsets.all(theme.sizing.spacing2),
          decoration: BoxDecoration(
            color: theme.colors.background2,
            borderRadius: BorderRadius.circular(
              theme.sizing.radius1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LegendParagraph(
                values: {
                  headline: "Getting Started",
                  text.withId:
                      "Hi and welcome to Legend Design. To get started please look at the /config folder in your project files. There you will find the two most important files in the Legend Design ecosystem. For a more detailled version of this please head to our Website.",
                  subHeadline.withId: "Typography ",
                  text.withId:
                      "All information about your Typograpgy will be defined in the buildTypography() Method of your ThemeInterface. Colors can be defined in Color Theme and the Font Sizes in your Sizing Theme.",
                  subHeadline.withId: "Color Themes",
                  text.withId:
                      "These can be defined in the buildColorTheme() Method of your ThemeInterface, which in this case is the AppTheme Class in the theme.dart File. This Method returns a object of Type LegendColorTheme. This object you can pass a List of LegendPalette, which will be all the Color Themes of your App.",
                  subSubHeadline.withId: "LegendPalette",
                  text.withId:
                      "This is the object you will be able to access in your application code. It consists of a few required fields and also has a build Method which returns Sub Themes for Components. These are not required but will be initalized with default values consisting of the required fields.",
                  subHeadline.withId: "Sizing Themes",
                  text.withId:
                      "These can be defined in the buildSizingTheme() Method of your ThemeInterface, which in this case is the AppTheme Class in the theme.dart File. This Method returns a LegendSizingTheme which consists of a default LegendSizing and Overrides for each defined Screen Breakpoint. The default LegendSizing is required but the overrides are not.",
                  subSubHeadline.withId: "LegendSizing",
                  text.withId:
                      "This is the object you will be able to access in your application code. It consists of a few required fields and also has a build Method which returns Sub Themes for Components. These are not required but will be initalized with default values consisting of the required fields.",
                  subHeadline.withId: "Routing",
                  text.withId:
                      "All of your Applications Routes are defined in the buildRoutes() Method in the routes.dart File. ",
                  subSubHeadline.withId: "Page Route",
                  text.withId:
                      "These are Routes which represent Pages in your App. These will also be displayed in your Menus all over the app (AppBar, Sider, BottomBar & Menudrawer).",
                  subSubHeadline.withId: "Modal Route",
                  text.withId:
                      "These are Routes which represent Modals in your App. For Example the Menudrawer & the Settings Drawer are a Modal Route.",
                  subSubHeadline.withId: "Custom Route",
                  text.withId:
                      "For Custom Logic you can just extend the LegendRouteInfo Class or even PageInfo or ModalRouteInfo.",
                  subHeadline.withId: "Route Config",
                  text.withId:
                      "Each LegendRouteInfo gets passed a ScaffoldRouteConfig. This Class contains Route specific Information such as, Scaffold Whether, Builders and Layout. The Route Layouts itself are defined in the buildLayouts() Method.",
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
