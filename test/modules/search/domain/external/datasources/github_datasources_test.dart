import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/external/datasource/github_datasource.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);

  test('Deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(resultForTest), statusCode: 200));
    
    final future = datasource.getSearch("paulo");
    expect(future, completes);
    
  });

  test('Deve retornar um erro se o statusCode não for 200', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.getSearch("paulo");
    expect(future, throwsA(isA<DataSourceError>()));

  });
}

const String resultForTest = """
    {
      "total_count": 1,
      "incomplete_results": false,
      "items": [
        {
          "login": "PauloCalazans",
          "id": 23178026,
          "node_id": "MDQ6VXNlcjIzMTc4MDI2",
          "avatar_url": "https://avatars3.githubusercontent.com/u/23178026?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/PauloCalazans",
          "html_url": "https://github.com/PauloCalazans",
          "followers_url": "https://api.github.com/users/PauloCalazans/followers",
          "following_url": "https://api.github.com/users/PauloCalazans/following{/other_user}",
          "gists_url": "https://api.github.com/users/PauloCalazans/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/PauloCalazans/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/PauloCalazans/subscriptions",
          "organizations_url": "https://api.github.com/users/PauloCalazans/orgs",
          "repos_url": "https://api.github.com/users/PauloCalazans/repos",
          "events_url": "https://api.github.com/users/PauloCalazans/events{/privacy}",
          "received_events_url": "https://api.github.com/users/PauloCalazans/received_events",
          "type": "User",
          "site_admin": false,
          "score": 1.0
        }
      ]
    }
  """;