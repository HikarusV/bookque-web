import 'package:bisnisinformatika/book_item.dart';
import 'package:bisnisinformatika/custom_button.dart';
import 'package:bisnisinformatika/fetch_random_data.dart';
import 'package:bisnisinformatika/items.dart';
import 'package:bisnisinformatika/scroll_behavior.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late Size _lastSize;
  bool miniSideBar = false;
  List<Items> randomItems = [];
  List<Items> newsItems = [];

  @override
  void initState() {
    FetchData.fetchRandomData().then((value) {
      List<Items> buffer = [];

      if (!value['error']) {
        for (Map<String, dynamic> i in value['items']) {
          buffer.add(Items.fromMap(i));
        }
        setState(() {
          randomItems = buffer;
        });
      }
    });

    FetchData.fetchRandomData().then((value) {
      List<Items> buffer = [];

      if (!value['error']) {
        for (Map<String, dynamic> i in value['items']) {
          buffer.add(Items.fromMap(i));
        }
        setState(() {
          newsItems = buffer;
        });
      }
    });
    _lastSize = WidgetsBinding.instance.window.physicalSize;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _lastSize = WidgetsBinding.instance.window.physicalSize;
    });
  }

  List<Widget> views = const [
    Center(
      child: Text('Dashboard'),
    ),
    Center(
      child: Text('Account'),
    ),
    Center(
      child: Text('Settings'),
    ),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 0,
            child: AnimatedContainer(
              width: ((_lastSize.width > 900) && !miniSideBar) ? 160 : 90,
              height: _lastSize.height,
              color: const Color(0xFF4c4452),
              duration: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                    ),
                    radius: 32,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    onlyIcon: !((_lastSize.width > 900) && !miniSideBar),
                    icon: Icons.search,
                    title: 'Search',
                    onTap: () => '',
                  ),
                  CustomButton(
                    isSelected: true,
                    onlyIcon: !((_lastSize.width > 900) && !miniSideBar),
                    title: 'Dashboard',
                    icon: Icons.dashboard,
                    onTap: () => '',
                  ),
                  CustomButton(
                    onlyIcon: !((_lastSize.width > 900) && !miniSideBar),
                    icon: Icons.book,
                    title: 'My Book',
                    onTap: () => '',
                  ),
                  CustomButton(
                    onlyIcon: !((_lastSize.width > 900) && !miniSideBar),
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () => '',
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  (_lastSize.width > 900)
                      ? CustomButton(
                          onlyIcon: true,
                          icon: miniSideBar
                              ? Icons.arrow_forward_ios
                              : Icons.arrow_back_ios,
                          onTap: () => setState(() {
                            miniSideBar = !miniSideBar;
                          }),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // children: [BookItem(listData: items)],
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    width: _lastSize.width,
                    height: 296,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1414124488080-0188dcbb8834?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  BookItem(
                    listData: randomItems,
                    title: 'Rekomendasi Buku',
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  BookItem(
                    listData: newsItems,
                    title: 'Buku Terbaru',
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
