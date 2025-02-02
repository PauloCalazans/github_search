import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app_widget.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/external/datasource/github_datasource.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/search_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => SearchByTextImpl(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => GithubDatasource(i())),
    Bind((i) => SearchBloc(i())),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SearchPage()),
  ];

  @override
  Widget get bootstrap => AppWidget();

}