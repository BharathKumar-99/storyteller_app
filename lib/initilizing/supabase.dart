import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/keys_constants.dart';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
      url: KeyConstants.SUPABASE_URL,
      anonKey: KeyConstants.SUPABASE_ANON_KEY,
      authOptions: const FlutterAuthClientOptions(autoRefreshToken: true));
}
