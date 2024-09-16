import 'package:flutter/material.dart';

class Testt extends StatefulWidget {
  const Testt({super.key});

  @override
  State<Testt> createState() => _TesttState();
}

class _TesttState extends State<Testt> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: 300,
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueAccent,
          child: SizedBox(
            height: 50,
            child: Stack(
              children: [
                Container(
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        color: Colors.grey,
                      )),
                      Expanded(
                          child: Container(
                        color: Colors.blueAccent,
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected = !_selected;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: _selected ? Colors.grey : Colors.blueAccent,
                          ),
                          alignment: Alignment.center,
                          child: Text("A"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected = !_selected;
                          });
                          print("SS$_selected");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            color: _selected ? Colors.blueAccent : Colors.grey,
                          ),
                          alignment: Alignment.center,
                          child: Text("B"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
