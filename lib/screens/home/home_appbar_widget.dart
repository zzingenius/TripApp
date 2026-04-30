import 'package:flutter/material.dart';

import '../../services/shared_prefs_service.dart';

class HomeAppbarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeAppbarWidgetState();
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomeAppbarWidgetState extends State<HomeAppbarWidget>{
  bool _isSearching = false;
  List<String> _searchHistory = [];

  void _changeSearchingStatus() {
    if(!_isSearching){
      _loadHistory();
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }
  Future<void> _loadHistory() async {
    final history = await SharedPrefsService.instance.loadHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  Future<void> _save(String query) async {
    if(query.isEmpty) return;

    if(!_searchHistory.contains(query)){
      _searchHistory.add(query);
      await SharedPrefsService.instance.save(_searchHistory);
    }
  }
  Widget historyList( BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options){
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final item = options.toList().reversed.elementAt(index);
              return ListTile(
                leading: Icon(Icons.history),
                title: Text(item),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _searchHistory.remove(item);
                    });
                    SharedPrefsService.instance.save(_searchHistory);
                  },
                ),
                onTap: () => onSelected(item),
              );
            },
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching? Autocomplete(
        optionsBuilder: (inputField){
          if(inputField.text.isEmpty) {
            return _searchHistory;
          }
          return _searchHistory.where((item) => item.contains(inputField.text));
        },
        onSelected: (selected){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('검색어 : $selected'))
          );
          _changeSearchingStatus();
        },
        fieldViewBuilder: (context, controller, focusNode, onSubmitted){
          return TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            decoration: InputDecoration(hintText: '검색어를 입력하세요'),
            onSubmitted: (input){
              if (input.trim().isNotEmpty){
                _save(input);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('검색어 : $input'))
                );
              }
              _changeSearchingStatus();
            },
          );
        },
        optionsViewBuilder: historyList,
      )
          : Text('Trip App'),
      actions: _isSearching? [
        IconButton(onPressed: _changeSearchingStatus, icon: Icon(Icons.close))
      ]
          : [
        IconButton(onPressed: _changeSearchingStatus, icon: Icon(Icons.search)),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
      ],
    );
  }

}