import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
int y_1,x_1;
bool player_1=false;
bool player_2=false;
int edges_number=5;
num vertex_counter =0;
bool falldown=false;

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

  List<List<String>> gridState = [for (int i=0; i<30; i++) [for (int j=0;j<30; j++) '']];


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

        if ((player_1==true)  && (player_2==true)){
          if (vertex_counter < edges_number){
            _setvertices(x, y),
            vertex_counter= vertex_counter+0.5,
          }
          else{
               if (falldown==false ){
                   _cutvertices(x, y),
                   //vertex_counter= vertex_counter+0.5,
               }
          }
        },
        if ((player_1==false) || (player_2 ==false)){

            _setplayers(x, y),

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
          color: Colors.brown,
        );
        break;
      case 'P2':
        return Icon(
          Icons.account_circle_rounded,
          size: 40.0,
          color: Colors.blue,
        );
          break;
      case 'E':
        return Icon(
          Icons.circle,
          size: 10.0,
          color: Colors.red,
        );
        break;
      case 'C':
         gridState[x][y]='';
        break;
      default:
        return Text(gridState[x][y].toString());
    }
  }

  void _setplayers(int x, int y,){
    if (player_1==false){
      gridState[x][y]='P1';

      setState(() {

      });
    }
    if (player_1==true){
      gridState[x][y]='P2';
      setState(() {

      });
      player_2=true;
    }
    player_1=true;
  }

  //in progress
  void _cutvertices(int x, int y){
    List<List <int>> remember =[];
    int count =0;

    for (int i=-1;i<2; i++) {
      if (gridState[x - 1][y + i] == 'E') {
        count = count + 1;
        remember.add([x - 1,y + i]);
      }
    }
      for (int i=-1;i<2; i++){
        if(gridState[x][y+i]=='E'){
          count=count+1;
          remember.add([x,y+i]);
        }
    }
    for (int i=-1;i<2; i++) {
      if (gridState[x + 1][y + i] == 'E') {
        count = count + 1;
        remember.add([x + 1,y + i]);
      }
    }
    if (count<4){
      for (int i=0; i<count; i++){
        gridState[x][y]='C';
        _cutvertices(remember[i][0], remember[i][1]);
      }

    }
    setState(() {

    });

  }
 /* void _setvertices(int x, int y){
    _counter=_counter+1;
    if (_counter==1){
       x_1 = x;
       y_1 = y;
      }
    if (_counter==2){
      double m = (y_1-y) / (x_1-x);
        if ((x-x_1)>0){
          for (int i =1; i< x-x_1; i++){
            print((i * m).round() + y_1);
              gridState[(x_1+i)][(i * m).round() + y_1]='E';


          }
        }
        if ((x_1-x)>0){
          for (int i =1; i< x_1-x; i++){
            gridState[(x+i)][(i * m).round() + y]='E';
          }
        }
      if ((x_1-x)==0){
        if ((y-y_1)>0){
          for (int i =1; i< y-y_1; i++){
            print((i * m).round() + y_1);
            gridState[(x_1)][i + y_1]='E';
          }
        }
        if ((y_1-y)>0){
          for (int i =1; i< y_1-y; i++){
            gridState[(x)][i + y]='E';
          }
        }
      }
      _counter =0;
    }
    gridState[x][y]='E';
    setState(() {

    });
  }*/
  void _setvertices(int x, int y){
    _counter=_counter+1;
    if (_counter==1){
      x_1 = x;
      y_1 = y;
    }
    if (_counter==2){
      double m = (y_1-y) / (x_1-x);
      if (b==false)
    }
    gridState[x][y]='E';
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
