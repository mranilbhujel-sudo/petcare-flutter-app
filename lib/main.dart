import 'package:flutter/material.dart';

void main() {
  runApp(const PetCareApp());
}

// ============================================================
// PETCARE APPLICATION
// ============================================================

class PetCareApp extends StatelessWidget {
  const PetCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5FBF9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      // App starts at Login Page
      home: const LoginPage(),
    );
  }
}

// ============================================================
// LOGIN PAGE
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  String message = '';

  void login() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      setState(() {
        message = 'Please enter your email and password.';
      });
      return;
    }

    setState(() {
      message = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 35,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 35),

              // Logo
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.pets,
                    size: 55,
                    color: Colors.pink,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to continue caring for your pet.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 35),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@email.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              if (message.isNotEmpty)
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF172033),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const RegisterPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'PetCare',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REGISTER PAGE
// ============================================================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;

  void register() {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields'),
        ),
      );
      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),

            const Icon(
              Icons.pets,
              size: 65,
              color: Colors.pink,
            ),

            const SizedBox(height: 20),

            const Text(
              'Create your account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Set up PetCare in just a few steps.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: confirmPasswordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon:
                const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF172033),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Already have an account? Sign in',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget featureCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: iconColor,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PetCare',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              'Welcome to PetCare 🐾',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              'Manage your pet information and important reminders.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Main Functions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // FUNCTION 1
            featureCard(
              context: context,
              icon: Icons.pets,
              iconColor: Colors.teal,
              title: 'Pet Profile',
              subtitle: 'Add and view your pet details',
              page: const PetProfilePage(),
            ),

            // FUNCTION 2
            featureCard(
              context: context,
              icon: Icons.notifications_active,
              iconColor: Colors.orange,
              title: 'Pet Reminders',
              subtitle:
              'Create feeding, medicine and vet reminders',
              page: const RemindersPage(),
            ),

            const SizedBox(height: 12),

            const Divider(),

            const SizedBox(height: 10),

            const Text(
              'Future Functions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.local_hospital,
                color: Colors.grey,
              ),
              title: Text('Vet Appointments'),
              subtitle: Text(
                'Prototype only - not implemented',
              ),
            ),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.medical_information,
                color: Colors.grey,
              ),
              title: Text('Health Records'),
              subtitle: Text(
                'Prototype only - not implemented',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PET PROFILE PAGE
// ============================================================

class PetProfilePage extends StatefulWidget {
  const PetProfilePage({super.key});

  @override
  State<PetProfilePage> createState() =>
      _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  String petName = 'Milo';
  String petType = 'Dog';
  String breed = 'Golden Retriever';
  String gender = 'Male';
  String birthday = '10 May 2021';
  String weight = '28.5 kg';

  void editPet() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditPetPage(
          currentName: petName,
          currentType: petType,
          currentBreed: breed,
          currentGender: gender,
          currentBirthday: birthday,
          currentWeight: weight,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        petName = result['name'] ?? petName;
        petType = result['type'] ?? petType;
        breed = result['breed'] ?? breed;
        gender = result['gender'] ?? gender;
        birthday = result['birthday'] ?? birthday;
        weight = result['weight'] ?? weight;
      });
    }
  }

  Widget infoRow(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.pink.shade100,
                child: Text(
                  petName.isNotEmpty
                      ? petName[0].toUpperCase()
                      : 'P',
                  style: const TextStyle(
                    fontSize: 42,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Center(
              child: Text(
                petName,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Center(
              child: Text(
                '$petType • $breed',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            const SizedBox(height: 18),

            Center(
              child: ElevatedButton.icon(
                onPressed: editPet,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            infoRow('Pet Name', petName),
            infoRow('Pet Type', petType),
            infoRow('Breed', breed),
            infoRow('Gender', gender),
            infoRow('Birthday', birthday),
            infoRow('Weight', weight),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EDIT PET PAGE
// ============================================================

class EditPetPage extends StatefulWidget {
  final String currentName;
  final String currentType;
  final String currentBreed;
  final String currentGender;
  final String currentBirthday;
  final String currentWeight;

  const EditPetPage({
    super.key,
    required this.currentName,
    required this.currentType,
    required this.currentBreed,
    required this.currentGender,
    required this.currentBirthday,
    required this.currentWeight,
  });

  @override
  State<EditPetPage> createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController breedController;
  late TextEditingController genderController;
  late TextEditingController birthdayController;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.currentName);

    typeController =
        TextEditingController(text: widget.currentType);

    breedController =
        TextEditingController(text: widget.currentBreed);

    genderController =
        TextEditingController(text: widget.currentGender);

    birthdayController =
        TextEditingController(text: widget.currentBirthday);

    weightController =
        TextEditingController(text: widget.currentWeight);
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    breedController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void saveProfile() {
    Navigator.pop(
      context,
      {
        'name': nameController.text,
        'type': typeController.text,
        'breed': breedController.text,
        'gender': genderController.text,
        'birthday': birthdayController.text,
        'weight': weightController.text,
      },
    );
  }

  Widget inputField(
      String label,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add / Edit Pet'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(
                Icons.pets,
                size: 70,
                color: Colors.pink,
              ),
            ),

            const SizedBox(height: 25),

            inputField(
              'Pet Name',
              nameController,
            ),

            inputField(
              'Pet Type',
              typeController,
            ),

            inputField(
              'Breed',
              breedController,
            ),

            inputField(
              'Gender',
              genderController,
            ),

            inputField(
              'Birthday',
              birthdayController,
            ),

            inputField(
              'Weight',
              weightController,
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF172033),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Save Pet Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REMINDERS PAGE
// ============================================================

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() =>
      _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final List<Map<String, String>> reminders = [
    {
      'type': 'Medication',
      'title': 'Give Milo medication',
      'date': 'Today',
      'time': '6:00 PM',
    },
    {
      'type': 'Feeding',
      'title': 'Evening feeding',
      'date': 'Today',
      'time': '7:00 PM',
    },
    {
      'type': 'Vaccination',
      'title': 'Annual vaccination',
      'date': '28 Sep 2026',
      'time': '10:00 AM',
    },
  ];

  void addReminder() async {
    final newReminder =
    await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const AddReminderPage(),
      ),
    );

    if (newReminder != null) {
      setState(() {
        reminders.add(newReminder);
      });
    }
  }

  IconData getIcon(String type) {
    switch (type) {
      case 'Medication':
        return Icons.medication;
      case 'Feeding':
        return Icons.restaurant;
      case 'Vaccination':
        return Icons.vaccines;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Reminders'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addReminder,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: addReminder,
                icon: const Icon(Icons.add),
                label: const Text('Add Reminder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF172033),
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Your Reminders',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: reminders.isEmpty
                  ? const Center(
                child: Text(
                  'No reminders available.',
                ),
              )
                  : ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder =
                  reminders[index];

                  return Card(
                    margin:
                    const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: ListTile(
                      contentPadding:
                      const EdgeInsets.all(12),

                      leading: CircleAvatar(
                        backgroundColor:
                        Colors.orange.shade100,
                        child: Icon(
                          getIcon(
                            reminder['type']!,
                          ),
                          color: Colors.orange,
                        ),
                      ),

                      title: Text(
                        reminder['title']!,
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        '${reminder['date']} at ${reminder['time']}\n${reminder['type']}',
                      ),

                      isThreeLine: true,

                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            reminders.removeAt(
                              index,
                            );
                          });

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Reminder deleted',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ADD REMINDER PAGE
// ============================================================

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() =>
      _AddReminderPageState();
}

class _AddReminderPageState
    extends State<AddReminderPage> {
  final titleController = TextEditingController();
  final dateController =
  TextEditingController(text: 'Today');
  final timeController =
  TextEditingController(text: '6:00 PM');

  String selectedType = 'Feeding';

  final List<String> reminderTypes = [
    'Feeding',
    'Medication',
    'Vaccination',
    'Grooming',
    'Vet',
  ];

  void saveReminder() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a reminder title',
          ),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      {
        'type': selectedType,
        'title': titleController.text,
        'date': dateController.text,
        'time': timeController.text,
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reminder'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedType,
              decoration: InputDecoration(
                labelText: 'Reminder Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: reminderTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedType = value;
                  });
                }
              },
            ),

            const SizedBox(height: 18),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Reminder Title',
                hintText: 'Example: Give Milo medicine',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: 'Time',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: saveReminder,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF172033),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Save Reminder',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}