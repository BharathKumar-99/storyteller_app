import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storyteller/constants/app_constants.dart';
import 'package:storyteller/screens/add_story/add_story.dart';
import 'package:storyteller/screens/home/home.dart';
import 'package:storyteller/screens/login/login.dart';
import 'package:storyteller/screens/signup/signup.dart';
import 'package:storyteller/screens/story_screen/story_screen.dart';
import 'package:storyteller/screens/tags/tags.dart';
import '../../screens/dashboard/dashboard.dart';
import '../../screens/forgot_password/forgot_password.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/search/individual_search.dart';
import '../../screens/search/search_screen.dart';
import 'routes_constants.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class Routes {
  GoRouter router = GoRouter(
    initialLocation: RouteConstants.home,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final isLoggedIn = AppConstants().isLoggedIn;
      final isGoingToLogin = state.uri.toString() == RouteConstants.login;
      final isGoingToRegister = state.uri.toString() == RouteConstants.register;
      final isGoingToForgot =
          state.uri.toString() == RouteConstants.forgotPassword;

      if (!isLoggedIn &&
          !isGoingToLogin &&
          !isGoingToRegister &&
          !isGoingToForgot) {
        return RouteConstants.login;
      } else if (!isLoggedIn &&
          !isGoingToLogin &&
          isGoingToRegister &&
          !isGoingToForgot) {
        return RouteConstants.register;
      } else if (!isLoggedIn && !isGoingToLogin && isGoingToForgot) {
        return RouteConstants.forgotPassword;
      } else if (isLoggedIn && !(AppConstants().isTagsSelected ?? true)) {
        return RouteConstants.tagScreen;
      } else if (isLoggedIn && (isGoingToLogin || isGoingToRegister)) {
        return null;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RouteConstants.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteConstants.register,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: RouteConstants.tagScreen,
        builder: (context, state) => const TagsScreen(),
      ),
      GoRoute(
        path: RouteConstants.storyScreen,
        builder: (context, state) => StoryScreen(
          storyId: state.extra as int,
        ),
      ),
      GoRoute(
        path: RouteConstants.home,
        builder: (context, state) {
          return const DashboardScreen(
            child: HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteConstants.addScreen,
        builder: (context, state) {
          return const DashboardScreen(
            child: AddStoryScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteConstants.search,
        builder: (context, state) {
          return const DashboardScreen(
            child: SearchScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteConstants.individualSearch,
        builder: (context, state) => IndividualSearchScreen(
          id: state.extra as int,
        ),
      ),
      GoRoute(
        path: RouteConstants.profile,
        builder: (context, state) {
          return const DashboardScreen(
            child: ProfileScreen(),
          );
        },
      ),
    ],
  );
}
