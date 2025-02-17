import './core/router/app_router_test.dart' as router;
import './data/datasources/local_data_source_test.dart' as datasource;
import './domain/entities/entities.dart' as entities;
import './presentation/pages/pages_test.dart' as pages;
import './presentation/presenters/address_list_presenter_test.dart'
    as praddress_list_presenter;

void main() {
  router.main();
  datasource.main();
  entities.main();
  pages.main();
  praddress_list_presenter.main();
}
