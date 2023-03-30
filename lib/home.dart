import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Model/todo_model.dart';
import 'package:todo/Provider/todo_provider.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Todo List"),
            content: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: "Write Todo Item"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }

                    context.read<TodoProvider>().addTodoList(ToDoModel(
                        title: _textController.text, isCompleted: false));
                    _textController.clear();

                    Navigator.pop(context);
                  },
                  child: const Text("Submit"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Color(0xff622CA7),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                )),
            child: const Center(
                child: Text(
              "To do List",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            )),
          )),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: provider.allTodoList.length,
              itemBuilder: (context, itemIndex) {
                return ListTile(
                  onTap: () {
                    provider.todoStatusChanged(provider.allTodoList[itemIndex]);
                  },
                  leading: MSHCheckbox(
                    size: 30,
                    value: provider.allTodoList[itemIndex].isCompleted,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Colors.blue),
                    style: MSHCheckboxStyle.stroke,
                    onChanged: (selected) {
                      provider
                          .todoStatusChanged(provider.allTodoList[itemIndex]);
                    },
                  ),
                  title: Text(
                    provider.allTodoList[itemIndex].title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration:
                            provider.allTodoList[itemIndex].isCompleted == true
                                ? TextDecoration.lineThrough
                                : null),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        provider
                            .removetodoList(provider.allTodoList[itemIndex]);
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff622CA7),
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
