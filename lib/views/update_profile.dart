import 'package:flutter/material.dart';
import 'package:liaqat_qadir_backend/models/user.dart';
import 'package:liaqat_qadir_backend/providers/user.dart';
import 'package:liaqat_qadir_backend/service/user.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController = TextEditingController(
      text: userProvider.getUser().name.toString(),
    );
    phoneController = TextEditingController(
      text: userProvider.getUser().phone.toString(),
    );
    addressController = TextEditingController(
      text: userProvider.getUser().address.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile View")),
      body: Column(
        children: [
          TextField(controller: nameController),
          TextField(controller: phoneController),
          TextField(controller: addressController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Name cannot be empty.")),
                      );
                      return;
                    }
                    if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Phone cannot be empty.")),
                      );
                      return;
                    }
                    if (addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Address cannot be empty.")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await UserServices()
                          .updateProfile(
                            UserModel(
                              name: nameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              docId: userProvider.getUser().docId.toString(),
                            ),
                          )
                          .then((val) async {
                            await UserServices()
                                .getUser(
                                  userProvider.getUser().docId.toString(),
                                )
                                .then((val) {
                                  userProvider.setUser(val);
                                });
                            isLoading = false;
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                    "Profile has been updated successfull",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("Okay"),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Profile"),
                ),
        ],
      ),
    );
  }
}
