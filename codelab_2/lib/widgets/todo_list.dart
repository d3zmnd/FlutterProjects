import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> items = [];
  TextEditingController _textFieldController = TextEditingController();

_addNewItem(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Write new action todo'),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: 'Todo action'),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Add'),
            onPressed: () {
              setState(() {
                if (_textFieldController.text.length > 0) {
                  items.add(_textFieldController.text);
                  _textFieldController.clear();
                }
              });
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}

_removeTodoItem(int index) {
  setState(() => items.removeAt(index));
}

_promptRemoveTodoItem(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to delete "${items[index]}" task?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop()
          ),
          FlatButton(
            child: Text('Delete'),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            }
          ),
        ]
      );
    }
  );
}  

Widget _buildTodoList() {
  final ordinal = List<String>.generate(40, (i) => "${i + 1}");
  return Container(       
    padding: const EdgeInsets.all(3), 
    child: ListView.builder(     
      itemCount: items.length,
      itemBuilder: (BuildContext ctxt, int index) {
        final item = items[index];
        return Dismissible(
          child: Card(        
            color: Colors.orange.shade400,
            child:  ListTile(
              title: Text(items[index]),
              onLongPress: ()=> _promptRemoveTodoItem(index), 
              // onTap: ()=> _promptEditTodoItem(index),            
              trailing: new IconButton(
                icon: new Icon(Icons.delete, color: Colors.black87, size: 36.0,), 
                onPressed: ()=> _promptRemoveTodoItem(index)
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.lightBlue.shade100,
                child: Text('${ordinal[index]}'),
                foregroundColor: Colors.black87,
                radius: 16,
              ),
            ),
          ),
          direction: DismissDirection.horizontal,
                key: Key(item),
                onDismissed: (direction) => _removeTodoItem(index),
          );
          
      }
    ),
     
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List')
      ),
      
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_addNewItem(context),
        tooltip: 'Add task',
        child: Icon(Icons.add)
      ),
    );
  }
}


