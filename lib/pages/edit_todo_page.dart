import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model.dart/todo.dart';
import '../providers/todos.dart';
import '../widgets/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late var time;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
    time = widget.todo.createdTime;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('View Todo'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                provider.removeTodo(widget.todo);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text("Todo Created at $time"),
            const SizedBox(height: 25),
            Center(
              child: Text('Title'),
            ),
            Center(
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                  )),
            ),
            const SizedBox(height: 30),
            Center(child: Text('Description')),
            Center(
                child: Text(
              description,
              style: const TextStyle(fontSize: 20, height: 1.5),
            )),

            // child: TodoFormWidget(
            //   title: title,
            //   description: description,
            //   onChangedTitle: (title) => setState(() => this.title = title),
            //   onChangedDescription: (description) =>
            //       setState(() => this.description = description),
            //   onSavedTodo: saveTodo,
          ]),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }
}
