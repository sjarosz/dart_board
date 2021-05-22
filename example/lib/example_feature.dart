import 'package:dart_board/dart_board.dart';
import 'package:dart_board_theme/theme_feature.dart';
import 'package:dart_board_debug/debug_feature.dart';
import 'package:dart_board_log/log_feature.dart';
import 'package:example/impl/decorations/animated_background_decoration.dart';
import 'package:example/impl/pages/decorations.dart';
import 'package:example/impl/pages/home_page.dart';
import 'package:example/impl/routes/custom_routes.dart';
import 'package:flutter/material.dart';
import 'impl/decorations/color_border_decoration.dart';
import 'impl/decorations/scaffold_appbar_decoration.dart';
import 'impl/pages/about.dart';
import 'impl/pages/features.dart';
import 'impl/pages/haiku_and_code.dart';

/// The Example Feature
///
/// A feature is a set of capabilities you would like to add to an app.
/// For this example, we re going to provide a few things.
///
/// 1) Routes
/// 2) Page Decorations and Config
/// 3) Feature Dependencies
class ExampleFeature extends DartBoardFeature {
  /// These are the Routes were are going to Provide.
  ///
  /// We can use the NamedRouteDefinition() to provide
  /// simple named routes
  ///
  /// We can also apply custom route builders, e.g. the Spin
  /// applied to the /home route
  @override
  List<RouteDefinition> get routes => <RouteDefinition>[
        NamedRouteDefinition(
            routeBuilder: kSpinRoute,
            route: '/home',
            builder: (ctx, settings) => HomePage()),
        NamedRouteDefinition(
            route: '/about', builder: (ctx, settings) => AboutPage()),
        NamedRouteDefinition(
            route: '/features', builder: (ctx, settings) => FeaturesPage()),
        NamedRouteDefinition(
            route: '/decorations',
            builder: (ctx, settings) => DecorationsPage()),
        NamedRouteDefinition(
            route: '/routing',
            builder: (ctx, settings) => HaikuAndCode(
                  haiku: 'asddsadsa',
                  url:
                      'https://raw.githubusercontent.com/ahammer/dart_board/master/example/lib/main.dart',
                ))
      ];

  /// These are page-scoped decorations
  @override
  List<PageDecoration> get pageDecorations => <PageDecoration>[
        /// The AppBar and Nav Drawer
        PageDecoration(
            name: 'scaffold_and_drawer',
            decoration: (context, child) => ScaffoldWithDrawerDecoration(
                child: DarkColorBorder(child: child))),

        /// The animated background effect
        PageDecoration(
            name: 'animated_background',
            decoration: (context, child) => AnimatedBackgroundDecoration(
                  color: Theme.of(context).accentColor,
                  child: child,
                ))
      ];

  @override
  List<DartBoardFeature> get dependencies =>
      [ThemeFeature(), DebugFeature(), LogFeature()];

  @override
  List<String> get pageDecorationDenyList => ['/log:scaffold_and_drawer'];

  @override
  String get namespace => 'example';
}