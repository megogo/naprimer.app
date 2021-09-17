import 'package:naprimer_app_v2/services/networking/abstract_network_service.dart';

abstract class AbstractBaseRepository {
  final AbstractNetworkService networkService;

  AbstractBaseRepository({required this.networkService});
}
