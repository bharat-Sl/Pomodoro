import 'dart:async';
import 'package:flutter/material.dart';

var BodyColor = {
  0: [Colors.red[300], Colors.red[700]],
  1: [Colors.teal[300], Colors.teal[700]],
  2: [Colors.lightBlue[300], Colors.lightBlue[700]]
};
var state = [0, 1, 2];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var a;
  var b;
  List timing = [];
  int state = 0;
  bool start = false;
  var time_list = [];
  int start_time = 0;
  String timer_text = "";
  String Message = "Your Secret For time Management";
  int short_break = 0;
  int workTime = 25;
  int shortBreakTime = 5;
  int LongBreakTime = 15;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time_list = [workTime * 60, shortBreakTime * 60, LongBreakTime * 60];
    start_time = time_list[state];
    timer_text = time_string(time_list[state]);
    print(workTime * 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: BodyColor[state])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Hero(
            tag: "Pomo",
            child: Image.asset(
              "Assets/Pomodoro.png",
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 0.5,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 2.0,
                  shadowColor: Colors.black,
                  margin: EdgeInsets.all(5.0),
                  color: BodyColor[state][0],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 10.0),
                    child: Text(
                      Message,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: Color.fromRGBO(255, 255, 255, 0.30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                              color: state == 0
                                  ? BodyColor[state][1]
                                  : Colors.transparent,
                              onPressed: () {
                                reset(0, false);
                              },
                              child: Text(
                                "Pomodoro",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )),
                          FlatButton(
                              color: state == 1
                                  ? BodyColor[state][1]
                                  : Colors.transparent,
                              onPressed: () {
                                reset(1, false);
                              },
                              child: Text(
                                "Short Break",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )),
                          FlatButton(
                              color: state == 2
                                  ? BodyColor[state][1]
                                  : Colors.transparent,
                              onPressed: () {
                                reset(2, false);
                              },
                              child: Text(
                                "Long Break",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        time_string(start_time),
                        style: TextStyle(
                          fontSize: 88,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Text(
                          "Total Time Worked:   " + time_string(add(timing)),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: RaisedButton(
                          onPressed: () {
                            toggleTimer();
                          },
                          color: Color.fromRGBO(255, 255, 255, 0.88),
                          child: Text(
                            start ? "Stop" : "Start",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Work Time : $workTime",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Slider(
                          value: workTime * 1.0,
                          onChanged: start == false
                              ? (newValue) {
                                  setState(() {
                                    workTime = newValue.toInt();
                                    time_list = [
                                      workTime * 60,
                                      shortBreakTime * 60,
                                      LongBreakTime * 60
                                    ];
                                    start_time = time_list[state];
                                  });
                                }
                              : null,
                          activeColor: BodyColor[state][1],
                          inactiveColor: BodyColor[state][0],
                          divisions: 60,
                          min: 1,
                          max: 60),
                      SizedBox(height: 5),
                      Text(
                        "Short Break Time : $shortBreakTime",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Slider(
                          value: shortBreakTime * 1.0,
                          onChanged: start == false
                              ? (newValue) {
                                  setState(() {
                                    shortBreakTime = newValue.toInt();
                                    time_list = [
                                      workTime * 60,
                                      shortBreakTime * 60,
                                      LongBreakTime * 60
                                    ];
                                    start_time = time_list[state];
                                  });
                                }
                              : null,
                          activeColor: BodyColor[state][1],
                          inactiveColor: BodyColor[state][0],
                          divisions: 30,
                          min: 1,
                          max: 30),
                      SizedBox(height: 5),
                      Text(
                        "Long Break Time :  $LongBreakTime",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Slider(
                          value: LongBreakTime * 1.0,
                          onChanged: start == false
                              ? (newValue) {
                                  setState(() {
                                    LongBreakTime = newValue.toInt();
                                    time_list = [
                                      workTime * 60,
                                      shortBreakTime * 60,
                                      LongBreakTime * 60
                                    ];
                                    start_time = time_list[state];
                                  });
                                }
                              : null,
                          activeColor: BodyColor[state][1],
                          inactiveColor: BodyColor[state][0],
                          divisions: 60,
                          min: 1,
                          max: 60),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                reset(state, true);
              },
              child: Icon(Icons.refresh),
              backgroundColor: BodyColor[state][1],
            ),
          ],
        ),
      ),
    );
  }

  void start_timer() {
    Timer(Duration(seconds: 1), keeprunning);
  }

  void keeprunning() {
    if (start == true) {
      start_time--;
      start_timer();
    }
    if (start_time < 0) {
      if (state == 0 && short_break < 4) {
        setState(() {
          Message = "Take a Short Break";
          state = 1;
          start_time = time_list[state];
        });
      } else if (state == 0 && short_break >= 4) {
        setState(() {
          Message = "Its Break Time!";
          short_break = 0;
          state = 2;
          start_time = time_list[state];
        });
      } else if (state > 0) {
        setState(() {
          Message = "Let's get to work!";
          short_break += state == 1 ? 1 : 0;
          state = 0;
          start_time = time_list[state];
        });
      }
      setState(() {
        start_time = time_list[state];
      });
    }
    setState(() {
      timer_text = time_string(start_time);
    });
  }

  void toggleTimer() {
    setState(() {
      start = !start;
    });
    if (start == true) {
      setState(() {
        Message = state == 0
            ? "Let's get to work!"
            : state == 1
                ? "Take a Short Break"
                : "Its Break Time!";
        if (state == 0) {
          a = start_time;
        }
      });
      start_timer();
    } else {
      setState(() {
        if (a != null && a > 0) {
          b = start_time;
          timing.add(a - b);
        }
        a = 0;
        b = 0;
      });
    }
  }

  String time_string(int count) {
    int hours = (count / 3600).toInt();
    count = count % 3600;
    int minute = (count / 60).toInt();
    int second = count % 60;
    String time = "";
    if (hours > 0) {
      if (hours < 10) {
        time = time + "0";
      }
      time = time + hours.toString() + ":";
    }
    if (minute < 10) {
      time = time + "0";
    }
    time = time + minute.toString() + ":";
    if (second < 10) {
      time = time + "0";
    }
    time = time + second.toString();
    return time;
  }

  void reset(int s, bool change) {
    setState(() {
      if (a != null && a > 0) {
        b = start_time;
        timing.add(a - b);
      }
      a = 0;
      b = 0;
      state = s;
      Message = "Your Secret For time Management";
      if (change == true) {
        timing.clear();
        workTime = 25;
        shortBreakTime = 5;
        LongBreakTime = 15;
        time_list = [workTime * 60, shortBreakTime * 60, LongBreakTime * 60];
      }
      start_time = time_list[state];
      start = false;
      short_break = 0;
    });
  }

  int add(List a) {
    int sum = 0;
    for (int element in a) {
      sum = sum + element;
    }
    return sum;
  }
}
