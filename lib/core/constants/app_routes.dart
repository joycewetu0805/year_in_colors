/// Constantes de routes pour la navigation dans l'application
class AppRoutes {
  // Routes principales
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String today = '/today';
  static const String month = '/month';
  static const String year = '/year';
  static const String settings = '/settings';
  
  // Routes de paramètres
  static const String appearance = '/settings/appearance';
  static const String language = '/settings/language';
  static const String notifications = '/settings/notifications';
  static const String backup = '/settings/backup';
  static const String about = '/settings/about';
  static const String privacy = '/settings/privacy';
  static const String terms = '/settings/terms';
  
  // Routes modales
  static const String datePicker = '/modal/date_picker';
  static const String dayDetail = '/modal/day_detail';
  static const String share = '/modal/share';
  static const String export = '/modal/export';
  static const String feedback = '/modal/feedback';
  static const String confirmation = '/modal/confirmation';
  
  // Routes d'authentification (pour évolution future)
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot_password';
  static const String profile = '/auth/profile';
  
  // Paramètres de route
  static const String paramDate = 'date';
  static const String paramMonth = 'month';
  static const String paramYear = 'year';
  static const String paramDayStatus = 'day_status';
  static const String paramSource = 'source';
  static const String paramMessage = 'message';
  static const String paramTitle = 'title';
  
  // Helper pour construire les routes avec paramètres
  static String buildRoute(String route, {Map<String, String>? params}) {
    if (params == null || params.isEmpty) {
      return route;
    }
    
    final buffer = StringBuffer(route);
    buffer.write('?');
    
    final paramList = params.entries.toList();
    for (int i = 0; i < paramList.length; i++) {
      final entry = paramList[i];
      buffer.write('${entry.key}=${Uri.encodeComponent(entry.value)}');
      if (i < paramList.length - 1) {
        buffer.write('&');
      }
    }
    
    return buffer.toString();
  }
  
  // Helper pour extraire les paramètres
  static Map<String, String> extractParams(String routeWithParams) {
    final params = <String, String>{};
    final parts = routeWithParams.split('?');
    
    if (parts.length > 1) {
      final query = parts[1];
      final pairs = query.split('&');
      
      for (final pair in pairs) {
        final keyValue = pair.split('=');
        if (keyValue.length == 2) {
          params[Uri.decodeComponent(keyValue[0])] = Uri.decodeComponent(keyValue[1]);
        }
      }
    }
    
    return params;
  }
  
  // Routes spécifiques avec paramètres prédéfinis
  static String todayWithDate(DateTime date) {
    return buildRoute(today, params: {
      paramDate: '${date.year}-${date.month}-${date.day}'
    });
  }
  
  static String monthWithDate(DateTime date) {
    return buildRoute(month, params: {
      paramYear: date.year.toString(),
      paramMonth: date.month.toString()
    });
  }
  
  static String dayDetailWithDate(DateTime date) {
    return buildRoute(dayDetail, params: {
      paramDate: '${date.year}-${date.month}-${date.day}'
    });
  }
}