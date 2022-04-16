import 'package:flutter/material.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipOval(child: Container(height:200, width: 200,child: Image.asset("assets/pp.png")),),
              ListTile(
                title: Text("Name"),
                subtitle: Text("Edwin Ramana"),
              ),
              ListTile(
                title: Text("Occupation"),
                subtitle: Text("Senior Software Developer"),
              ),
              ListTile(
                title: Text("Company"),
                subtitle: Text("Mastersystem Infotama"),
              ),
              ListTile(
                title: Text("Email"),
                subtitle: Text("ramanaedwin@gmail.com"),
              ),
              ListTile(
                title: Text("Phone Number"),
                subtitle: Text("+62 89638313547"),
              ),
              ListTile(
                title: Text("Address"),
                subtitle: Text("Bogor, Indonesia"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
