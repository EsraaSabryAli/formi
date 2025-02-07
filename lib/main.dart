import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(StepperFormApp());
}

class StepperFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StepperFormScreen(),
    );
  }
}

class StepperFormScreen extends StatefulWidget {
  @override
  _StepperFormScreenState createState() => _StepperFormScreenState();
}

class _StepperFormScreenState extends State<StepperFormScreen> {
  int _currentStep = 0;
  bool isCompleted = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController licensePlateNumberController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carPriceController = TextEditingController();
  String? selectedInsuranceType;
  String? selectedInsuranceDuration;
  bool roadsideAssistance = false;
  bool replacementCar = false;
  bool driverInsurance = false;
  String? uploadedFile;

  String? filePickerError; // Declare an error message variable

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Allow all file types
      );

      if (result != null) {
        setState(() {
          uploadedFile = result.files.single.name;
          filePickerError =
              null; // Clear error if file is selected successfully
        });
      } else {
        setState(() {
          filePickerError =
              "No file selected"; // Display error if no file is selected
        });
      }
    } catch (e) {
      setState(() {
        filePickerError =
            "Error selecting file: $e"; // Show the error on screen
      });
    }
  }

  List<Step> getSteps() => [
        Step(
          title: Text(
            "Personal Information",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color.fromRGBO(2, 27, 61, 1), fontSize: 20),
          ),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter your name";
                  }
                  return null;
                },
                // key: Key("Name"),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  // labelText: "Name",
                  labelStyle: TextStyle(fontSize: 18),
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                    ),
                  ),

                  // fillColor: Color.fromRGBO(202, 234, 255, 1),
                  // filled: true,
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "ID",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: idController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your ID";
                  }
                  if (value.length != 14) {
                    return "ID must be 14 characters long";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  // labelText: "ID",
                  hintText: "Enter your ID",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                maxLength: 14,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your email";
                  }
                  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,}$')
                      .hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color.fromRGBO(9, 31, 91, 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your phone number";
                  }

                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter your Phone",
                  hintStyle: TextStyle(),
                  prefixIcon: Icon(Icons.phone_outlined,
                      color: Color.fromRGBO(9, 31, 91, 1)),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                maxLength: 11,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
        ),
        Step(
          title: Flexible(
              child: Text("Car Details",
                  style: TextStyle(
                      color: Color.fromRGBO(2, 27, 61, 1), fontSize: 20),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis)),
          content: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "License plate number",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: licensePlateNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "License plate number is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                maxLength: 7,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Car Type",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: carTypeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Car type";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Car Model",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: carModelController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Car Model";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Car Price",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: carPriceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Car Price";
                  }
                  // Check if the value is a valid number
                  if (double.tryParse(value) == null) {
                    return "Enter a valid number for Car Price";
                  }
                  // Check if the value is a positive number
                  if (double.tryParse(value)! <= 0) {
                    return "Price must be a positive number";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
        ),
        Step(
          title: Flexible(
            child: Text(
              "Insurance Options",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Color.fromRGBO(2, 27, 61, 1), fontSize: 20),
            ),
          ),
          content: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Insurance Type",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(2, 27, 61, 1),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                value: selectedInsuranceType,
                items: ["Basic", "Premium", "Gold"].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) =>
                    setState(() => selectedInsuranceType = value),
                validator: (value) =>
                    value == null ? "Please select an insurance type" : null,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Insurance Type",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(48, 74, 110, 1),
                      width: 1.0,
                    ),
                  ),
                ),
                value: selectedInsuranceDuration,
                items: ["1 Year", "2 Years", "3 Years"].map((duration) {
                  return DropdownMenuItem(
                      value: duration, child: Text(duration));
                }).toList(),
                onChanged: (value) =>
                    setState(() => selectedInsuranceDuration = value),
                validator: (value) => value == null
                    ? "Please select an insurance duration"
                    : null,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Optional Add_Ons",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title: Text("Roadside Assistance"),
                value: roadsideAssistance,
                onChanged: (value) =>
                    setState(() => roadsideAssistance = value!),
              ),
              CheckboxListTile(
                title: Text("Replacement car in case of accident"),
                value: replacementCar,
                onChanged: (value) => setState(() => replacementCar = value!),
              ),
              CheckboxListTile(
                title: Text("Driver and passenger insurance"),
                value: driverInsurance,
                onChanged: (value) => setState(() => driverInsurance = value!),
              ),
            ],
          ),
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
        ),
        Step(
          title: Text(
            "Required Documents",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color.fromRGBO(2, 27, 61, 1), fontSize: 20),
          ),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: pickFile,
                child: Text("Upload Car Document"),
              ),
              if (filePickerError !=
                  null) // Check if there's an error to display
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    filePickerError!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
            ],
          ),

          isActive: _currentStep >= 3,
          state: uploadedFile != null
              ? StepState.complete
              : StepState.error, // Show error state if no file is uploaded
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Adjust height for the curve
        child: AppBar(
          backgroundColor: Color.fromRGBO(1, 51, 169, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50), // Circular bottom
            ),
          ),
          title: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("New Insurance Policy",
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: isCompleted
          ? buildCompleted()
          : Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Color.fromRGBO(9, 31, 91, 1),
                  onPrimary: Colors.white,
                  secondary: Colors.grey,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Stepper(
                  type: StepperType.vertical,
                  currentStep: _currentStep,
                  steps: getSteps(),
                  onStepContinue: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        if (_currentStep < getSteps().length - 1) {
                          _currentStep += 1;
                        } else {
                          isCompleted = true;
                        }
                      });
                    }
                  },
                  onStepTapped: (step) => setState(() => _currentStep = step),
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() => _currentStep -= 1);
                    }
                  },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentStep > 0)
                            ElevatedButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back"),
                            ),
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: Text(_currentStep == getSteps().length - 1
                                ? "Submit"
                                : "Next"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget buildCompleted() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Policy Submitted Successfully!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(
                    1, 33, 78, 1), // Background color for the button
              ),
              onPressed: () {
                setState(() {
                  isCompleted = false;
                  _currentStep = 0;
                });
              },
              child: Text(
                "Add New Policy ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
