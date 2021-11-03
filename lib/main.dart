import 'package:flutter/material.dart';
import 'package:todo/item.dart';

void main() => runApp(TodoApp());

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Hello"),
          ),
          body: Column(
            children: [
              TextField(

              ),

              Expanded(
                flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: 100.0,
                    color: Colors.red,
                    child: ListView(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          color: Colors.green,
                          margin: EdgeInsets.all(10),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          color: Colors.green,
                          margin: EdgeInsets.all(10),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          color: Colors.green,
                          margin: EdgeInsets.all(10),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          color: Colors.green,
                          margin: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // bool isChecked = false;
  List<Item> taskList = [];
  final myController = TextEditingController();
  var _dark_theme = false;
  var _show_finished = false;


  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      brightness: Brightness.light,
      /* light theme settings */
      ),
      darkTheme: ThemeData(
      brightness: Brightness.dark,
      /* dark theme settings */
      ),
      themeMode: _dark_theme ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "DevCave Todo",
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 20.0, 0),
              icon: Icon(
                Icons.wb_sunny_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                setState(() {
                  _dark_theme = _dark_theme ? false : true;
                });
              },
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myController,
                maxLength: 500,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Write Task...',
                  // fillColor: Colors.grey[200],
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: (() {
                      var _input_data = myController.value.text.trim();
                      if(_input_data.isNotEmpty){
                        setState(() {
                          taskList.insert(0,new Item(_input_data, false));
                          myController.clear();
                        });
                      }
                    }),
                  ),

                ),
                onSubmitted: (value) {
                  var _input_data = myController.value.text.trim();
                  if(_input_data.isNotEmpty) {
                    setState(() {
                      taskList.insert(0,new Item(myController.value.text, false));
                      myController.clear();
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(10, 0, 13, 0),

                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        side: BorderSide(
                            color: !_show_finished ? Colors.green : Colors.black54
                        )
                      ),
                    ),
                    onPressed: () => {
                      setState(() {
                        _show_finished = _show_finished ? false : true;
                      })
                    },
                    label: Text(
                      (!_show_finished ? 'Show' : 'Hide') + ' Finished',
                      style: TextStyle(
                        fontSize: 18,
                        color: !_show_finished ? Colors.green : Colors.black54
                      ),
                    ),
                    icon: Icon(
                        Icons.check_circle,
                        color: !_show_finished ? Colors.green : Colors.black54
                    ),
                  ),

                  SizedBox(width: 10,),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(10, 0, 13, 0),
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          side: BorderSide(color: Colors.red)
                      ),
                    ),
                    onPressed: () => {
                      setState(() {
                        taskList.clear();
                      })
                    },
                    label: Text(
                      'Delete all',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red
                      ),
                    ),
                    icon: Icon(Icons.remove, color: Colors.red,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              flex: 1,
              child: ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: taskList.where((element) => _show_finished ? true :  !element.isChecked  ).toList().asMap().entries.map((item)
                  {
                    return Card(
                      shadowColor: Colors.grey[600],
                      child: ListTile(
                        leading: Checkbox(
                          shape: CircleBorder(),
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: item.value.isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              print(item.value.value);
                              item.value.isChecked = value!;
                            });
                          },
                        ),
                        subtitle: Text(

                          '${item.value.value}',
                          style: TextStyle(
                            // color: Colors.grey[700],
                              fontSize: 18.0,
                              decoration: item.value.isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none
                          ),
                        ),


                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              taskList.removeAt(item.key);
                            });
                          },
                          icon: Icon(Icons.remove_circle),
                          color: Colors.red,

                        ),
                        isThreeLine: true,
                      ),
                    );

                  }).toList()
              ),
            ),
          ],
        ),

      )
    );
  }
}

