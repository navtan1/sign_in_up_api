import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_up_api/api_services/all_users_services.dart';
import 'package:sign_in_up_api/model/res/all_users_model.dart';
import 'package:sign_in_up_api/view/intro_screen.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: AllUsersServices.getUserData(),
            builder:
                (BuildContext context, AsyncSnapshot<AllUsersModel?> snapshot) {
              return ListView.builder(
                itemCount: snapshot.data!.users!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey.shade300,
                          child: Image.network(
                            '${snapshot.data!.users![index].avatar}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('${snapshot.data!.users![index].username}'),
                        trailing: IconButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs
                                .remove('Password')
                                .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IntroScreen(),
                                    )));
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
