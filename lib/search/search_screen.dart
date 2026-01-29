import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void submitCity() {
    if (_controller.text.trim().isEmpty) return;

    Navigator.pop(context, _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search City")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => submitCity(),
              decoration: InputDecoration(
                hintText: "Enter city name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: submitCity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
