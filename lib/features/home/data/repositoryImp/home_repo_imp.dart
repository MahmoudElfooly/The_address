import 'package:dartz/dartz.dart';
import 'package:the_address/core/networkService/models/api_request_failur.dart';
import 'package:the_address/features/home/data/models/category_model.dart';
import 'package:the_address/features/home/data/models/producte_model.dart';
import 'package:the_address/features/home/domain/repository/home_repository.dart';

import '../dataSource/remoteServices/home_remote_services.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteServices _homeRemoteServices = HomeRemoteServices();

  @override
  Future<Either<ApiRequestFailure, List<CategoryItemModel>>>
      getCategories() async {
    final response = await _homeRemoteServices.getCategories();
    return response.fold((error) {
      return left(ApiRequestFailure(failureMsg: error.failureMsg));
    }, (data) async {
      return right(data);
    });
  }

  @override
  Future<Either<ApiRequestFailure, List<ProductItemModel>>> getProducts(
      {required int offset, required int limit}) async {
    final response =
        await _homeRemoteServices.getProducts(offset: offset, limit: limit);
    return response.fold((error) {
      return left(ApiRequestFailure(failureMsg: error.failureMsg));
    }, (data) async {
      //  LocalStorageManager.saveList(DefaultsKeys.transactionList, data);
      return right(data);
    });
  }
}
