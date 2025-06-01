import 'package:brasilcripto/core/services/navigation/service_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

class SpashPage extends StatefulWidget {
  const SpashPage({super.key});

  @override
  State<SpashPage> createState() => _SpashPageState();
}

class _SpashPageState extends State<SpashPage> with TickerProviderStateMixin {
  late final ctrLoading = AnimationController(vsync: this, duration: Duration(seconds: 1));
  late final tweenLoading = Tween<double>(
    begin: 1,
    end: .93,
  ).animate(CurvedAnimation(parent: ctrLoading, curve: Curves.linear));
  late final ctr = AnimationController(vsync: this, duration: Duration(seconds: 1, milliseconds: 300));

  late final tweenLogo = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: ctr,
      curve: const Interval(
        0, // começa em 30%
        0.5, // termina em 70%
        curve: Curves.easeInOut, // curva opcional
      ),
    ),
  );
  late final tweenText = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: ctr,
      curve: const Interval(
        0.5, // começa em 30%
        1, // termina em 70%
        curve: Curves.linear, // curva opcional
      ),
    ),
  );

  @override
  void dispose() {
    ctr.dispose();
    ctrLoading.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    ctr.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ctrLoading.repeat(reverse: true);
        initApp();
      }
    });

    ctr.forward();
  }

  initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = kIsWeb ? null : (await getApplicationDocumentsDirectory()).path;
    Hive.init(path);
    ServiceNavigation.nav("/home/initial_page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 84, 171),
      body: Center(
        child: AnimatedBuilder(
          animation: ctrLoading,

          builder: (_, __) {
            return AnimatedBuilder(
              animation: ctr,
              builder: (_, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    ScaleTransition(
                      scale: tweenLoading,

                      child: ScaleTransition(
                        scale: tweenLogo,
                        child: Image.asset("assets/logo.png", height: 110, fit: BoxFit.fitHeight),
                      ),
                    ),
                    FadeTransition(
                      opacity: tweenText,
                      child: Text(
                        "Brasil Crypto",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
