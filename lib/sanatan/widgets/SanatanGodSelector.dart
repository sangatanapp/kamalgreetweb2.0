import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kamal_greet_web_2/Utils/widgets/CreationDecorations.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import '../dashboard/view/SanatanCreationScreen.dart';

Widget sanatanGodSelector(BuildContext context) {
  return creationSubTitle(
    "Select God",
    Row(
      children: [
        Expanded(
          child: TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              onTap: () {},
              controller: sanatanCreationCtrl.godSelectorController,
              decoration: CreationDecorations()
                  .inputDecoration(labelText: "Select God"),
              onSubmitted: (text) async {
                sanatanCreationCtrl.godSelectorController.text = text;
              },
            ),
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (suggestion) async {
              sanatanCreationCtrl.godSelectorController.text = suggestion;
            },
            suggestionsCallback: (pattern) async {
              return sanatanCreationCtrl.allGuruSuggestions;
            },
          ),
        ),
      ],
    ),
  );
}
