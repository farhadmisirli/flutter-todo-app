import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoApp()
));

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  bool isChecked = false;
  List taskList = [];
  final myController = TextEditingController();

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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "DevCave Todo",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
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
                fillColor: Colors.grey[200],
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (() {
                    setState(() {
                      taskList.add(myController.value.text);
                      myController.clear();
                    });
                  }),
                ),

              ),
              onSubmitted: (value) {
                setState(() {
                  taskList.add(value);
                  myController.clear();
                });
              },
            ),
          ),
          SizedBox(height: 10.0),
          ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: taskList.asMap().entries.map((item) => Card(
                shadowColor: Colors.grey[600],
                child: ListTile(
                  leading: Checkbox(
                    shape: CircleBorder(),
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  subtitle: Text(
                    '${item.value}',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18.0
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
              )).toList()
          ),
        ],
      ),

    );
  }
}

