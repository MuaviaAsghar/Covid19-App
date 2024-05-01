import 'dart:convert';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'country_data.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  late Future<List<Map<String, String>>> countriesData;
  late List<Map<String, String>> filteredCountries;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countriesData = getCountriesList();
    filteredCountries = [];
  }

  Future<List<Map<String, String>>> getCountriesList() async {
    const countryUrl = "https://disease.sh/v3/covid-19/countries/";
    final countryResponse = await http.get(Uri.parse(countryUrl));

    if (countryResponse.statusCode == 200) {
      final List<dynamic> data = json.decode(countryResponse.body);
      return data.map<Map<String, String>>((countryData) {
        return {
          'name': countryData['country'] ?? 'Unknown',
          'code': countryData['countryInfo']['iso2'] ?? 'XX',
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch countries');
    }
  }

  void _filterCountries(String query, List<Map<String, String>> countries) {
    setState(() {
      if (query.isNotEmpty) {
        filteredCountries = countries
            .where((country) =>
                country['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredCountries = countries;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries Data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                hintText: 'Search Country',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                countriesData.then((countries) {
                  _filterCountries(query, countries);
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: countriesData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final countries = snapshot.data!;
                  return ListView.builder(
                    itemCount: filteredCountries.isNotEmpty
                        ? filteredCountries.length
                        : countries.length,
                    itemBuilder: (context, index) {
                      final countryName = filteredCountries.isNotEmpty
                          ? filteredCountries[index]['name']
                          : countries[index]['name'];
                      final countryCode = filteredCountries.isNotEmpty
                          ? filteredCountries[index]['code']
                          : countries[index]['code'];
                      return ListTile(
                        leading: CountryFlag.fromCountryCode(
                          countryCode!,
                          height: 20,
                          width: 40,
                        ),
                        title: Text(countryName!),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CountryData(countryName: countryName),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
