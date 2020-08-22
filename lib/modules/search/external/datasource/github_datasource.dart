import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:github_search/modules/search/infra/models/result_search_model.dart';

@Injectable(singleton: false)
class GithubDatasource implements SearchDatasource {
  final Dio dio;
  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio.get('https://api.github.com/search/users?q=${searchText.trim().replaceAll(' ', '+')}');

    if(response.statusCode == 200) {
      final jsonList = response.data['items'] as List;
      final list = jsonList.map((e) => ResultSearchModel(img: e['avatar_url'], title: e['login'], content: e['id'].toString())).toList();

      return list;
    } else {
      throw DataSourceError();
    }
  }

}