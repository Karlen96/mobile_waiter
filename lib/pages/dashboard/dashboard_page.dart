import 'package:flutter/material.dart';

import '../orders/orders_page.dart';
import '../tables/tables_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _pageController = PageController();
  int _currentIndex = 0;
  final _pages = <Widget>[
    const TablesPage(),
    const OrdersPage(),
  ];

  void _onChangeTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade50,
        title: Text(_currentIndex == 0 ? 'Tables' : 'History'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (_, i) => _pages[i],
        itemCount: _pages.length,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onChangeTap,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.red.shade50,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.table_bar,
            ),
            label: 'Tables',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
