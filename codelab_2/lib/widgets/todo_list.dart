import 'package:flutter/material.dart';
import '../colors.dart';
import '../buttons.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> items = [];
  final ordinal = List<String>.generate(40, (i) => "${i + 1}");
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
              child: Text(cancelButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(addButton),
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
  
  _editTodoItem(int index){
    setState((){
      if (_textFieldController.text.length > 0) {
        items.removeAt(index);
        items.insert(index, _textFieldController.text);
        _textFieldController.clear();
      }
    });
  }
  _promptEditTodoItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit "${ordinal[index]}" task'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: 'Todo action'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(cancelButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(saveButton),
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

  _removeTodoItem(int index) {
    setState(() => items.removeAt(index));
  }
  _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete "${ordinal[index]}" task?'),
          actions: <Widget>[
            FlatButton(
              child: Text(cancelButton),
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
          final item = items[index];
          return Dismissible(
            direction: DismissDirection.horizontal,
                  key: Key(item),
                  onDismissed: (direction) => _removeTodoItem(index),
            child: Card(        
              color: taskColor,
              child:  ListTile(
                title: Text(items[index]),
                onTap: ()=> _promptEditTodoItem(index),            
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: iconsColor, size: 36.0,), 
                  onPressed: ()=> _promptRemoveTodoItem(index)
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


