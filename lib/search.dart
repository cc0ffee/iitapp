import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myiit/services/collection.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  List urlsOriginal = [
    {"name": "Example", "url": "http://example.com/"},
    {"name": "Example2", "url": "http://example.com/"},
  ];

  List urls = [
    {"name": "Example", "url": "http://example.com/"},
    {"name": "Example2", "url": "http://example.com/"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
            margin: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey))),
              onChanged: searchUrl,
            )),
        Expanded(
          child: ListView.builder(
              itemCount: urls.length,
              itemBuilder: ((context, index) {
                var link = urls[index];
                return ListTile(
                  title: Text(link["name"]!),
                  onTap: (() async {
                    Uri url = Uri.parse(link["url"]);
                    var urlluanchable = await canLaunchUrl(url);
                    if (urlluanchable) {
                      await launchUrl(url);
                    } else {
                      print("FAIL");
                    }
                  }),
                );
              })),
        )
      ]),
    );
  }

  void searchUrl(String query) {
    final suggestions = urlsOriginal.where((link) {
      final linkTitle = link["name"]?.toLowerCase();
      final input = query.toLowerCase();

      return linkTitle.contains(input);
    }).toList();
    setState(() => urls = suggestions);
  }
}
