import 'package:flutter/material.dart';
import 'package:flutter_assignment/providers/dashborad_controller.dart';
import 'package:flutter_assignment/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: DashboardController()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
          useMaterial3: true,
        ),
        home: const DashboardScreen(),
        builder: (context, child) => ResponsiveWrapper.builder(
              child,
              maxWidth: 1200,
              minWidth: 420,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(470, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              mediaQueryData: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.02)),
            ));
  }
}
