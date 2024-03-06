class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });


   static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'acordar', isDone: true),
      ToDo(id: '02', todoText: 'escovar os dentes', isDone: true),
      ToDo(id: '03', todoText: 'ligar computador',),
      ToDo(id: '04', todoText: 'checar emails',),
      ToDo(id: '05', todoText: 'trabalhar',),
      ToDo(id: '06', todoText: 'ligacao do time',),
    ];
   }
  
}