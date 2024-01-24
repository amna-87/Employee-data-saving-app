import 'package:diary/Login/login.dart';
import 'package:diary/employees.dart/add_employee.dart';
import 'package:diary/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/employees.dart/employee_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_app/add_employee.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  final employees =
      FirebaseFirestore.instance.collection('Employees').snapshots();
  final employee = FirebaseFirestore.instance.collection('Employees');
  String docId = DateTime.now().microsecond.toString();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController profession = TextEditingController();
final auth =FirebaseAuth.instance;
  void logout(){
          auth.signOut();
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
           return LoginPage();
         },));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            logout();
           
          }, icon: const Icon(Icons.logout)),
           ],
        title: const Text('Employees'),
        backgroundColor: const Color.fromARGB(255, 13, 71, 119),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            
                Text('All employees'),
                 ],),
            
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: employees,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeDetails(
                                name:snapshot.data!.docs[index]['name'].toString(),
                              email:snapshot.data!.docs[index]['email'].toString(),
                              city:snapshot.data!.docs[index]['city'].toString(),
                              imgURL:snapshot.data!.docs[index]['imgURL'].toString(),
                              profession:snapshot.data!.docs[index]['profession']
                            ),
                          ),
                        );
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['imgURL']),
                            // child: snapshot.data!.docs[index]['imgURL'] == null
                            //     ? const Icon(Icons.supervised_user_circle)
                            //     : Image.network(
                            //         snapshot.data!.docs[index]['imgURL'],
                            //         fit: BoxFit.fill,
                            //       ),
                          ),
                          title: Text(
                            snapshot.data!.docs[index]['name'],
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]['email'],
                          ),
                          trailing: PopupMenuButton(
                            surfaceTintColor:
                                const Color.fromARGB(255, 172, 211, 244),
                            color: Colors.white,
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  value: 3,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.psychology,
                                      color: Color(0xFF0F4B7C),
                                    ),
                                    title: const Text(
                                      'Hire',
                                      style:
                                          TextStyle(color: Color(0xFF0F4B7C)),
                                    ),
                                    onTap: () {
                                      Utils().toastMessage(
                                          'He/she is hired!',
                                          const Color.fromARGB(
                                              255, 15, 75, 124));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.edit,
                                      color: Color(0xFF0F4B7C),
                                    ),
                                    title: const Text(
                                      'Edit',
                                      style:
                                          TextStyle(color: Color(0xFF0F4B7C)),
                                    ),
                                    onTap: () {
                                      showMyDailogue(
                                          snapshot.data!.docs[index]['name']
                                              .toString(),
                                          snapshot.data!.docs[index]['id']
                                              .toString(),
                                          snapshot.data!.docs[index]['email']
                                              .toString(),
                                          snapshot.data!.docs[index]['city']
                                              .toString(),
                                          snapshot.data!.docs[index]['imgURL']
                                              .toString(),
                                          snapshot
                                              .data!.docs[index]['profession']
                                              .toString());
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.delete_outline,
                                      color: Color(0xFF0F4B7C),
                                    ),
                                    title: const Text(
                                      'Delete',
                                      style:
                                          TextStyle(color: Color(0xFF0F4B7C)),
                                    ),
                                    onTap: () {
                                      employee
                                          .doc(snapshot.data!.docs[index]['id']
                                              .toString())
                                          .delete()
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ),
                              ];
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Text('No data to show');
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddEmployee();
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Future<void> showMyDailogue(String title, String id, String eemail,
      String ecity, String imgURL, String eprofession) async {
    return showDialog(
      context: context,
      builder: (context) {
        name.text = title;
        email.text = eemail;
        city.text = ecity;
        profession.text = eprofession;

        return AlertDialog(
          title: const Text(
            'Edit',
            style: TextStyle(
              color: Color(0xFF0F4B7C),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 172, 211, 244),
          content: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imgURL),
                  radius: 30,
                ),
                const SizedBox(
                  height: 8,
                ),
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
                  height: 8,
                ),
                TextFormField(
                  controller: profession,
                  decoration: const InputDecoration(
                    hintText: "Profession",
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
              ],
            ),
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFF0F4B7C),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                employee.doc(id).update({
                  'name': name.text.toString(),
                  'email': email.text.toString(),
                  'city': city.text.toString(),
                  'profession': profession.text.toString()
                }).then((value) {
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  Navigator.pop(context);
                });
              },
              child: const Text(
                'Save and close',
                style: TextStyle(
                  color: Color(0xFF0F4B7C),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
