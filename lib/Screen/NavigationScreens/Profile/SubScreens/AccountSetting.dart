import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Constant/InputStyle.dart';
import 'package:userapp/Screen/CommonWidgets/CustomButton.dart';
import 'package:userapp/Screen/CommonWidgets/EditField.dart';

class AccountAndSettings extends ConsumerStatefulWidget {
  AccountAndSettings({Key? key}) : super(key: key);

  @override
  _AccountAndSettingsState createState() => _AccountAndSettingsState();
}

class _AccountAndSettingsState extends ConsumerState<AccountAndSettings> {
  TextEditingController businessName = TextEditingController();
  TextEditingController yourname = TextEditingController();

  // TextEditingController websiteName = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController dateBirth = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  List popString = ['Male', "Female", "Mix-Other"];
  int selectedTap = 0;
  var dob = DateTime.now();
  String gender = "";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _userInfoProvider = ref.watch(userInfoProvider);

    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: templatePadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: TextStyle(fontSize: 21, fontFamily: 'bold', color: Colors.white),
                ),
                Text(
                  'Update your account settings',
                  style: TextStyle(fontSize: 11, color: profileSubTextColor),
                ),
                SizedBox(
                  height: 20,
                ),
                EditableTextField(
                  // validator: (val) {
                  //   if (val == "" || val == " ") {
                  //     return "Enter Business name";
                  //   }
                  // },
                  action: TextInputAction.next,
                  suffix: false,
                  label: 'Your Full Name',
                  hint: '@Aghan',
                  inputDecoration: transparentInputDecoration,
                  controller: businessName,
                ),
                SizedBox(
                  height: 10,
                ),
                EditableTextField(
                  suffix: false,
                  action: TextInputAction.next,
                  validator: (val) {
                    if (val == "" || val == " ") {
                      return "Enter Your Name";
                    }
                    return null;
                  },
                  label: 'User Name',
                  inputDecoration: transparentInputDecoration,
                  controller: yourname,
                  hint: '@aghanbusiness',
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // EditableTextField(
                //   suffix: false,
                //   validator: (val) {
                //     if (val == "" || val == " ") {
                //       return "Enter Website Name";
                //     }
                //   },
                //   label: 'Website Name',
                //   inputDecoration: transparentInputDecoration,
                //   controller: websiteName,
                //   hint: 'www.aghadostain.com',
                // ),
                SizedBox(
                  height: 10,
                ),
                EditableTextField(
                  suffix: false,
                  label: 'Your bio',
                  action: TextInputAction.next,
                  validator: (val) {
                    if (val == "" || val == " ") {
                      return "Enter Your bio";
                    }
                    return null;
                  },
                  inputDecoration: transparentInputDecoration,
                  controller: bio,
                  maxLine: 3,
                  wordLimit: 150,
                  hint: 'Living in today’s metropolitan world of cellular phones, mobile computers and other high-tech gadgets is not just.',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Max 150 words tell people about yourself',
                  style: TextStyle(fontSize: 9, fontFamily: 'bold', color: profileSubTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                EditableTextField(
                  suffix: true,
                  label: 'Date of birth',
                  validator: (val) {
                    if (val == "" || val == " ") {
                      return "Enter Date of birth";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.datetime,
                  action: TextInputAction.next,
                  inputDecoration: transparentInputDecoration,
                  controller: dateBirth,
                  readOnly: true,
                  onTap: () async {
                    DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: dob,
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return child!;
                      },
                    );
                    if (d != null) {
                      setState(
                        () {
                          dob = d;
                          dateBirth.text = DateFormat("dd-MMM-yyyy").format(dob).toString();
                        },
                      );
                    }
                  },
                  hint: '12-Dec-1999',
                  widget: Icon(Icons.arrow_drop_down),
                ),
                SizedBox(
                  height: 10,
                ),
                EditableTextField(
                  suffix: true,
                  label: 'Phone Number',
                  inputDecoration: transparentInputDecoration,
                  controller: phone,
                  action: TextInputAction.next,
                  hint: '+92 333 333 3333',
                  widget: Text(
                    'Chnage',
                    style: TextStyle(fontSize: 9, color: primaryColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                EditableTextField(
                  suffix: true,
                  label: 'Email',
                  inputDecoration: transparentInputDecoration,
                  controller: email,
                  action: TextInputAction.done,
                  hint: 'demo@gmail.com',
                  widget: Text(
                    'Chnage',
                    style: TextStyle(fontSize: 9, color: primaryColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select Gender',
                  style: TextStyle(fontSize: 9, fontFamily: 'bold', color: profileSubTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: Color(0xfff1f7f7), borderRadius: BorderRadius.circular(5)),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popString.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTap = index;
                              gender = popString[index];
                            });
                          },
                          child: Container(
                            width: size.width * 0.9 / popString.length,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedTap == index ? Color(0xff4fc3f7) : Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                popString[index],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: selectedTap == index ? primaryColor : Colors.grey,
                                ),
                              ),
                            )),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  voidCallback: () {
                    setState(() {
                      print(yourname.text);
                      if (_formkey.currentState!.validate()) {
                        _userInfoProvider.getAccountSetting(fullname: yourname.text, user_bio: bio.text, dob: dateBirth.text, gender: gender);
                        _userInfoProvider.updateUserInfo(
                          yourname.text,
                          bio.text,
                          dateBirth.text,
                          gender,
                        );
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  text: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
