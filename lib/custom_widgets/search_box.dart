import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onSubmit;
  const SearchBox({super.key, required this.onSubmit});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  final searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Search With Mobile",
          suffix: IconButton(
            icon: const Icon(Icons.search, color: Colors.white,),
            onPressed: (){
              if(searchController.text.isEmpty) return;
              widget.onSubmit(searchController.text);
            },
          ),
        ),
      ),
    );
  }
}
