import 'package:flutter/material.dart';
import 'package:flutter_oauth/flutter_auth.dart';
import 'package:flutter_oauth/model/config.dart';
import 'package:flutter_oauth/oauth.dart';
import 'package:flutter_oauth/token.dart';

void main() {
  runApp(new FlutterView());
}

class FlutterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter OAuth',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  MainState createState() => new MainState();
}

class MainState extends State<Main> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Center(
                child: new RaisedButton(
                  child: new Text("Authorise"),
                  onPressed: () => authorise(),
                )
            ),
          ),
        ],
      ),
    );
  }

  authorise() async {
    final OAuth flutterOAuth = new FlutterOAuth(new Config(
        // Use Keycloak settings from https://www.jhipster.tech/security/#oauth2
        "http://localhost:9080/auth/realms/jhipster/protocol/openid-connect/auth",
        "http://localhost:9080/auth/realms/jhipster/protocol/openid-connect/token",
        "web_app",
        "web_app",
        // For connecting to a local JHipster running on 8080 port, you'll need
        // to add http://localhost:8100 as a Login redirect URI as well.
        "http://localhost:8100",
        "code"));
    Token token = await flutterOAuth.performAuthorization();
    var alert = new AlertDialog(
      title: new Text("Access Token"),
      content: new Text(token.accessToken),
    );
    showDialog(context: context, child: alert);
  }

}