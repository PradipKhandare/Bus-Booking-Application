import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
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
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15,),
      ),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            iconColor: headingColor,
            fillColor: Colors.white,
           // border: OutlineInputBorder(),
            labelText: "Search With Mobile",
            labelStyle: TextStyle(
              fontFamily: Fonts.fontFamily,
              color: headingColor,
            ),
            suffix: IconButton(
              icon: const Icon(Icons.search, color: headingColor,),
              onPressed: (){
                if(searchController.text.isEmpty) return;
                widget.onSubmit(searchController.text);
              },
            ),
          ),
        ),
      ),
    );
  }
}
