import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_showcase/flutter_showcase.dart';

import 'shop_items_page.dart';
import 'jobs.dart';
import 'materialliste.dart';

const Color first_color = Colors.lightBlue;
final Color title_color = Colors.blue.shade800;

class MainPage extends StatefulWidget
{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  final List<List<double>> charts =
  [
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4,],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4]
  ];

  static final List<String> chartDropdownItems = [ 'Last 7 days', 'Last month', 'Last year' ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;


  @override
  Widget build(BuildContext context)
  {
    return Container
    (
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              first_color,
              Color(0xFF3A3E88),
            ],
          ),
        ),
        child: Theme(
            data: Theme.of(context).copyWith(
              accentColor: first_color,
            ),
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  //extendBodyBehindAppBar: true,
      appBar: AppBar
      (
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('Arbeitsgruppe', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
        actions: <Widget>
        [
          Container
          (

            margin: EdgeInsets.only(right: 8.0),
            child: Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>
              [
                //Text('beclothed.com', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 14.0)),
                //Icon(Icons.arrow_drop_down, color: Colors.black54)
              ],
            ),
          )
        ],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(14.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>
                    [
                      Text('Aktueller Auftrag', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.blueAccent)),
                      SizedBox(height: 10),
                      FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(' Straße X Hausnummer Y', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22.0))
                      ),

                    ],
                  ),

                  /*Material
                  (
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.assignment_outlined, color: Colors.white, size: 30.0),
                      )
                    )
                  )*/
                ]
              ),
            ),
            onTap: () => Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => ShowcaseWeatherTimeline())),

          ),
         /* _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.teal,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.settings_applications, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('General', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('Images, Videos', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Material
                  (
                    color: Colors.amber,
                    shape: CircleBorder(),
                    child: Padding
                    (
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  Text('Alerts', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                  Text('All ', style: TextStyle(color: Colors.black45)),
                ]
              ),
            ),
          ),*/
          _buildTile(
            Padding
                (
                  padding: const EdgeInsets.all(18.0),
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                          Column
                          (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('Tätgkeit dokumentieren', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.green)),
                              //Text('\$16K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                              SizedBox(height: 20),



                              TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tätigkeit ausführen',
                                )
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>
                                [

                                  _button("Start",Colors.green.withAlpha(70)),
                                  _button("Pause",Colors.blue.withAlpha(70)),
                                  _button("Abschluss",Colors.green.withAlpha(70)),

                                ],


                              ),

                            ],

                          ),
                          /*DropdownButton
                          (
                            isDense: true,
                            value: actualDropdown,
                            onChanged: (value ) => setState(()
                            {
                              actualDropdown = value.toString();
                              actualChart = chartDropdownItems.indexOf(value.toString()); // Refresh the chart
                            }),
                            items: chartDropdownItems.map((String title)
                            {
                              return DropdownMenuItem
                              (
                                value: title,
                                child: Text(title, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 14.0)),
                              );
                            }).toList()
                          )*/

                      //Padding(padding: EdgeInsets.only(bottom: 4.0)),

                    ],
                  )
                ),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
              [
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Material dokumentieren', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,color: Colors.redAccent)),
                      //Text('173', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                    ],
                  ),
                  Material
                  (
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.store, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
                    //Padding(padding: EdgeInsets.only(bottom: 4.0)),
                    SizedBox(height: 10,),
                    TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Material eintragen',
                        )
                    ),
                  ]
              ),
            ),
            onTap: () => Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => Showcasematerial())),
          ),
          _buildTile(
            Padding
              (
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                   [
                     Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      Column
                        (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Text('(Öffentliche) Notiz', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,color: Colors.yellow[500])),
                          Text('173', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                        ],
                      ),
                      Material
                        (
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center
                            (
                              child: Padding
                                (
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.mode_edit_outline_outlined, color: Colors.white, size: 30.0),
                              )
                          )
                      ),

                    ]
                ),
                Padding(padding: EdgeInsets.only(bottom: 4.0)),
               ]
              ),
            ),
            onTap: () => Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => ShopItemsPage())),
          )
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 110.0),
          //StaggeredTile.extent(1, 180.0),
          //StaggeredTile.extent(1, 180.0),
          StaggeredTile.extent(2, 200.0),
          StaggeredTile.extent(2, 180.0),
          StaggeredTile.extent(2, 180.0),
        ],
      )
    )
    )
      )
    );
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey.shade200.withOpacity(0.5),
      //color: Colors.grey.shade800.withOpacity(0.3),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }

  Widget _button(String text,Color color){
    return NeumorphicButton(
        margin: EdgeInsets.only(top: 12),
        onPressed: () {

        },
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          color: color,

          boxShape:

          NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
            shadowLightColor: Colors.blue.withOpacity(0.6)
          //border: NeumorphicBorder()
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          //style: TextStyle(color: _textColor(context)),
        ));
  }
}