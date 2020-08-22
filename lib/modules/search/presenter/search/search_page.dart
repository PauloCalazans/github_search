import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchBloc> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Github Search"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search",
              ),
              onChanged: controller.add,
            ),
          ),

          Expanded(
            child: StreamBuilder<SearchState>(
              stream: controller,
              builder: (context, snapshot) {
                final state = controller.state;

                if(state is SearchStart) {
                  return Center(child: Text("Faça sua busca..."));
                }

                if(state is SearchError) {
                  return Center(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.error),
                        SizedBox(width: 8,),
                        Text("Houve um Erro"),
                      ],
                    ),
                  );
                }

                if(state is SearchLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if(state is SearchSuccess) {
                  final list = state.list;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: list[index].img == null
                              ? CircleAvatar(child: Icon(Icons.person))
                              : Container(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(list[index].img),
                                  ),
                                ),
                          title: Text(list[index].title ?? ""),
                          subtitle: Text(list[index].content ?? ""),
                        );
                      }
                  );
                } else {
                  return Container();
                }
              }
            ),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
    );
  }
}
