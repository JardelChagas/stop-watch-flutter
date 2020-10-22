import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
  home: Clock(),
));

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  TextEditingController weightController = TextEditingController();
  Timer timer;
  DateTime now;
  String formattedTime;
  String cro = "00";
  String textoBotao = "Iniciar";
  int seg = 0 ;
  int min = 0 ;
  int hora = 0;
  String s;
  String m;
  String h;
  bool pause = true;
  String timeC ="00";

@override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
        formattedTime = DateFormat('HH:mm:ss').format(now);

      });
    });
  }

  void time()async{
    Timer segundo = await Timer.periodic(Duration(seconds: 1), (segundo) {
      if(timeC=='0' || timeC == "Tempo completo!"){
        timeC = "Tempo completo!";
        segundo.cancel();
        return;
      }
      timeC = (int.parse(timeC) - 1).toString();
    });

    if(timeC == '0')
      timeC = "Tempo completo!";

  setState(() {
    timeC = weightController.text;

  });

  }

  Future<void> stopWarchF() async {
    Timer segundo = await Timer.periodic(Duration(seconds: 1), (segundo) {
        if(pause) {
          segundo.cancel();
          return;
        }
        if (seg < 59) {
          seg += 1;
          if (seg < 10)
            s = "0" + seg.toString();
          else
            s = seg.toString();
        } else if (min < 59) {
          seg = 0;
          min += 1;
          if (min < 10)
            m = "0" + min.toString();
          else
            m = min.toString();
          s = "00";
        } else {
          seg = 0;
          min = 0;
          hora += 1;
          if (hora < 10)
            h = "0" + hora.toString();
          else
            h = hora.toString();
          m = "00";
          s = "00";
        }

        if (min == 0 && hora == 0) {
          cro = s;
        } else if (hora == 0) {
          cro = m + ":" + s;
        } else {
          cro = h + ":" + m + ":" + s;
        }
      });

  }


  @override
  Widget build(BuildContext context) {
    now = DateTime.now();
    formattedTime = DateFormat('HH:mm:ss').format(now);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.access_time_outlined), text: "Relógio",),
                Tab(icon: Icon(Icons.hourglass_empty_outlined), text: "Time",),
                Tab(icon: Icon(Icons.access_alarm),text: "Cronomêtro",),
              ],
            ),
            title: Text('App Relogio',textAlign: TextAlign.center,),
          ),
          body: TabBarView(

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(formattedTime, textAlign: TextAlign.center, style: TextStyle(fontSize: 75.0,),),
                ],
              ),

              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(timeC, style: TextStyle(fontSize: 75.0,)),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0,bottom: 60.0),
                      child:
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "TIME",
                            labelStyle: TextStyle(color: Colors.blue)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 25.0),
                        controller: weightController,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira seu peso";
                          }
                        },
                      ),
                    ),
                    RaisedButton(
                        onPressed: time,
                        child: Text(
                          "Iniciar",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blue
                    ),

                  ],
                ),
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cro, style: TextStyle(fontSize: 75.0,)),
                  Row(
                      children:[
                        Padding(
                          padding: EdgeInsets.only(top: 100.0,left: 90.0, bottom: 10.0),
                          child: Container(
                            height: 50.0,
                            child: RaisedButton(
                                onPressed: (){

                                  setState(() {
                                    pause = !pause;
                                    !pause ? textoBotao = "Pausar": textoBotao = "Iniciar";
                                  });

                                  stopWarchF();
                                },
                                child: Text(
                                  textoBotao,
                                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                                ),
                                color: Colors.blue
                            ),

                          ),

                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 100.0,left: 30.0, bottom: 10.0),
                          child: Container(
                            height: 50.0,
                            child: RaisedButton(
                                onPressed: (){
                                  setState(() {
                                    cro = "00";
                                    min = 0;
                                    seg = -1;
                                    hora = 0;
                                  });

                                },
                                child: Text(
                                  "Zerar",
                                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                                ),
                                color: Colors.greenAccent
                            ),
                          ),
                        ),]
                  ),],
              ),],
          ),
        ),
      );
  }
}

