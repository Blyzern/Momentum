import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard functionality

import 'package:momentum/methods/initialize_app_folder.dart';

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController _controller = TextEditingController();
  int? _isCopiedIndex;
  @override
  void initState() {
    super.initState();
    // this is to avoid perma reloading or calling the function inside the builder so we make the instance of the callFunction
    _setToDo();
  }

  Future _setToDo() async {
    tasks = await readToDo();
    setState(() {});
  }

  // Method to add a task to the list
  void _addTask(
    TextEditingController textController,
  ) {
    setState(() {
      tasks.add({'task': textController.text, 'completed': false});
      writeToDo(tasks);
      textController.text = "";
    });
  }

  // Method to toggle the completion of a task
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
      writeToDo(tasks);
    });
  }

  // Method to delete a task
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);

      writeToDo(tasks);
    });
  }

  // Method to edit a task
  void _editTask(int index, String newTask) {
    setState(() {
      tasks[index]['task'] = newTask;
      writeToDo(tasks);
    });
  }

  void _copyToClipboard(String taskText) {
    Clipboard.setData(ClipboardData(text: taskText)).then((_) {
      double screenWidth = MediaQuery.of(context).size.width;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_done, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text('Copied to clipboard!',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  textAlign: TextAlign.center),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior
              .floating, // Makes it float instead of being attached to the bottom
          margin: EdgeInsets.only(
              bottom: 80,
              left: screenWidth / 3,
              right: screenWidth / 3), // Adjust position
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]['task']),
                  leading: Checkbox(
                    value: tasks[index]['completed'],
                    activeColor: Theme.of(context).colorScheme.inversePrimary,
                    onChanged: (value) {
                      _toggleTaskCompletion(index);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _controller.text = tasks[index]['task'];
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Edit Task'),
                                content: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                      hintText: 'Enter new task'),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _editTask(index, _controller.text);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      // Delete Button
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _controller.text = tasks[index]['task'];
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Do you want to delete?'),
                                content: Text(_controller.text),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _deleteTask(index);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      // Copy Button

                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          _copyToClipboard(tasks[index]['task']);
                        }, // Remove onPressed since GestureDetector handles it
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.text = "";
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add New Task'),
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Enter task'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _addTask(_controller);
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
