import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storyteller/util/routes/routes_constants.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String currentLocation = GoRouterState.of(context).path ?? "";

    switch (currentLocation) {
      case RouteConstants.home:
        _selectedIndex = 0;
        break;
      case RouteConstants.search:
        _selectedIndex = 1;
        break;
      case RouteConstants.addScreen:
        _selectedIndex = 2;
        break;
      case RouteConstants.profile:
        _selectedIndex = 3;
        break;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: widget.child,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Card(
              elevation: 5,
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => context.go(RouteConstants.home),
                      child: Icon(
                        Icons.home_rounded,
                        color: _selectedIndex == 0
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(RouteConstants.search),
                      child: Icon(
                        Icons.search_rounded,
                        color: _selectedIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(RouteConstants.addScreen),
                      child: Icon(
                        Icons.history_edu_rounded,
                        color: _selectedIndex == 2
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(RouteConstants.profile),
                      child: Icon(
                        Icons.person_2_rounded,
                        color: _selectedIndex == 3
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
