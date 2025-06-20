import 'package:flutter/material.dart';
import '../viewmodels/leaderboard_viewmodel.dart';
import '../models/user_model.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final viewModel = LeaderboardViewModel();
  late Future<List<UserModel>> _futureUsers;
  bool _isAscending = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    _futureUsers = viewModel.fetchUsers(ascending: _isAscending);
  }

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
      _loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(
              _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.white,
            ),
            onPressed: _toggleSortOrder,
            tooltip: _isAscending ? 'Sort Descending' : 'Sort Ascending',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/stars.avif'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<UserModel>>(
          future: _futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No users found.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              final users = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 100),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(
                      user.name,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    subtitle: Text(
                      'Score: ${user.score}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
