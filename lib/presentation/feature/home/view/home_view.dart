import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mspr_coffee_app/presentation/app/app_route.dart';

class HomeView extends StatefulWidget {
  final int index;
  const HomeView({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final _pageController = PageController(initialPage: widget.index);

  late int _currentPage = widget.index;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _pageController.jumpToPage(widget.index);
  }

  void _onPageChanged() =>
      setState(() => _currentPage = _pageController.page!.toInt());

  SvgPicture svgIcon(String src, {Color? color}) {
    return SvgPicture.asset(
      src,
      height: 24,
      color: color ??
          Theme.of(context).iconTheme.color!.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 64,
        width: 64,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () => context.goNamed(AppRoute.settings.name),
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Iconsax.add,
                color: Theme.of(context).scaffoldBackgroundColor, size: 40),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 20 / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentPage,
          onTap: (index) => context
              .goNamed(AppRoute.home.name, params: {'index': index.toString()}),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon:
                  Icon(Iconsax.home, color: Theme.of(context).iconTheme.color!),
              activeIcon:
                  Icon(Iconsax.home, color: Theme.of(context).primaryColor),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.chart,
                  color: Theme.of(context).iconTheme.color!),
              activeIcon:
                  Icon(Iconsax.chart, color: Theme.of(context).primaryColor),
              label: "Analytics",
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Iconsax.user, color: Theme.of(context).iconTheme.color!),
              activeIcon:
                  Icon(Iconsax.user, color: Theme.of(context).primaryColor),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [],
      ),
    );
  }
}
