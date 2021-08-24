import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
int y_1,x_1;
int player=0;
List<String> icon=['P1','P2','P3'];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<List<String>> gridState = [for (int i=0; i<6; i++) [for (int j=0;j<6; j++) '']];
  List<List<List<int>>> cluster_P1 = [];
  List<List<List<int>>> cluster_P2 = [];
  List<List<List<int>>> cluster_P3 = [];


  Widget _buildGameBody() {
    int gridStateLength = gridState.length;
    return Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0)
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridStateLength,
                ),
                itemBuilder: _buildGridItems,
                itemCount: gridStateLength * gridStateLength,
              ),
            ),
          ),
        ]);
  }
  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = gridState.length;
    int x, y = 0;

    y = (index / gridStateLength).floor();
    x = (index % gridStateLength);
    return GestureDetector(
      onTap: () => {
        if (gridState[x][y]==''){
          _setvertices(x, y),
          _stateckeck(x,y),
          if (player<2){
            player=player+1,
          }
          else {
            player=0,
          }
        },


      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)
          ),
          child: Center(
            child: _buildGridItem(x, y),
          ),
        ),
      ),
    );
  }
  Widget _buildGridItem(int x, int y) {
    switch (gridState[x][y]) {
      case '':
        return Text('');
        break;
      case 'P1':
        return Icon(
          Icons.account_circle_rounded,
          size: 40.0,
          color: Colors.red,
        );
        break;
      case 'P2':
        return Icon(
          Icons.account_circle_rounded,
          size: 40.0,
          color: Colors.blue,
        );
        break;
      case 'P3':
        return Icon(
          Icons.account_circle_rounded,
          size: 40.0,
          color: Colors.green,
        );
        break;
      case 'C':
        gridState[x][y]='';
        break;
      default:
        return Text(gridState[x][y].toString());
    }
  }


  //in progress
  void _cutvertices(int x, int y){




        gridState[x][y]='C';

    setState(() {

    });

  }
  void _checkneighbour(int x,int y,int d_1, int d_2, bool first){
    if(gridState[x][y]==gridState[x+d_1][y+d_1] && gridState[x][y]==icon[player]){
      if(gridState[x][y]==gridState[x-d_1][y-d_1]) {
        //3 in einer Reihe gefunden
        print('gefunden');
      }
      else if(first==true){
        if (0<x+d_1 && x+d_1< 6 && 0< y-1+d_1 && y-1+d_2<6){
          _checkneighbour( x+d_1, y+d_2, d_1,d_2, false);
        }
      }
    }

  }
  void _stateckeck(int x,int y){
    for (int i=0; i<3;i++){
      for (int j=0;j<3;j++){
        if (0<=x-1+i && x-1+i< 6 && 0<= y-1+j && y-1+j<6){
          if(gridState[x-1+i][y-1+j]==icon[player]){
            if (i-1!=0 || j-1!=0){
              _checkneighbour(x-1+i, y-1+j, i-1, j-1, true);
            }

          }
        }

      }
    }
    setState(() {

    });

  }
   void _setvertices(int x, int y){

    gridState[x][y]=icon[player];

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game World'),
      ),
      body: _buildGameBody(),
    );
  }
}
