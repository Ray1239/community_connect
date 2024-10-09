import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:community_connect/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userName;
  String? userMail;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await _auth.currentUser;
  }

  Future<void> fetchUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? 'User'; // Use 'User' if displayName is null
        userMail = user.email ?? "email";
      });
    } else {
      setState(() {
        userName = 'Guest';
        userMail = 'Guest Email';
      });
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'HappyFood',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              background: Image.network(
                'https://images.unsplash.com/photo-1490818387583-1baba5e638af',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: signOut,
                tooltip: 'Sign Out',
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display User's Name
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Welcome, ${userName ?? 'User'}! Your Email is: $userMail', // Display user's name
                      style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  // Slogan Section
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Feeding a life is more fulfilling than filling a bin.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  // User Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Donations', '23'),
                        _buildStatItem('Saved (kg)', '156'),
                        _buildStatItem('Impact', '78 people'),
                      ],
                    ),
                  ),
                  // Buttons for Key Features
                  _buildFeatureButton(
                    context,
                    icon: Icons.fastfood,
                    label: 'Donate Food',
                    onTap: () {
                      // Navigate to Donate Food Page
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildFeatureButton(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Track Expiration',
                    onTap: () {
                      // Navigate to Track Expiration Page
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildFeatureButton(
                    context,
                    icon: Icons.map,
                    label: 'Nearby Food Banks',
                    onTap: () {
                      // Navigate to Nearby Food Banks Page
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildFeatureButton(
                    context,
                    icon: Icons.person_outline,
                    label: 'Volunteer Network',
                    onTap: () {
                      // Navigate to Volunteer Network Page
                    },
                  ),
                  // Recent Activity
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Activity',
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildActivityItem('Donated 5kg of rice', '2 days ago'),
                        _buildActivityItem('Volunteered at Food Bank', '1 week ago'),
                      ],
                    ),
                  ),
                  // Footer: Vision Statement
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Our Vision: Reducing food waste, feeding lives, and building a sustainable community.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick donate action
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            color: Colors.green.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 24.0),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16.0),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
