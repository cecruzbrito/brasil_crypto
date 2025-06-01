enum KeysEnv {
  apiKey;

  String get key => switch (this) {
    KeysEnv.apiKey => "api_key",
  };
}
