import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitUp
  ]);
  runApp(
    const ProviderScope(
      child: MainApp()
    )
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}



class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver( this );
    ref.read( permissionsProvider.notifier ).checkPermissions();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver( this );
    super.dispose();
  
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    // print('State: $state');
    ref.read( appStateProvider.notifier ).state = state;
    if( state == AppLifecycleState.resumed ){
      ref.read( permissionsProvider.notifier ).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme().getTheme(),
   
    );
  }
}
