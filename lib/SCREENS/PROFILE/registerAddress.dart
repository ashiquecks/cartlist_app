import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cntHouse = TextEditingController();
  TextEditingController cntLandmark = TextEditingController();
  TextEditingController cntPlace = TextEditingController();
  TextEditingController cntPostCode = TextEditingController();
  TextEditingController cntCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Your Address"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: cntHouse,
                  decoration: const InputDecoration(
                    labelText: 'House/Building Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter House/Building Name";
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextFormField(
                  controller: cntLandmark,
                  decoration: const InputDecoration(
                    labelText: 'Land Mark',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter Land Mark";
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextFormField(
                  controller: cntPlace,
                  decoration: const InputDecoration(
                    labelText: 'Place',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter Place";
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextFormField(
                  controller: cntPostCode,
                  decoration: const InputDecoration(
                    labelText: 'Postel Code',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter Postel Code";
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextFormField(
                  controller: cntCity,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Enter City";
                    }
                  }),
                ),
              ),
              loginButton(
                context: context,
                buttonText: "SUBMIT ADDRESS",
                buttonAction: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  createAddressToShared(
                    userHoseName: cntHouse.text,
                    userLandMark: cntLandmark.text,
                    userPlace: cntPlace.text,
                    userPostcode: cntPostCode.text,
                    userCity: cntCity.text,
                    addressAdded: true,
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
