import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class InputForm01 extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<InputForm01> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilderTextField(
                name: "name",
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "이름 입력",
                    labelText: "이름"),
              ),
              SizedBox(height: 25),
              FormBuilderTextField(
                name: "email",
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: "Enter your email",
                    labelText: "Email"),
              ),
              SizedBox(height: 25),
              FormBuilderTextField(
                name: "mobile",
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: "핸드폰 번호 입력",
                    labelText: "핸드폰 번호 입력"),
              ),
              SizedBox(height: 25),
              FormBuilderDateTimePicker(
                name: "date",
                inputType: InputType.date,
                format: DateFormat("dd-MM-yyyy"),
                decoration: InputDecoration(labelText: "생일"),
              ),
              SizedBox(height: 25),
              FormBuilderTextField(
                name: "age",
                decoration: InputDecoration(labelText: "나이"),
                keyboardType: TextInputType.number,
                maxLength: 3,
              ),
              SizedBox(height: 25),
              Text("성별",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.left),
              FormBuilderRadioGroup(
                name: "gender",
                options: [
                  FormBuilderFieldOption(value: "Male"),
                  FormBuilderFieldOption(value: "Female"),
                  FormBuilderFieldOption(value: "Custom"),
                ],
              ),
              SizedBox(height: 25),
              FormBuilderCheckboxGroup(
                name: "languages",
                initialValue: ["English"],
                decoration: InputDecoration(
                    labelText: "Languages You Speak",
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                options: [
                  FormBuilderFieldOption(value: "English"),
                  FormBuilderFieldOption(value: "Spanish"),
                  FormBuilderFieldOption(value: "French"),
                ],
              ),
              SizedBox(height: 25),
              FormBuilderTextField(
                name: "password",
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                maxLines: 1,
                maxLength: 16,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  _formKey.currentState?.save();
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
