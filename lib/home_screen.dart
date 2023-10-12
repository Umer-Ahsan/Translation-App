// ignore_for_file: empty_catches

import 'package:api_tutorial/api_functions/api_functions.dart';
import 'package:api_tutorial/widgets/language_selection_bottom_sheet.dart';
import 'package:api_tutorial/widgets/language_selection_button.dart';
import 'package:api_tutorial/widgets/language_text_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController firstText = TextEditingController();
  TextEditingController secondText = TextEditingController();
  String selectedLanguageFrom =
      "Select Language"; // Default language for "Translate From"
  String selectedLanguageTo =
      "Select Language"; // Default language for "Translate To"
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Text Translation",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Button to select the language translate from
                  LanguageSelectButton(
                      languageName: selectedLanguageFrom,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return LanguageSelectionBottomSheet(
                                onLanguageSelected: (language) {
                                  setState(() {
                                    selectedLanguageFrom =
                                        language; // Updating the selected language
                                  });
                                },
                              );
                            });
                      }),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                    size: 20,
                  ),
                  //Button to select the language translate to
                  LanguageSelectButton(
                      languageName: selectedLanguageTo,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return LanguageSelectionBottomSheet(
                                onLanguageSelected: (language) {
                                  setState(() {
                                    selectedLanguageTo =
                                        language; // Updating the selected language
                                  });
                                },
                              );
                            });
                      })
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Translate From($selectedLanguageFrom)",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              BigTextField(controller: firstText),
              const SizedBox(
                height: 40,
              ),
              //button to translate
              ElevatedButton(
                  onPressed: () async {
                    try {
                      String translatedText = await ApiFunctions.translateText(
                        firstText.text,
                        selectedLanguageFrom,
                        selectedLanguageTo,
                      );
                      setState(() {
                        secondText.text =
                            translatedText; // Setting the translated text in the second text field
                      });
                    } catch (e) {}
                  },
                  child: const Text("TRANSLATE")),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Translate To($selectedLanguageTo)",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              BigTextField(controller: secondText)
            ],
          ),
        ),
      ),
    );
  }
}
