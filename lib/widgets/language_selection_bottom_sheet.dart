import 'package:api_tutorial/api_functions/api_functions.dart';
import 'package:flutter/material.dart';
import 'package:api_tutorial/widgets/language_selection_button.dart';

class LanguageSelectionBottomSheet extends StatefulWidget {
  final void Function(String) onLanguageSelected;
  const LanguageSelectionBottomSheet({
    super.key,
    required this.onLanguageSelected,
  });

  @override
  State<LanguageSelectionBottomSheet> createState() =>
      _LanguageSelectionBottomSheetState();
}

class _LanguageSelectionBottomSheetState
    extends State<LanguageSelectionBottomSheet> {
  List<String> languages = [];

//fetching languages

  @override
  void initState() {
    super.initState();
    ApiFunctions.fetchLanguages().then((list) {
      setState(() {
        languages = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'All Languages',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            for (String language in languages)
              Column(
                children: [
                  LanguageSelectButton(
                    languageName: language,
                    onPressed: () {
                      widget.onLanguageSelected(language);
                      Navigator.pop(
                          context); // Pass the selected language as a result
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
