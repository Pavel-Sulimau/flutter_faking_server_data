const String newsApiKey = String.fromEnvironment(
  'NEWS_API_KEY',
  defaultValue: 'fd24f74a042b4a988fc276182fcfce87', // you can use my key or override it with yours
);

const String networkProxy = String.fromEnvironment(
  'NETWORK_PROXY',
  defaultValue: '',
);
