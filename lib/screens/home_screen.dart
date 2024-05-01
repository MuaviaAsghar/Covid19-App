import 'package:covid19_app/custom_containers.dart/cstm_containers.dart';
import 'package:flutter/material.dart';

import '../custom_containers.dart/custom_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19'),
        centerTitle: true,
        toolbarHeight: 120,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CstmContainer(
              textInput1: 'Total Number Of Cases',
              textInput2: '704,753,890',
              cstmRadius: 15,
              cstmHeight: 200,
              cstmWidth: 400,
              colorinput: Colors.blueAccent,
              showTextInput3: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CstmContainer(
                  textInput1: 'Deaths',
                  textInput2: "7,010,681",
                  cstmRadius: 15,
                  cstmHeight: 150,
                  cstmWidth: 400,
                  colorinput: Colors.blueAccent,
                  showTextInput3: false),
            ),
            CstmContainer(
                textInput1: 'Recovered',
                textInput2: "675,619,811",
                cstmRadius: 15,
                cstmHeight: 150,
                cstmWidth: 400,
                colorinput: Colors.blueAccent,
                showTextInput3: false),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: CstmRow(),
            )
          ],
        ),
      ),
    );
  }
}
