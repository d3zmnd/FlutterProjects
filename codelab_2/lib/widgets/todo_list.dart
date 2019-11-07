import 'package:flutter/material.dart';
import '../buttons.dart';
import '../colors.dart';


class TodoList extends StatefulWidget {
  @override
   TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final List<String> items = <String>[];
  final List<String> ordinal = List<String>.generate(40, (int i) => '${i + 1}');
  final TextEditingController _textFieldController = TextEditingController();
  
  dynamic _addNewItem(BuildContext context){
    dynamic showDialog;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Write new action todo'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: 'Todo action'),
          ),          
          actions: <Widget>[
            FlatButton(
              child: const Text(cancelButton),
              onPressed: () {
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(addButton),
              onPressed: () {
                setState(() {
                  if (_textFieldController.text.isNotEmpty) {
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
  
  dynamic _editTodoItem(int index){
    return setState((){
      if (_textFieldController.text.isNotEmpty) {
        items.removeAt(index);
        items.insert(index, _textFieldController.text);
        _textFieldController.clear();
      }
    });
  }
  dynamic _promptEditTodoItem(int index) {
    dynamic showDialog;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit "${ordinal[index]}" task'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: 'Todo action'),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text(cancelButton),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: const Text(saveButton),
              onPressed: () {
                _editTodoItem(index);                
                Navigator.of(context).pop();
              },              
            )
          ],
        );
      }
    );
  }

  dynamic _removeTodoItem(int index) {
    setState(() => items.removeAt(index));
  }
  dynamic _promptRemoveTodoItem(int index) {
    dynamic showDialog;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete "${ordinal[index]}" task?'),
          actions: <Widget>[
            FlatButton(
              child: const Text(cancelButton),
              onPressed: () => Navigator.of(context).pop()
            ),
            FlatButton(
              child: Text(deleteButton),
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
    return Container(       
      padding: const EdgeInsets.all(3), 
      child: ListView.builder(     
        itemCount: items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final String item = items[index];
          return Dismissible(
            direction: DismissDirection.horizontal,
              key: Key(item),
              onDismissed: (DismissDirection direction) => _removeTodoItem(index),
            child: Card(        
              color: taskColor,
              child:  ListTile(
                title: Text(items[index]),
                onTap: ()=> _promptEditTodoItem(index),            
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: iconsColor, size: 36.0,), 
                  onPressed: ()=> _promptRemoveTodoItem(index),
                ),
                leading: CircleAvatar(
                  backgroundColor: ordinalBgColor,
                  child: Text('${ordinal[index]}'),
                  foregroundColor: iconsColor,
                  radius: 16,
                ),
              ),
            ),            
          ); 
        }
      ), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List')
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
