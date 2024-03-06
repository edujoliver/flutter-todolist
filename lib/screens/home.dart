


import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/widgets/todo_item.dart';
import 'package:todoapp/model/todo.dart';

class Home extends StatefulWidget {
 Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  void initstate() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:50,
                        bottom: 20,
                        ),
                        child: Text(
                          'Lista de Tarefas',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      for ( ToDo todo in _foundToDo.reversed)
                      TodoItem(
                      todo: todo,
                      onToDoChanged: _handletodochange,
                      onDeleteItem: _deleteToDoItem,
                      ),
                    
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child: Container(margin: EdgeInsets.only(
               bottom:20,
               right:20,
               left:20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),],
                borderRadius: BorderRadius.circular(15)
              ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Adicionar Nova Tarefa',
                  border: InputBorder.none,
                ),
              ),
              ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                   style: TextStyle(
                    fontSize: 40,
                    ),
                    ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                )
              )
            ],),
          )
        ],
      ),
    );
  }
 void _handletodochange(ToDo todo) {
  setState(() {
    
  });
  todo.isDone = !todo.isDone;
 }

 void _deleteToDoItem(String id) {
  setState(() {
    todosList.removeWhere((item) => item.id == id);
  });
}
void _addToDoItem(String toDo) {
  if (toDo.trim().isNotEmpty) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }
}

void _runFilter(String enteredKeyword) {
  List<ToDo> results = [];
  if ( enteredKeyword.isEmpty ) {
    results = todosList;
  } else {
    results = todosList
    .where((item) => item.todoText!
    .toLowerCase()
    .contains(enteredKeyword.toLowerCase()))
    .toList();
  }
  setState(() {
    _foundToDo = results;
  });
}




  //BARRA DE BUSCA
  Widget searchBox() {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: tdBlack,
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(maxHeight: 20,
                  minWidth: 25,
                  ),
                  border: InputBorder.none,
                  hintText: 'Buscar',
                  hintStyle: TextStyle(color: tdGrey),
                ),
              ),
            );
  }

  AppBar _buildAppBar() {
    return AppBar(backgroundColor: tdBGColor,
    title: Row(children: [
      Icon(Icons.menu,
      color: tdBlack,
      size: 30,
      )
    ],),);
  }
}