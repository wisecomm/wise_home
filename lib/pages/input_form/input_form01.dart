import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class InputForm01 extends StatefulWidget {
  const InputForm01({super.key});

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
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilderTextField(
                name: "name",
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "이름 입력",
                    labelText: "이름"),
              ),
              const SizedBox(height: 25),
              FormBuilderTextField(
                name: "email",
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: "Enter your email",
                    labelText: "Email"),
              ),
              const SizedBox(height: 25),
              FormBuilderTextField(
                name: "mobile",
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: "핸드폰 번호 입력",
                    labelText: "핸드폰 번호 입력"),
              ),
              const SizedBox(height: 25),
              FormBuilderDateTimePicker(
                name: "date",
                inputType: InputType.date,
                format: DateFormat("dd-MM-yyyy"),
                decoration: const InputDecoration(labelText: "생일"),
              ),
              const SizedBox(height: 25),
              FormBuilderTextField(
                name: "age",
                decoration: const InputDecoration(labelText: "나이"),
                keyboardType: TextInputType.number,
                maxLength: 3,
              ),
              const SizedBox(height: 25),
              const Text("성별",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.left),
              FormBuilderRadioGroup(
                name: "gender",
                options: const [
                  FormBuilderFieldOption(value: "Male"),
                  FormBuilderFieldOption(value: "Female"),
                  FormBuilderFieldOption(value: "Custom"),
                ],
              ),
              const SizedBox(height: 25),
              FormBuilderCheckboxGroup(
                name: "languages",
                initialValue: const ["English"],
                decoration: const InputDecoration(
                    labelText: "Languages You Speak",
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                options: const [
                  FormBuilderFieldOption(value: "English"),
                  FormBuilderFieldOption(value: "Spanish"),
                  FormBuilderFieldOption(value: "French"),
                ],
              ),
              const SizedBox(height: 25),
              FormBuilderTextField(
                name: "password",
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                maxLines: 1,
                maxLength: 16,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                child: const Text("Submit"),
                onPressed: () {
                  _formKey.currentState?.save();
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
