import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';

class MyWidget extends StatelessWidget {

  List<Text> list=[Text("name1"),Text("name2")];
  MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Container(decoration: PageConstants.PAGEBACKGROUND,
    width:screenWidth ,
    child: ListView.builder( itemCount: list.length, 
     itemBuilder: (context,index)=>Container(color: Colors.red, width: 0.95*screenWidth,
     child: Column(children: <Widget>[list[index],
     SizedBox(height: 30,)],),),));
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 30,
    unselectedItemColor: Colors.grey,
    currentIndex: 2,
    fixedColor: Color(0xff15733A),
    items: const[
      BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_outlined)),
      BottomNavigationBarItem(label: "Review", icon: Icon(Icons.reviews_outlined)),
      BottomNavigationBarItem(label: "Application", icon: Icon(Icons.file_copy_outlined)),
      BottomNavigationBarItem(label: "Payment", icon: Icon(Icons.currency_rupee_outlined)),
    ],
    );
  }
}

class SplashButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Button tapped!");
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.blue.withOpacity(0.3), // Splash color setup
          highlightColor: Colors.blue.withOpacity(0.1),
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Tap Me',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceApplicationForm extends StatefulWidget {
  const ServiceApplicationForm({Key? key}) : super(key: key);

  @override
  State<ServiceApplicationForm> createState() => _ServiceApplicationFormState();
}

class _ServiceApplicationFormState extends State<ServiceApplicationForm> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  String _serviceName = '';
  String _instructorId = '';
  String _serviceFee = '';
  String _serviceDescription = '';
  final _documentFields = <String>[]; // List to store document names

  // Add a method to handle adding new document fields
  void _addDocumentField() {
    setState(() {
      _documentFields.add('Document ${_documentFields.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Service Application'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the service name.';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _serviceName = value!), // Save using setState
              ),

              // Instructor ID
              TextFormField(
                decoration: const InputDecoration(labelText: 'Instructor ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the instructor ID.';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _instructorId = value!),
              ),

              // Service Fee
              TextFormField(
                decoration: const InputDecoration(labelText: 'Service Fee'),
                keyboardType: TextInputType.number, // Set keyboard type for numbers
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the service fee.';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _serviceFee = value!),
              ),

              // Service Description
              TextFormField(
                decoration: const InputDecoration(labelText: 'Service Description'),
                minLines: 3,
                maxLines: 5, // Allow multiple lines for description
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service description.';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _serviceDescription = value!),
              ),

              const SizedBox(height: 16.0), // Add some vertical spacing

              // Document Fields
              Text('Documents required'),
              Wrap(
                children: [
                  for (final documentField in _documentFields)
                    Chip(
                      label: Text(documentField),
                      onDeleted: () => setState(() => _documentFields.remove(documentField)),
                    ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _addDocumentField,
                icon: const Icon(Icons.add),
                label: const Text('Add Document'),
              ),

              // Add additional document input fields here (if needed)

              const SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Process form data
                    print('Service Name: $_serviceName');
                    print('Instructor ID: $_instructorId');
                    print('Service Fee: $_serviceFee');
                    print('Service Description: $_serviceDescription');
                    print('Documents: $_documentFields');

                    // Implement your form submission logic here (e.g., send data to server)
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}