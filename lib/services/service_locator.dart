import 'package:get_it/get_it.dart';

import '../repositories/api_repository.dart';
import 'navigation_service.dart';

GetIt serviceLocator = GetIt.instance;

final navigationService = serviceLocator<NavigationService>();
final apicall = serviceLocator<ApiRepository>();
//creating object globally

Future<void> setupServiceLocator() async {
  serviceLocator.registerSingleton(NavigationService());
  serviceLocator.registerSingleton(ApiRepository());
}
