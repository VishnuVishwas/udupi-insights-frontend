import 'package:flutter/material.dart';
import 'package:travel_app_getx/services/api_services.dart';

class TestApiPage extends StatefulWidget {
  const TestApiPage({super.key});

  @override
  State<TestApiPage> createState() => _TestApiPageState();
}

class _TestApiPageState extends State<TestApiPage> {
  ApiServices apiServices = ApiServices();
  late Future<List<dynamic>> places;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    places = apiServices.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Udupi Insights')),
      body: FutureBuilder<List<dynamic>>(
        future: places,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final place = snapshot.data![index];
                return ListTile(
                  title: Text(place['name']),
                  subtitle: Text(place['description']),
                  onTap: () {
                    // Navigate to details page
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
