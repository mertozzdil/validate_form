import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new FormPage(),
      theme: new ThemeData(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => new _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();

      performLogin();
    }
  }

  void performLogin(){
    final snackbar = new SnackBar(
      content: new Text("email: $_email, password: $_password"),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text("Form Page"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(labelText: "E-mail"),
                validator: (value) => !value.contains("@")?"Invalid Email" : null,
                onSaved: (value) => _email = value,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) => value.length<6?"Password too short" : null,
                onSaved: (value) => _password = value,
              ),
              new RaisedButton(
                child: new Text("Login"),
                onPressed: _submit,
              )
            ],
          ),
        ),
      )
    );
  }
}
