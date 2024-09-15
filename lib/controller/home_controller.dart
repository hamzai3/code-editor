import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_editor/helpers/storage_helper.dart';
import 'package:code_editor/presentation/view/auth_screens/auth_screen.dart';
import 'package:code_editor/utils/app_dialogs.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../utils/extras.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  var controller = CodeController();
  WebSocketChannel? channel;
//  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var pagesViewScaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    pagesViewScaffoldKey.currentState?.openDrawer();
    update();
  }

  Future<void> updateLanguageCountByDate(String language) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    if (userId.isEmpty) {
      Get.to(const AuthScreen());
    } 
    // Get today's date
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";

    CollectionReference languageCountsCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocRef = languageCountsCollection.doc(userId);
    CollectionReference countsCollection =
        userDocRef.collection('lanugageCounts');
    DocumentReference dateDocRef = countsCollection.doc(formattedDate);

    // Reference to the Firestore collection and document for the specific date
    // DocumentReference docRef =
    //     FirebaseFirestore.instance.collection('languageCounts').doc(todayDate);

    // Use Firestore's FieldValue.increment to update the count
    await dateDocRef.set({
      language: FieldValue.increment(1),
    }, SetOptions(merge: true)).then((_) {
      // AppDialogs.showProcess("Something went wrong");
    }).catchError((error) {
      AppDialogs.errorSnackBar("Something went wrong");
    });
  }
 

  String? selectedLanguage = 'Java';
  String? selectedVersion;

  // Map of languages with versions
  final Map<String, List<String>> jdoodleLanguages = {
    'Java': [
      'JDK 1.8.0_66#0',
      'JDK 9.0.1#1',
      'JDK 10.0.1#2',
      'JDK 11.0.4#3',
      'JDK 17.0.1#4',
    ],
    'C': [
      'GCC 5.3.0#0',
      'Zapcc 5.0.0#1',
      'GCC 7.2.0#2',
      'GCC 8.1.0#3',
      'GCC 9.1.0#4',
      'GCC 11.1.0#5',
    ],
    'C-99': [
      'GCC 5.3.0#0',
      'GCC 7.2.0#1',
      'GCC 8.1.0#2',
      'GCC 9.1.0#3',
      'GCC 11.1.0#4',
    ],
    'C++': [
      'GCC 5.3.0#0',
      'Zapcc 5.0.0#1',
      'GCC 7.2.0#2',
      'GCC 8.1.0#3',
      'GCC 9.1.0#4',
      'GCC 11.1.0#5',
    ],
    'C++ 14': [
      'g++ 14 GCC 5.3.0#0',
      'g++ 14 GCC 7.2.0#1',
      'g++ 14 GCC 8.1.0#2',
      'g++ 14 GCC 9.1.0#3',
      'GCC 11.1.0#4',
    ],
    'C++ 17': [
      'g++ 17 GCC 9.1.0#0',
      'GCC 11.1.0#1',
    ],
    'PHP': [
      '5.6.16#0',
      '7.1.11#1',
      '7.2.5#2',
      '7.3.10#3',
      '8.0.13#4',
    ],
    'Perl': [
      '5.22.0#0',
      '5.26.1#1',
      '5.26.2#2',
      '5.30.0#3',
      '5.34.0#4',
    ],
    'Python 2': [
      '2.7.11#0',
      '2.7.15#1',
      '2.7.16#2',
      '2.7.18#3',
    ],
    'Python 3': [
      '3.5.1#0',
      '3.6.3#1',
      '3.6.5#2',
      '3.7.4#3',
      '3.9.9#4',
    ],
    'Ruby': [
      '2.2.4#0',
      '2.4.2p198#1',
      '2.5.1p57#2',
      '2.6.5#3',
      '3.0.2#4',
    ],
    'GO Lang': [
      '1.5.2#0',
      '1.9.2#1',
      '1.10.2#2',
      '1.13.1#3',
      '1.17.3#4',
    ],
    'Scala': [
      '2.12.0#0',
      '2.12.4#1',
      '2.12.5#2',
      '2.13.0#3',
      '2.13.6#4',
    ],
    'Bash Shell': [
      '4.3.42#0',
      '4.4.12#1',
      '4.4.19#2',
      '5.0.011#3',
      '5.1.12#4',
    ],
    'SQL': [
      'SQLite 3.9.2#0',
      'SQLite 3.21.0#1',
      'SQLite 3.23.1#2',
      'SQLite 3.29.0#3',
      '3.37.0#4',
    ],
    'Pascal': [
      'fpc 3.0.0#0',
      'fpc-3.0.2#1',
      'fpc-3.0.4#2',
      'fpc-3.2.2#3',
    ],
    'C#': [
      'mono 4.2.2#0',
      'mono 5.0.0#1',
      'mono 5.10.1#2',
      'mono 6.0.0#3',
      'mono-6.12.0#4',
    ],
    'VB.Net': [
      'mono 4.0.1#0',
      'mono 4.6#1',
      'mono 5.10.1#2',
      'mono 6.0.0#3',
      'mono 6.12.0#4',
    ],
    'Haskell': [
      'ghc 7.10.3#0',
      'ghc 8.2.1#1',
      'ghc 8.2.2#2',
      'ghc 8.6.5#3',
      '9.0.1#4',
    ],
    'Objective C': [
      'GCC 5.3.0#0',
      'GCC 7.2.0#1',
      'GCC 8.1.0#2',
      'GCC 9.1.0#3',
      'GCC 11.1.0#4',
    ],
    'Swift': [
      '2.2#0',
      '3.1.1#1',
      '4.1#2',
      '5.1#3',
      '5.5#4',
    ],
    'Groovy': [
      '2.4.6 JVM: 1.7.0_99#0',
      '2.4.12 JVM: 9.0.1#1',
      '2.4.15 JVM: 10.0.1#2',
      '2.5.8 JVM: 11.0.4#3',
      '3.0.9 JVM: 17.0.1#4',
    ],
    'Fortran': [
      'GNU 5.3.0#0',
      'GNU 7.2.0#1',
      'GNU 8.1.0#2',
      'GNU 9.1.0#3',
      'GNU 11.1.0#4',
    ],
    'Brainf**k': ['bfc-0.1#0'],
    'Lua': [
      '5.3.2#0',
      '5.3.4#1',
      '5.3.5#2',
      '5.4.3#3',
    ],
    'TCL': [
      '8.6#0',
      '8.6.7#1',
      '8.6.8#2',
      '8.6.9#3',
      '8.6.12#4',
    ],
    'Hack': ['HipHop VM 3.13.0#0'],
    'RUST': [
      '1.10.0#0',
      '1.21.0#1',
      '1.25.0#2',
      '1.38.0#3',
      '1.56.1#4',
    ],
    'D': [
      'DMD64 D Compiler v2.071.1#0',
      'DMD64 D Compiler v2.088#1',
      'DMD64 D Compiler v2.098#2',
    ],
    'Ada': [
      'GNATMAKE 6.1.1#0',
      'GNATMAKE 7.2.0#1',
      'GNATMAKE 8.1.0#2',
      'GNATMAKE 9.1.0#3',
      'GNATMAKE 11.1.0#4',
    ],
    'R Language': [
      '3.3.1#0',
      '3.4.2#1',
      '3.5.0#2',
      '3.6.1#3',
      '4.1.2#4',
    ],
    'FREE BASIC': [
      '1.05.0#0',
      '1.07.1#1',
      '1.08.1#2',
    ],
    'VERILOG': [
      '10.1#0',
      '10.2#1',
      '10.3#2',
      '11#3',
    ],
    'COBOL': [
      'GNU COBOL 2.0.0#0',
      'GNU COBOL 2.2.0#1',
    ]
  };

  // Show Dialog for Language and Version selection
  void showLanguageVersionDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Select Language and Version'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Language Dropdown
                DropdownButton<String>(
                  hint: const Text("Select Language"),
                  value: selectedLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue;
                      setCodeController(selectedLanguage!);
                      // Reset version when a new language is selected
                      // if (selectedLanguage != null &&
                      //     jdoodleLanguages.containsKey(selectedLanguage)) {
                      //   selectedVersion = jdoodleLanguages[selectedLanguage]
                      //       ?.last;
                      //       update();
                      // }
                      selectedVersion = null;
                      //     jdoodleLanguages[selectedLanguage!]?.last;

                      update();
                    });
                  },
                  items: jdoodleLanguages.keys.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),
                // Text(selectedVersion?.toString()),
                // Version Dropdown (dynamically updated based on language)
                DropdownButton<String>(
                  hint: const Text("Select Version"),
                  value: selectedVersion,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedVersion = newValue.toString();
                      // .split("#")[1].toString();
                    });
                  },
                  items: selectedLanguage != null
                      ? jdoodleLanguages[selectedLanguage!]!
                          .map((String version) {
                          return DropdownMenuItem<String>(
                            value: version,
                            child: Text(
                                version.toString().split("#")[0].toString()),
                          );
                        }).toList()
                      : [],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  if (selectedLanguage != null && selectedVersion != null) {
                    // You can proceed with your logic here
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    controller = CodeController(
        text: '// Type your code here...',
        language: java, // default to PHP or another default language
        params: const EditorParams(tabSpaces: 2));
    StorageHelper().getValue("AuthJdoodle").then((token) {
      if (token.toString() != 'null') {
        authToken = token;
      } else {
        authenticate();
      }
    });

    update();
  }

  String output = '', authToken = '';

  // Replace with your JDoodle credentials
  final String? clientId = dotenv.env['clientId'];
  final String? clientSecret = dotenv.env['clientSecret'];

  // Function to execute the code
  Future<void> authenticate() async {
    final url = Uri.parse("https://api.jdoodle.com/v1/auth-token");

    final headers = {
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "clientId": clientId,
      "clientSecret": clientSecret,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        StorageHelper().setValue("AuthJdoodle", response.body.toString());
        authToken = response.body;
        update();
      } else {
        output = "Error:in auth ${response.statusCode}";
        update();
      }
    } catch (e, stack) {
      output = "Error:in auth $e ,\n $stack";
      update();
    }
  }

  Future<void> executeCode(code, context) async {
    final url = Uri.parse("https://api.jdoodle.com/v1/execute");

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $authToken'
    };

    final body = jsonEncode({
      "clientId": clientId,
      "clientSecret": clientSecret,
      "script": code,
      "language": selectedLanguage.toString().toLowerCase(),
      "versionIndex": selectedVersion.toString().split("#").length > 0
          ? selectedVersion.toString().split("#")[1].toString()
          : 4,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        updateLanguageCountByDate(selectedLanguage!);
        final data = jsonDecode(response.body);
        output = data["output"];

        update();
      } else {
        output = "Error: ${response.reasonPhrase}";

        update();
      }
    } catch (e, stack) {
      output = "Error: $e ,\n $stack";
      update();
    }
  }

  void setCodeController(String selectedLang) {
    switch (selectedLang) {
      case "abnf":
        controller = CodeController(language: abnf);
        break;
      case "accesslog":
        controller = CodeController(language: accesslog);
        break;
      case "actionscript":
        controller = CodeController(language: actionscript);
        break;
      case "ada":
        controller = CodeController(language: ada);
        break;
      case "angelscript":
        controller = CodeController(language: angelscript);
        break;
      case "apache":
        controller = CodeController(language: apache);
        break;
      case "applescript":
        controller = CodeController(language: applescript);
        break;
      case "arcade":
        controller = CodeController(language: arcade);
        break;
      case "arduino":
        controller = CodeController(language: arduino);
        break;
      case "armasm":
        controller = CodeController(language: armasm);
        break;
      case "asciidoc":
        controller = CodeController(language: asciidoc);
        break;
      case "aspectj":
        controller = CodeController(language: aspectj);
        break;
      case "autohotkey":
        controller = CodeController(language: autohotkey);
        break;
      case "autoit":
        controller = CodeController(language: autoit);
        break;
      case "avrasm":
        controller = CodeController(language: avrasm);
        break;
      case "awk":
        controller = CodeController(language: awk);
        break;
      case "axapta":
        controller = CodeController(language: axapta);
        break;
      case "bash":
        controller = CodeController(language: bash);
        break;
      case "basic":
        controller = CodeController(language: basic);
        break;
      case "bnf":
        controller = CodeController(language: bnf);
        break;
      case "brainfuck":
        controller = CodeController(language: brainfuck);
        break;
      case "cal":
        controller = CodeController(language: cal);
        break;
      case "capnproto":
        controller = CodeController(language: capnproto);
        break;
      case "ceylon":
        controller = CodeController(language: ceylon);
        break;
      case "clean":
        controller = CodeController(language: clean);
        break;
      case "clojure-repl":
        controller = CodeController(language: clojureRepl);
        break;
      case "clojure":
        controller = CodeController(language: clojure);
        break;
      case "cmake":
        controller = CodeController(language: cmake);
        break;
      case "coffeescript":
        controller = CodeController(language: coffeescript);
        break;
      case "coq":
        controller = CodeController(language: coq);
        break;
      case "cos":
        controller = CodeController(language: cos);
        break;
      case "cpp":
        controller = CodeController(language: cpp);
        break;
      case "crmsh":
        controller = CodeController(language: crmsh);
        break;
      case "crystal":
        controller = CodeController(language: crystal);
        break;
      case "cs":
        controller = CodeController(language: cs);
        break;
      case "csp":
        controller = CodeController(language: csp);
        break;
      case "css":
        controller = CodeController(language: css);
        break;
      case "d":
        controller = CodeController(language: d);
        break;
      case "dart":
        controller = CodeController(language: dart);
        break;
      case "delphi":
        controller = CodeController(language: delphi);
        break;
      case "diff":
        controller = CodeController(language: diff);
        break;
      case "django":
        controller = CodeController(language: django);
        break;
      case "dns":
        controller = CodeController(language: dns);
        break;
      case "dockerfile":
        controller = CodeController(language: dockerfile);
        break;
      case "dos":
        controller = CodeController(language: dos);
        break;
      case "dsconfig":
        controller = CodeController(language: dsconfig);
        break;
      case "dts":
        controller = CodeController(language: dts);
        break;
      case "dust":
        controller = CodeController(language: dust);
        break;
      case "ebnf":
        controller = CodeController(language: ebnf);
        break;
      case "elixir":
        controller = CodeController(language: elixir);
        break;
      case "elm":
        controller = CodeController(language: elm);
        break;
      case "erb":
        controller = CodeController(language: erb);
        break;
      case "erlang-repl":
        controller = CodeController(language: erlangRepl);
        break;
      case "erlang":
        controller = CodeController(language: erlang);
        break;
      case "excel":
        controller = CodeController(language: excel);
        break;
      case "fix":
        controller = CodeController(language: fix);
        break;
      case "flix":
        controller = CodeController(language: flix);
        break;
      case "fortran":
        controller = CodeController(language: fortran);
        break;
      case "fsharp":
        controller = CodeController(language: fsharp);
        break;
      case "gams":
        controller = CodeController(language: gams);
        break;
      case "gauss":
        controller = CodeController(language: gauss);
        break;
      case "gcode":
        controller = CodeController(language: gcode);
        break;
      case "gherkin":
        controller = CodeController(language: gherkin);
        break;
      case "glsl":
        controller = CodeController(language: glsl);
        break;
      case "gml":
        controller = CodeController(language: gml);
        break;
      case "gn":
        controller = CodeController(language: gn);
        break;
      case "go":
        controller = CodeController(language: go);
        break;
      case "golo":
        controller = CodeController(language: golo);
        break;
      case "gradle":
        controller = CodeController(language: gradle);
        break;
      case "graphql":
        controller = CodeController(language: graphql);
        break;
      case "groovy":
        controller = CodeController(language: groovy);
        break;
      case "haml":
        controller = CodeController(language: haml);
        break;
      case "handlebars":
        controller = CodeController(language: handlebars);
        break;
      case "haskell":
        controller = CodeController(language: haskell);
        break;
      case "haxe":
        controller = CodeController(language: haxe);
        break;
      case "hsp":
        controller = CodeController(language: hsp);
        break;
      case "htmlbars":
        controller = CodeController(language: htmlbars);
        break;
      case "hy":
        controller = CodeController(language: hy);
        break;
      case "inform7":
        controller = CodeController(language: inform7);
        break;
      case "ini":
        controller = CodeController(language: ini);
        break;
      case "irpf90":
        controller = CodeController(language: irpf90);
        break;
      case "isbl":
        controller = CodeController(language: isbl);
        break;
      case "java":
        controller = CodeController(language: java);
        break;
      case "javascript":
        controller = CodeController(language: javascript);
        break;
      case "jboss-cli":
        controller = CodeController(language: jbossCli);
        break;
      case "json":
        controller = CodeController(language: json);
        break;
      case "julia-repl":
        controller = CodeController(language: juliaRepl);
        break;
      case "julia":
        controller = CodeController(language: julia);
        break;
      case "kotlin":
        controller = CodeController(language: kotlin);
        break;
      case "lasso":
        controller = CodeController(language: lasso);
        break;
      case "ldif":
        controller = CodeController(language: ldif);
        break;
      case "leaf":
        controller = CodeController(language: leaf);
        break;
      case "less":
        controller = CodeController(language: less);
        break;
      case "lisp":
        controller = CodeController(language: lisp);
        break;
      case "livecodeserver":
        controller = CodeController(language: livecodeserver);
        break;
      case "livescript":
        controller = CodeController(language: livescript);
        break;
      case "llvm":
        controller = CodeController(language: llvm);
        break;
      case "lsl":
        controller = CodeController(language: lsl);
        break;
      case "lua":
        controller = CodeController(language: lua);
        break;
      case "makefile":
        controller = CodeController(language: makefile);
        break;
      case "markdown":
        controller = CodeController(language: markdown);
        break;
      case "mathematica":
        controller = CodeController(language: mathematica);
        break;
      case "matlab":
        controller = CodeController(language: matlab);
        break;
      case "maxima":
        controller = CodeController(language: maxima);
        break;
      case "mel":
        controller = CodeController(language: mel);
        break;
      case "mercury":
        controller = CodeController(language: mercury);
        break;
      case "mipsasm":
        controller = CodeController(language: mipsasm);
        break;
      case "mizar":
        controller = CodeController(language: mizar);
        break;
      case "mojolicious":
        controller = CodeController(language: mojolicious);
        break;
      case "monkey":
        controller = CodeController(language: monkey);
        break;
      case "moonscript":
        controller = CodeController(language: moonscript);
        break;
      case "nginx":
        controller = CodeController(language: nginx);
        break;
      case "nimrod":
        controller = CodeController(language: nimrod);
        break;
      case "nix":
        controller = CodeController(language: nix);
        break;
      case "nsis":
        controller = CodeController(language: nsis);
        break;
      case "objectivec":
        controller = CodeController(language: objectivec);
        break;
      case "ocaml":
        controller = CodeController(language: ocaml);
        break;
      case "openscad":
        controller = CodeController(language: openscad);
        break;
      case "oxygene":
        controller = CodeController(language: oxygene);
        break;
      case "parser3":
        controller = CodeController(language: parser3);
        break;
      case "perl":
        controller = CodeController(language: perl);
        break;
      case "pf":
        controller = CodeController(language: pf);
        break;
      case "pgsql":
        controller = CodeController(language: pgsql);
        break;
      case "php":
        controller = CodeController(language: php);
        break;
      case "plaintext":
        controller = CodeController(language: plaintext);
        break;
      case "pony":
        controller = CodeController(language: pony);
        break;
      case "powershell":
        controller = CodeController(language: powershell);
        break;
      case "processing":
        controller = CodeController(language: processing);
        break;
      case "profile":
        controller = CodeController(language: profile);
        break;
      case "prolog":
        controller = CodeController(language: prolog);
        break;
      case "properties":
        controller = CodeController(language: properties);
        break;
      case "protobuf":
        controller = CodeController(language: protobuf);
        break;
      case "puppet":
        controller = CodeController(language: puppet);
        break;
      case "purebasic":
        controller = CodeController(language: purebasic);
        break;
      case "python":
        controller = CodeController(language: python);
        break;
      case "q":
        controller = CodeController(language: q);
        break;
      case "qml":
        controller = CodeController(language: qml);
        break;
      case "r":
        controller = CodeController(language: r);
        break;
      case "reasonml":
        controller = CodeController(language: reasonml);
        break;
      case "rib":
        controller = CodeController(language: rib);
        break;
      case "roboconf":
        controller = CodeController(language: roboconf);
        break;
      case "routeros":
        controller = CodeController(language: routeros);
        break;
      case "rsl":
        controller = CodeController(language: rsl);
        break;
      case "ruby":
        controller = CodeController(language: ruby);
        break;
      case "ruleslanguage":
        controller = CodeController(language: ruleslanguage);
        break;
      case "rust":
        controller = CodeController(language: rust);
        break;
      case "sas":
        controller = CodeController(language: sas);
        break;
      case "scala":
        controller = CodeController(language: scala);
        break;
      case "scheme":
        controller = CodeController(language: scheme);
        break;
      case "scilab":
        controller = CodeController(language: scilab);
        break;
      case "scss":
        controller = CodeController(language: scss);
        break;
      case "shell":
        controller = CodeController(language: shell);
        break;
      case "smali":
        controller = CodeController(language: smali);
        break;
      case "smalltalk":
        controller = CodeController(language: smalltalk);
        break;
      case "sml":
        controller = CodeController(language: sml);
        break;
      case "solidity":
        controller = CodeController(language: solidity);
        break;
      case "sqf":
        controller = CodeController(language: sqf);
        break;
      case "sql":
        controller = CodeController(language: sql);
        break;
      case "stan":
        controller = CodeController(language: stan);
        break;
      case "stata":
        controller = CodeController(language: stata);
        break;
      case "step21":
        controller = CodeController(language: step21);
        break;
      case "stylus":
        controller = CodeController(language: stylus);
        break;
      case "subunit":
        controller = CodeController(language: subunit);
        break;
      case "swift":
        controller = CodeController(language: swift);
        break;
      case "taggerscript":
        controller = CodeController(language: taggerscript);
        break;
      case "tap":
        controller = CodeController(language: tap);
        break;
      case "tcl":
        controller = CodeController(language: tcl);
        break;
      case "tex":
        controller = CodeController(language: tex);
        break;
      case "thrift":
        controller = CodeController(language: thrift);
        break;
      case "tp":
        controller = CodeController(language: tp);
        break;
      case "twig":
        controller = CodeController(language: twig);
        break;
      case "typescript":
        controller = CodeController(language: typescript);
        break;
      case "vala":
        controller = CodeController(language: vala);
        break;
      case "vbnet":
        controller = CodeController(language: vbnet);
        break;
      case "vbscript-html":
        controller = CodeController(language: vbscriptHtml);
        break;
      case "vbscript":
        controller = CodeController(language: vbscript);
        break;
      case "verilog":
        controller = CodeController(language: verilog);
        break;
      case "vhdl":
        controller = CodeController(language: vhdl);
        break;
      case "vim":
        controller = CodeController(language: vim);
        break;
      case "vue":
        controller = CodeController(language: vue);
        break;
      case "xl":
        controller = CodeController(language: xl);
        break;
      case "xml":
        controller = CodeController(language: xml);
        break;
      case "xquery":
        controller = CodeController(language: xquery);
        break;
      case "yaml":
        controller = CodeController(language: yaml);
        break;
      case "zephir":
        controller = CodeController(language: zephir);
        break;

      default:
        controller = CodeController(
          text: '// Type your code here...',
          language: java, // default to PHP or another default language
        );
    }
  }
}
