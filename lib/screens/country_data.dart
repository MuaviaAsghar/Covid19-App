import 'dart:convert';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_containers.dart/cstmCountrydataRow.dart';

class CountryData extends StatelessWidget {
  final String countryName;

  const CountryData({Key? key, required this.countryName}) : super(key: key);

  Future<Map<String, dynamic>> _fetchCountryData() async {
    final countryUrl = "https://disease.sh/v3/covid-19/countries/$countryName";
    final response = await http.get(Uri.parse(countryUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load country data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          countryName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchCountryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final countryData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CountryFlag.fromCountryCode(
                      countryData['countryInfo']['iso2'],
                      height: 400,
                    ),
                    CustomRowCountryData(
                      text1: "Continent",
                      text2: countryData['continent'].toString(),
                    ),
                     CustomRowCountryData(
                      text1: "Population",
                      text2: countryData['population'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Cases Reported Today",
                      text2: countryData['todayCases'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Cases",
                      text2: countryData['cases'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Total Deaths",
                      text2: countryData['deaths'].toString(),
                    ),
                    
                    CustomRowCountryData(
                      text1: "Recovered",
                      text2: countryData['recovered'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Number Of People Recovered Today",
                      text2: countryData['todayRecovered'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Active Cases",
                      text2: countryData['active'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Critical Cases",
                      text2: countryData['critical'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Deaths",
                      text2: countryData['deaths'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Deaths",
                      text2: countryData['deaths'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Cases Per Million",
                      text2: countryData['casesPerOneMillion'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Deaths Per Million",
                      text2: countryData['deathsPerOneMillion'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Tests",
                      text2: countryData['tests'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Tests Per Million",
                      text2: countryData['testsPerOneMillion'].toString(),
                    ),
                   
                    
                    CustomRowCountryData(
                      text1: "One Case Per People",
                      text2: countryData['oneCasePerPeople'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "One Death Per People",
                      text2: countryData['oneDeathPerPeople'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "One Test Per People",
                      text2: countryData['oneTestPerPeople'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Active Per Million",
                      text2: countryData['activePerOneMillion'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Recovered Per Million",
                      text2: countryData['recoveredPerOneMillion'].toString(),
                    ),
                    CustomRowCountryData(
                      text1: "Critical Per Million",
                      text2: countryData['criticalPerOneMillion'].toString(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
