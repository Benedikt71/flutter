import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}
List <double> inputVal = [0,0,0];
List <int> check_status = [1,1,1];
var sum = inputVal.reduce((a, b) => a + b);
String Job='';
final List <String> Ziel=['niedrigster', 'höchster'];
final List <String> wert=['Wert', 'Anteil'];
double Basis=0;
final Job_controller = TextEditingController();
final wert_controller = TextEditingController();
final new_name_controller = TextEditingController();
final new_job_controller = TextEditingController();


bool show_logo = true;
bool first =true;
List <String> Jobs = ['Spielrunde abrechnen', 'Preisgelder berechnen', 'Fördergelder berechnen', 'Fahrgemeinschaften', 'Wohnkosten berechnen'];
List <String> Info =[
  'Es wird um den Wert eines Lottoscheines (z.B. eine Skat- Runde) gespielt. Jeder Spieler zahlt nach der Höhe seiner erspielten Punkte einen berechneten Anteil.',
  'Weitspringer werden je nach erzielter Weite an Preisgeldern belohnt (die größte Weite erhält den größten Anteil).',
  'Weitspringer werden nach erzielter Weite mit Fördergeldern belohnt (die geringste Weite erhält den größten Fördergeld- Anteil).',
  'Je nach den mitgefahrend Kilometern werden für jeden Mit- fahrer die anteiligen PKW-/Benzin-Kosten berechnet.',
  'In der Wohngemeinschaft wird die monatliche gesamte Kalt- miete nach Anteil der benutzten Räume) aufgeteilt.'
];

