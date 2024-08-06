import 'package:provider/provider.dart';
import 'package:storyteller/screens/login/login_provider.dart';
import 'main_app.dart';

class AppProviders {
  static MultiProvider build() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MainApp(),
    );
  }
}
