import 'package:flutter/material.dart';
import 'package:learning_dart/pages/initial_screen.dart';
import 'package:learning_dart/pages/poly_line_screen.dart';


class TabBarScreen extends StatefulWidget {
  TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
   @override
  Widget build(BuildContext context) {
   
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mapas'),
            bottom: const TabBar(
              tabs:[
                //tudo isso vai ser modificado para as telas
                Tab(
                  icon: Icon(
                    Icons.map_rounded,
                    color: Colors.white
                ),
                ),
                Tab(
                  icon: Icon(
                    Icons.map_rounded,
                    color: Colors.white
                  ),
                ),
                ],
                ),
        ),

        body:  TabBarView(
          //physics: NeverScrollableScrollPhysics(),
          children: [
            
            // TELA 1
            PolylineScreen(),

            // TELA 2
            InitialScreen(),
          ],
          ),
        ),
      );
  }
}