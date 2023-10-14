import 'dart:io';
import 'package:doctech/createCharacter/pickImage.dart';
import 'package:doctech/createCharacter/voice.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../../utility/rest_api.dart';
import '../models/option.dart';
import '../pref_data.dart';
import '../utility/common.dart';
import '../utility/configs.dart';
import '../widgets/bottomSheet.dart';
import '../widgets/spaces.dart';
import '../widgets/textFields.dart';

class CreateCharacter extends StatefulWidget {
  const CreateCharacter({super.key});

  @override
  State<CreateCharacter> createState() => _CreateCharacterState();
}

class _CreateCharacterState extends State<CreateCharacter> {
  double speed = 1;
  double pitch = 0;
  TextEditingController nameController = TextEditingController();
  List<CharacterOption> selectedCharacteristics = [];
  TextEditingController rolesController = TextEditingController();
  CharacterOption? selectedVoice;
  File? image;
  bool isLoading = false;
  List<String> invalidWords = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Create Doctor"),
            centerTitle: true,
          ),
          body: FutureBuilder<CharacterOptions>(
              future: getCharacterOptions(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Container(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Doctor Name"),
                        mediumSmallSpace(),
                        InputField(
                          lable: "Doctor Name",
                          controller: nameController,
                        ),
                        mediumSpace(),

                        mediumSpace(),

                        mediumSpace(),
                        Text("Doctor Personality"),
                        mediumSmallSpace(),
                        //Bottom Sheet Selection
                        BottomSelection(
                          options: snapshot.data!.characteristics,
                          onSelected: (value) {
                            selectedCharacteristics = value;
                            log(value);
                          },
                        ),
                        mediumSpace(),
                        FunctionInputField(title: "Doctor Role", lable: "Select Doctor Role", controller: rolesController),
                        mediumSpace(),

                        mediumSpace(),

                        Text("Voice"),
                        mediumSmallSpace(),

                        ChooseVoice(
                            voices: snapshot.data!.voices,
                            onSpeedChanged: (speed) {
                              this.speed = speed;
                            },
                            onPitchChanged: (pitch) {
                              this.pitch = pitch;
                            },
                            onVoiceChanged: (voice) {
                              selectedVoice = voice;
                            }),

                        mediumSpace(),

                        ImageWidget(
                          onImageSelected: (image) {
                            this.image = image;
                          },
                        ),

                        largeSpace(),

                        //Gradient Button to create character
                        GestureDetector(
                            onTap: () {
                              createcharacter();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: primarySecondaryGradient(context),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                    Text("Create Doctor", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)))),
                      ],
                    ),
                  ),
                );
              }),
        ),
        isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(),
      ],
    );
  }

  void createcharacter() async {
    if (!validate()) {
      log("Validation Failed");
      return;
    }
    var request = http.MultipartRequest("POST", Uri.parse("${BASE_URL}aidoctor/createCharacter"));
    //add text fields
    request.fields["name"] = nameController.text;
    request.fields["voice"] = selectedVoice!.id.toString();
    request.fields["speed"] = speed.toString();
    request.fields["characteristics"] = selectedCharacteristics.map((e) => e.id.toString()).toList().toString();
    request.fields["pitch"] = pitch.toString();
    request.fields["sessiontoken"] = await PrefData.getSessionToken();
    request.fields["role"] = rolesController.text;
    //add image

    request.files.add(await http.MultipartFile.fromPath('image', image!.path));

    //post request
    setState(() {
      /* isLoading = true; */
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  //This function validats if all the fields are filled and are not empty

  bool validate() {
    if (nameController.text.isEmpty) {
      showSnackBar("Doctor Name is Empty");
      return false;
    } else if (selectedVoice == null) {
      showSnackBar("Voice is Empty");
      return false;
    } else if (image == null) {
      showSnackBar("Image is Empty");
      return false;
    }
    return true;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
