import '../domain/entities/sale_catalog.dart';
import '../domain/repositories/sale_repository.dart';
import 'sale_local_data_source.dart';

class SaleRepositoryImpl implements SaleRepository {
  const SaleRepositoryImpl(this._dataSource);

  final SaleLocalDataSource _dataSource;

  @override
  Future<SaleCatalog> loadCatalog() => _dataSource.loadCatalog();

  @override
  Future<String> save(NewSale sale) => _dataSource.save(sale);
}
