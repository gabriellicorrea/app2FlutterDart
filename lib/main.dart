import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Troca de Livros',
      home: AuthPage(),
    );
  }
}

enum AuthType { facebook, twitter, google, email }

class AuthPage extends StatelessWidget {
  final imageLinks = <String>[
    'https://st.depositphotos.com/1035837/2529/i/950/depositphotos_25297479-stock-photo-book.jpg',
    'https://st3.depositphotos.com/12982378/18598/i/1600/depositphotos_185982126-stock-photo-potted-plant-green-leaves-books.jpg',
    'https://st.depositphotos.com/1760224/2238/i/950/depositphotos_22387511-stock-photo-student-holding-old-books.jpg'
  ];

  final authTypes = <AuthType>[
    AuthType.facebook,
    AuthType.twitter,
    AuthType.google,
    AuthType.email
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.2,
              child: PageView(
                children: imageLinks.map((link) {
                  return PageViewItem(imageUrl: link);
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: FlatButton(
                child: Text("Sign in to Continue".toUpperCase()),
                onPressed: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: authTypes.map((authType) {
                return _SocialButton(
                  authType: authType,
                  onPressed: () {},
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final AuthType authType;
  final VoidCallback onPressed;

  const _SocialButton(
      {Key key, @required this.authType, @required this.onPressed})
      : assert(authType != null),
        assert(onPressed != null);

  Widget _getChild() {
    switch (authType) {
      case AuthType.facebook:
        return Icon(Icons.face);
      case AuthType.twitter:
        return Icon(Icons.wb_cloudy);
      case AuthType.google:
        return Icon(Icons.wb_sunny);
      case AuthType.email:
        return Text("Email".toUpperCase());
    }
    throw Exception('Invalid Auth Type');
  }

  @override
  Widget build(BuildContext context) {
    final isEmailAuthType = AuthType.email;
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(12)),
      child: _getChild(),
    );
  }
}

class PageViewItem extends StatelessWidget {
  final String imageUrl;

  const PageViewItem({Key key, @required this.imageUrl})
      : assert(imageUrl != null),
        assert(imageUrl != '');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(14),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imageUrl))),
      child: Column(
        children: <Widget>[
          Text("Troca de Livros".toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 35))
        ],
      ),
    );
  }
}
