import 'dart:ui';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _glassnumberTEcontroller =
      TextEditingController(text: "1");

  List<Watertrack> waterTracklist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "W A T E R       Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWatertrackCounter(),
          const SizedBox(
            height: 24,
          ),
          Expanded(child: _buildwatertracklistview()),
        ],
      ),
    );
  }

  Widget _buildwatertracklistview() {
    return ListView.separated(
        itemCount: waterTracklist.length,
        itemBuilder: (context, index) {
          final Watertrack watertrack = waterTracklist[index];
          return Container(
            decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(4.0, 4.0),
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(-4.0, -4.0),
              )
            ]),
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('${watertrack.noOfGlasses}'),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time: ${watertrack.dateTime.hour.toString().padLeft(2, '0')}:${watertrack.dateTime.minute.toString().padLeft(2, '0')}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Date: ${watertrack.dateTime.day}/${watertrack.dateTime.month}/${watertrack.dateTime.year}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 80,
                ),
                Image.asset(
                  'images/water.png',
                  height: 60,
                  width: 60,
                ),
                const Spacer(),
                IconButton(
                    color: Colors.red,
                    onPressed: () => _ontabdeletebutton(index),
                    icon: Icon(Icons.delete)),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        });
  }

  // Required for ImageFilter.blur

  Widget _buildWatertrackCounter() {
    return Container(
      color: Colors.blue[200],
      child: Stack(
        children: [
          // This is the blurred background using BackdropFilter
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 20, sigmaY: 20), // Apply the blur effect
              child: Container(
                color: Colors.black.withOpacity(
                    0), // Transparent container to support the blur
              ),
            ),
          ),
          // The actual content on top of the blurred background
          Column(
            children: [
              Text(
                getTotalGlasscount().toString(),
                style: TextStyle(fontSize: 59),
              ),
              Text(
                "Glass/s",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _glassnumberTEcontroller,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    onPressed: _addnewWatertrack,
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  int getTotalGlasscount() {
    int counter = 0;
    for (Watertrack t in waterTracklist) {
      counter += t.noOfGlasses;
    }
    return counter;
  }

  void _addnewWatertrack() {
    if (_glassnumberTEcontroller.text.isEmpty ||
        int.tryParse(_glassnumberTEcontroller.text) == null) {
      _glassnumberTEcontroller.text = "1";
    }
    final int numberofglasses = int.parse(_glassnumberTEcontroller.text);
    Watertrack watertrack = Watertrack(numberofglasses, DateTime.now());
    waterTracklist.add(watertrack);
    setState(() {});
  }

  void _ontabdeletebutton(int index) {
    waterTracklist.removeAt(index);
    setState(() {});
  }
}

class Watertrack {
  final int noOfGlasses;
  final DateTime dateTime;

  Watertrack(this.noOfGlasses, this.dateTime);
}
