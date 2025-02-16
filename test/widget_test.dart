import './core/router/app_router_test.dart' as router;
import './data/datasources/local_data_source_test.dart' as datasource;
import './domain/entities/entities.dart' as entities;

void main() {
  router.main();
  datasource.main();
  entities.main();
}
