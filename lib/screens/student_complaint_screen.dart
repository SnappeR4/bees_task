import 'package:flutter/material.dart';
import 'StudentComplaintsTab.dart';

class StudentComplaintScreen extends StatelessWidget {
  const StudentComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transport Management'),
          backgroundColor: Colors.lightBlue, // AppBar background color
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50), // Adjust TabBar height
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlue, // Ultra-light blue background
              ),
              child: const TabBar(
                tabs: [
                  Tab(text: 'Registered Details'),
                  Tab(text: 'Student Complaints'),
                ],
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlue, Colors.blueAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ), // Gradient for the active tab
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40),bottom: Radius.circular(40)),
                ),
                labelColor: Colors.white, // Active tab text color
                unselectedLabelColor: Colors.black, // Inactive tab text color
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            const RegisteredDetailsTab(),
            StudentComplaintsTab(),
          ],
        ),
      ),
    );
  }
}

class RegisteredDetailsTab extends StatelessWidget {
  const RegisteredDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Registered Details Tab',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

