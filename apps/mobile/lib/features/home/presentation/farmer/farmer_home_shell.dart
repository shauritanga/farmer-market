import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/features/home/presentation/farmer/home_overview_page.dart';
import 'package:fama/features/home/presentation/farmer/more_page.dart';
import 'package:fama/features/market_prices/presentation/pages/market_prices_page.dart';
import 'package:fama/features/orders/presentation/pages/my_orders_page.dart';
import 'package:fama/features/produce/presentation/pages/my_produce_page.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Bottom-nav shell for the Farmer role: Home, Market, Produce, Orders,
/// More. Lives under `presentation/farmer/` rather than flat in
/// `presentation/pages/` — Buyer and Transporter will each get their own
/// `presentation/buyer/`, `presentation/transporter/` sibling with the
/// same shape (a `<Role>HomeShell` + its role-specific composite tabs)
/// once they're built, so this stays easy to tell apart at a glance
/// instead of one flat pile of same-pattern files. `home/presentation/pages/`
/// stays reserved for the role-dispatcher itself (`home_page.dart`).
/// Domain tabs (Market, Produce, Orders) are not role-specific and stay in
/// their own top-level feature folders, unaffected by this.
class FarmerHomeShell extends StatefulWidget {
  const FarmerHomeShell({super.key});

  @override
  State<FarmerHomeShell> createState() => _FarmerHomeShellState();
}

class _FarmerHomeShellState extends State<FarmerHomeShell> {
  int _index = 0;

  void _goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final pages = [
      HomeOverviewPage(onNavigateToTab: _goToTab),
      const MarketPricesPage(),
      const MyProducePage(),
      const MyOrdersPage(),
      const MorePage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        height: 64.h,
        selectedIndex: _index,
        onDestinationSelected: _goToTab,
        destinations: [
          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedAnalytics01),
            label: l10n.navMarket,
          ),
          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedStore01),
            label: l10n.navProduce,
          ),
          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedInvoice01),
            label: l10n.navOrders,
          ),
          NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedMenu01),
            label: l10n.navMore,
          ),
        ],
      ),
    );
  }
}
