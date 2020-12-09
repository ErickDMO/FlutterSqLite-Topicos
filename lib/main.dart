import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _task = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterBuilder(
        futere: db.initDB(),
        builder: (BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return _showList(context);
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }





  _showList(BuildContext context){
    return FlutterBuilder(
      futere: db.getAllTasks();
      builder: (){
        if(snapshot.hasData){
          return ListView(
            children: <Widget>[
              for(Task task in snapshot.data) ListTitle(title: Text(task.name)), ListTitle(title: Text(task.direction)), ListTitle(title: Text(task.phone))
            ],
          );
        }else{
          return Center(
            child: Text("Adicionar Persona"),
          );
        }
      }
    );
  }

  _addTask(){
    showDialog(
      context: context,
      build: (context){
        return SimpleDialog(
          children: <Widget>[
            TextField(
              decoration:InputDecoration(icon: Icon(Icons.add_circle_outline)),
              onSubmitted: (text){
                setState((){
                  var task = Task(text, Direccion, +591);
                  db.insert(task);
                  Navigator.pop(context);
                });
              },
            );
          ],
        );
      },
    );
  }





}