List <String> name=['Achim', 'Paul','Peter'];
//final List input_controller = [TextEditingController(), TextEditingController()];
final List<TextEditingController> input_controller = List.generate(name.length, (i) => TextEditingController());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
TextStyle headersize =  TextStyle(fontSize: 16);


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
  MyHomePage({Key? key, required this.title}) : super(key: key);



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
  int val = 1;
  int select_val=0;

  List <double> vector_multiplication(List <double> a, List <int> b){
    List <double >c=List.generate(a.length, (i) => -1);
    for (var i = 0; i < a.length; i++) {
      c[i]=a[i]*b[i];
    }
    return c;
  }
  Future<void> editdialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
            title: const Text('Jobs bearbeiten'),
            content:
            Container(
                height:MediaQuery.of(context).size.height*0.8,
                width: MediaQuery.of(context).size.width*0.8,

                child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                Container(
                height: (45.00* (Jobs.length) < MediaQuery.of(context).size.height*0.7) ? (45.00) * (Jobs.length + 1): MediaQuery.of(context).size.height*0.7 + 45.00,
                child:


                ListView.builder(
                  //shrinkWrap: true,
                  itemCount: Jobs.length,
                  itemBuilder: (BuildContext context, int index) {

                    return Container(
                      decoration: BoxDecoration(
                        //Wenn Index ==0 dann oben und unten Border, sonst nur unten
                        border: index== 0 ? Border(
                          top: BorderSide( //                   <--- left side
                            color: Colors.black87,
                            width: 1.0,
                          ),
                          bottom: BorderSide( //                    <--- top side
                            color: Colors.black87,
                            width: 1.0,
                          ),
                        ): Border(
                            bottom: BorderSide( //                   <--- left side
                              color: Colors.black87,
                              width: 1.0,
                            )),

                      ),

                      height: 45.0,
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.25,
                              //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                              child:
                              Text(Jobs[index], textAlign: TextAlign.left,),
                            ),
                            IconButton(onPressed: (){
                              setState(() {
                                Jobs.remove(Jobs[index]);
                              });


                            }, icon: Icon(Icons.remove_circle, color: Colors.redAccent,))
                            //Inout
                          ]),

                    );
                  },
                )),
                      Flexible(
                        //height: 45.0,
                        child: TextField(
                            controller: new_job_controller,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Neuen Job anlegen',

                            ),
                            textInputAction: TextInputAction.go,
                            onSubmitted: (v){
                              setState(() {
                                Jobs.add(new_job_controller.text);

                              });
                            }
                          //textInputAction: TextInputAction.go,
                        ),
                      ),

                    ])
            ),




            actions: <Widget>[
              TextButton(
                child: const Text('Beenden'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

            ],
          );
            }
    );
        }
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Teilnehmer hinzufügen'),
          content: SingleChildScrollView(

                child: TextField(
                    controller: new_name_controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Namen eingeben',
                    ),
                    //textInputAction: TextInputAction.go,
                ),

            ),

          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                setState(() {
                  name.add(new_name_controller.text);
                  inputVal.add(0);
                  input_controller.add(TextEditingController());
                  check_status.add(1);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    if (show_logo==true){
      Timer(Duration(seconds: 2), () {
        setState(() {
          show_logo = false; // after 2 seconds, hide the controls
          //first=false
        });
      });
    }


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final List<Color> gradient = [
      Colors.blue.shade800,
      Colors.blue.shade800,
      Colors.orange,
      Colors.orange,
    ];
    final double fillPercent = 75; // fills 56.23% for container from bottom
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    bool _value = false;

    //final List <String> data= ['a','b'];

    //int _value = 1;

    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: Colors.orange.withOpacity(0.05),
      appBar: show_logo ==true ? AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width*0.25,
            child: Text(
                'CYP',
                style: TextStyle(color: Colors.orange, fontSize: 52),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.2,),
            Align(
              alignment: Alignment.center,
              child:Text(
                'calc your part',
                style: TextStyle(color: Colors.blue.shade800, fontSize: 40 ),

              ),
            )

          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: gradient,
            stops: stops,)
    ),
        ),
    ) : null,
      //Appbar integriert
      /*AppBar(
        //backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueAccent.shade700,
                    Colors.blueAccent.shade200
                  ]
              ),
          ),
        ),
      ),*/
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(
              decoration: BoxDecoration(
                //Farbe Eingabeblock
                //olor: Colors.orange.shade800.withOpacity(0.4),

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            //bottomRight: Radius.circular(40),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueAccent.shade200,
                Colors.white70
              ]
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.lightBlue.shade500 ,
                //color: Colors.black12,
                blurRadius: 0.7,
                spreadRadius: 0.0,
                offset: Offset(-2.0,-1.0)
                //offset: Offset(-1,3)
            )
          ]
      ),
              child: Column(
                children: <Widget>[
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  Text('Job:',textAlign: TextAlign.right, style: TextStyle(fontSize: 30),),
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  Expanded( child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  Container(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /*SizedBox(
                      width: MediaQuery.of(context).size.width*0.2,
                      child:TextField(
                          controller: Job_controller,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Job eingeben',
                          ),
                          textInputAction: TextInputAction.go,
                          onSubmitted: (v){
                            setState(() {
                              Job= (Job_controller.text);
                            });
                          }
                      ),
                    ),*/

                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: TextField(
                        controller: Job_controller,
                        decoration: InputDecoration(
                          labelText: 'Job auwählen',
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: (String value) {
                              setState(() {
                                Job_controller.text = value;
                                Job=value;
                                //print(Info[Jobs.indexOf(Job)]);
                              });

                            },
                            itemBuilder: (BuildContext context) {
                              return Jobs
                                  .map<PopupMenuItem<String>>((String value) {
                                return new PopupMenuItem(
                                    child: new Text(value), value: value);
                              }).toList();
                            },
                          ),
                        ),
                      )
                    ),
                    IconButton(
                        onPressed: (){
                          editdialog();
                        },
                        icon: Icon(Icons.edit)
                    )
                ])),
                Container(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //Text('Basis'),
                  //SizedBox(width: 5,),
                  Flexible(
                      //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                      child:TextField(

                     controller: wert_controller,
                      decoration: InputDecoration(
                        //border: UnderlineInputBorder(),
                        labelText: 'Basis',
                      ),
                        keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(8)
                          ],
                          textInputAction: TextInputAction.go,
                          onSubmitted: (v){
                            setState(() {
                              Basis = double.parse(wert_controller.text);
                              select_val=1;
                            });
                          }
                  )),
                  Flexible(

                    child:RadioListTile(
                      value: 0,
                      groupValue: select_val,
                      onChanged: (value) {
                        setState(() {
                          select_val = value as int;


                        });
                      },
                      title: Text(wert[0]),
                    )
                  ),
                  Flexible(

                      child:RadioListTile(
                        value: 0,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value as int;
                          });
                        },
                        title: Text("Min"),
                      )
                  ),
                  Flexible(

                      child:RadioListTile(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value as int;
                          });
                        },
                        title: Text("Max"),
                      )
                  ),
                  ]
                ),
                ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.02,
                      ),

                    ]))

                ],
              ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text('''
                            Basis oder Wert + Min = niedrigster Input = niedrigster Anteil
                            Basis oder Wert + Max = höchster Input = höchster Anteil
                            '''
                            , textAlign: TextAlign.start, maxLines: 2
                        ),


                      ],
                    )
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),


            ]
              )
        ),
          //SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            Align(

                alignment: Alignment.centerRight,
              //bottom: 0,
                child:Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,

                    //width: MediaQuery.of(context).size.width*0.9,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          //bottomRight: Radius.circular(40),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.topLeft,
                            colors: [
                              Colors.orange.shade800,
                              Colors.orange.shade200,
                            ]
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12 ,
                              spreadRadius: 0.0,
                              blurRadius: 2,
                              offset: Offset(0.0,3)
                          )
                        ]
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.1,
                          //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                          child:
                          Text('Info:', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.7,
                          //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                          child:
                          Job == '' ? Text(  ''): Text(Info[Jobs.indexOf(Job)], style: TextStyle( fontSize: 16),)

                        ),

                      ],

                    )
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30.00+60.00*name.length < MediaQuery.of(context).size.height*0.4 ?30.00+60.00*name.length +15 :MediaQuery.of(context).size.height*0.4+ 15,
                    child: ListView.builder(
                      itemCount: name == null ? 1 : name.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          // return the header
                          return new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.45,

                                height: 30,

                                  //height: 45.0,



                                ),
                                //padding: const EdgeInsets.only(left:5.0, right: 5.0),


                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.3,
                                height: 30,
                                //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                                child:
                                Text('Input', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.15,
                                height: 30,
                                //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                                child:
                                Text('Anteil', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width*0.1,
                                  height: 30,
                                  //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                                  child:
                                  Text('%', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),



                            ],

                          );
                        }
                        index -= 1;


                        // return row
                        //var row = data[index];




                        return Container(
                            decoration: BoxDecoration(
                              //Wenn Index ==0 dann oben und unten Border, sonst nur unten
                              border: index== 0 ? Border(
                                top: BorderSide( //                   <--- left side
                                  color: Colors.black87,
                                  width: 1.0,
                                ),
                                bottom: BorderSide( //                    <--- top side
                                  color: Colors.black87,
                                  width: 1.0,
                                ),
                              ): Border(
                                  bottom: BorderSide( //                   <--- left side
                                    color: Colors.black87,
                                    width: 1.0,
                                  )),
                              color: check_status[index]==0 ? Colors.black12: Colors.white60,
                            ),

                            height: 60.0,
                            child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  //Bild

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.1,
                                    //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                                    child:
                                    Checkbox(
                                        value: check_status[index] == 0 ? false : true ,
                                        onChanged: (v) {
                                          setState(() {
                                            if (check_status[index] == 1) {
                                              check_status[index] = 0;
                                              sum=sum-inputVal[index];
                                            } else {
                                              check_status[index] = 1;
                                              sum=sum+inputVal[index];
                                            }
                                          }
                                          );
                                        }
                                    ),
                                  ),
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                                      child:
                                      Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2.0,
                                                color: Colors.black,
                                              )
                                          ),
                                          child:
                                          Text('?',style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800), textAlign: TextAlign.center,
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.25,
                                    //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                                    child:
                                    Text(name[index], textAlign: TextAlign.center,),
                                  ),
                                  //Inout
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.1,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width*0.1,
                                      height: 20.0,
                                      //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                                      child:TextField(
                                        //maxLength: 5,
                                          textInputAction: TextInputAction.go,
                                          controller: input_controller[index],
                                          decoration: InputDecoration(
                                            //border: UnderlineInputBorder(),
                                            labelText: '',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(5)
                                          ],
                                          onSubmitted: (v){
                                            setState(() {
                                              inputVal[index]= double.parse(input_controller[index].text);
                                              sum= inputVal.reduce((a, b) => a + b);
                                              print(inputVal[index].toString());


                                            });
                                          }
                                        // Only numbers can be entered
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.1,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.15,
                                    child: sum!=0 ? Ziel[val]=='höchster' ?
                                    Text(((inputVal[index]*Basis/sum)*check_status[index]).toStringAsFixed(2), textAlign: TextAlign.center):
                                    Text(((Basis-inputVal[index]*Basis/sum)*check_status[index]).toStringAsFixed(2), textAlign: TextAlign.center) : Text(' '),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.1,
                                    child: sum!=0 ? Ziel[val]=='höchster' ?
                                    Text(((inputVal[index]*100/sum)*check_status[index]).toStringAsFixed(2)+'%', textAlign: TextAlign.center) :
                                    Text(((100-(inputVal[index]*100/sum))*check_status[index]).toStringAsFixed(2)+'%', textAlign: TextAlign.center) : Text(' '),
                                  )



                                ]
                            ));//Text('Inhalt');//new InkWell(... with row ...);

                      },
                    ),
                  ),
               Align(
                 alignment: Alignment.centerLeft,

                 child: IconButton(
                   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                   right: MediaQuery.of(context).size.width*0.05),
                   onPressed: (){
                     _showMyDialog();
                   },
                   icon: Icon(Icons.add, size: 40),

                 ),
               )


                ],
              ),
            ),




    Spacer(),
    Align(
    alignment: Alignment.centerLeft,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[

            SizedBox(
                height: 45,//MediaQuery.of(context).size.height*0.05,
                child:Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        //bottomRight: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.orange.shade800,
                            Colors.orange.shade200,
                          ]
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12 ,
                            spreadRadius: 0.0,
                            blurRadius: 2,
                            offset: Offset(0.0,3)
                        )
                      ]


                  ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.35,
                          //padding: const EdgeInsets.only(left:5.0, right: 5.0),

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.3,
                          //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                          child:
                           Ziel[val] =='niedrigster' ? Text(inputVal.reduce(min).toString(), textAlign: TextAlign.center) : Text(inputVal.reduce(max).toString(), textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.15,
                          //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                          child:
                          Ziel[val] =='niedrigster' ? (sum)!= 0 ? Text((inputVal.reduce(min)*Basis/sum).toStringAsFixed(2), textAlign: TextAlign.center):Text('') : (sum)!= 0 ? Text((inputVal.reduce(max)*Basis/sum).toStringAsFixed(2), textAlign: TextAlign.center):Text(''),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width*0.1,
                            //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                            child:
                            Text('Summe %', textAlign: TextAlign.center)
                        ),



                      ],

                    )

                )
            ),
            //SizedBox(height: MediaQuery.of(context).size.height*0.01,),

            /*SizedBox(
              height: 40,//MediaQuery.of(context).size.height*0.04,
                child:Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.15,
                          //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                          child:
                          Text('Info:', textAlign: TextAlign.center),

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.75,
                          //padding: const EdgeInsets.only(left:5.0, right: 5.0),
                          child:
                          Text(Ziel[val] +' '+ wert[select_val]+ ' von ' + Job , textAlign: TextAlign.center),
                        ),

                      ],

                    )
                )
            )*/
                ]),
            ),
    SizedBox(
    height: 40,
    )
          ]
  ),
          ),


    );
  }
}
