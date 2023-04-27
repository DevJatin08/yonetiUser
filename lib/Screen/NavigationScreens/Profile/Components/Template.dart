import 'package:flutter/material.dart';
import 'package:userapp/Constant/ConstantValues.dart';

class ProfileTemplate extends StatefulWidget {
  Widget widget;
  String name;
  double? amount;
  bool? extraImage;
  String? url;
  Widget? appBarButton;
  Color? top;
  Color? bottom;

  ProfileTemplate(
      {required this.widget,
      this.amount,
      required this.name,
      this.extraImage = false,
      this.url,
      this.appBarButton = const SizedBox(),
      this.bottom = optionCardColor,
      this.top = Colors.white});

  @override
  _ProfileTemplateState createState() => _ProfileTemplateState();
}

class _ProfileTemplateState extends State<ProfileTemplate> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.top,
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'bold'),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: widget.appBarButton),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height * 0.8,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: widget.bottom, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                    child: widget.widget,
                  )
                  //  widget(child: widget.widget),
                  ),
              widget.extraImage == true
                  ? Align(
                      alignment: Alignment(0.0, -0.8),
                      child: Container(
                        width: size.width * 0.6,
                        height: size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                          image: DecorationImage(
                            image: NetworkImage(widget.url!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
