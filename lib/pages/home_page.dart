import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/language.dart';
import 'package:flutter_application_1/classes/language_constants.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/user_secure_storage.dart';
import 'package:flutter_application_1/router/route_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final login = await UserSecureStorage.getlogin() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';

    setState(() {
      controllerLogin.text = login;
      controllerPassword.text = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, settingsRoute);
          },
        ),
        title: Center(child: Text(translation(context).homePage)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale locale = await setLocale(language.languageCode);
                  if (!mounted) return;
                  MyApp.setLocale(context, locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[Text(e.name)],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _mainForm(context),
      ),
    );
  }

  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Text(
                translation(context).authorizationForm,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: controllerLogin,
            validator: (val) {
              if (val != null && val.isEmpty) {
                return "Обязательное поле";
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).login,
              hintText: translation(context).requiredLogin,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controllerPassword,
            validator: (val) {
              if (val != null && val.isEmpty) {
                return "Обязательное поле";
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).password,
              hintText: translation(context).requiredPassword,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState != null &&
                      _key.currentState!.validate()) {
                    UserSecureStorage.setLogin(controllerLogin.text);
                    UserSecureStorage.setPassword(controllerPassword.text);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, authRoute);
                  }
                },
                child: Text(translation(context).signIn,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
