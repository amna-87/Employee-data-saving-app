import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'employee_details.dart'; // Import the newly created EmployeeDetails screen
// import 'package:diary/styles/styles.dart'; // Make sure to import your styles file

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  // ignore: prefer_typing_uninitialized_variables
  var imgURL;
  bool loadingImg = false;
  bool saving = false;
  final newEmp = FirebaseFirestore.instance.collection('Employees');
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController profession = TextEditingController();
  String id = DateTime.now().millisecond.toString();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Employee'),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: ListView(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    uploadImg();
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF0F4B7C),
                    radius: 60,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: loadingImg
                          ? const CircularProgressIndicator()
                          : imgURL == null
                              ? const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                )
                              : Image.network(imgURL, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                            color: Color(0xFF0F4B7C),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: name,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                                color: Color(0xFF0F4B7C), fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF0F4B7C),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF0F4B7C),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please update something first!';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFF0F4B7C),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color(0xFF0F4B7C), fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF0F4B7C),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF0F4B7C),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please update something first!';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'City',
                          style: TextStyle(
                            color: Color(0xFF0F4B7C),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: city,
                          decoration: const InputDecoration(
                            hintText: "City",
                            hintStyle: TextStyle(
                                color: Color(0xFF0F4B7C), fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF0F4B7C),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF0F4B7C),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please update something first!';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Profession',
                  style: TextStyle(
                    color: Color(0xFF0F4B7C),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: profession,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Profession",
                    hintStyle:
                        TextStyle(color: Color(0xFF0F4B7C), fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF0F4B7C),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF0F4B7C),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please update something first!';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF0F4B7C),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        saving = true;
                      });
                      imgURL ??=
                          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAADFCAMAAACM/tznAAAAS1BMVEWysbD////u7u7t7e329vb7+/vx8fH8/Pz4+Pj09PSsq6qvrq3q6uq0s7K7urm2tbTCwcDi4uLZ2NjT0tLNzMze3d3FxcTX1tbOzc1b7OBzAAAMTklEQVR4nO1d66KzKBKMqKgD3mLUvP+TDiCJKKIol+DMqT9b39nd0JTQdCs0j4ghBhQCh4xmAk8ZLxjPKY8TxhPGc4GnjBdg5pDxjHHWUiw0JXKw22wqNKsyQdUsFJoSTXj8CfAnwJ8AJwSIwxcg3m72BwIoLLkiQOxQgJiB20DxsYHiYwPFp+sUicA/XZ95wTi3gXHe9XVTeOL4hybED7B+9vujMJcegvjsr01DAwd01gSwNgH8CfAnwLYlOu5P2fpJP2Tggc+aIDcrjoAMCK0LPAWC/IwnAuetC5zJD4TWF1ywBERrLjdry4RM4nwEcDVm5xsJzlfHEes4Xyg4X9ERY4afmuA/EoQAAtzivhuapmJomq2DoxGj6ZHh4EJtDMyONa0alT4GGO0RUtFYOBA7wgsxNfisga/Gk/9RzHvi98A+G+L+ErqhlSCewh3hBPpWfAAeMU94sO+TfZXHARWgB0rMC0/wzGoeT2WxLFwzCImoE/2AqcdwD/3MTZrmEW8i4WVi+VzZkZ0CacU/eD8TuN6AF00CwMIo9OblYEXJnF3B92O3txRcUhgPV8iH9Hgqd/OA3R98AAAAASUVORK5CYII=';

                      newEmp.doc(id).set({
                        'id': id,
                        'name': name.text,
                        'email': email.text,
                        'city': city.text,
                        'profession': profession.text,
                        'imgURL': imgURL,
                      }).then((value) {
                        setState(() {
                          saving = false;
                        });
                        Utils().toastMessage(
                            'New Employee added', const Color(0xFF0F4B7C));
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeDetails(
                              name: name.text,
                              email: email.text,
                              city: city.text,
                              profession: profession.text,
                              imgURL: imgURL,
                            ),
                          ),
                        );
                      });
                    },
                    child: saving
                        ? const CircularProgressIndicator()
                        : const Text('Save',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadImg() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      loadingImg = true;
    });

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('employee_$id.jpg');
    UploadTask uploadTask = ref.putFile(File(image.path));

    await uploadTask.whenComplete(() async {
      imgURL = await ref.getDownloadURL();
      setState(() {
        loadingImg = false;
      });
    });
  }
}
