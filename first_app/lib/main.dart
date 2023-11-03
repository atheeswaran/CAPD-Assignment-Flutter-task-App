// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class FileVersionInfo {
  late int wCodePage; // Change 'int?' to 'int'
  // Rest of your class implementation
}

class Task {
  final String title;
  final String description;
  final String objectId;

  Task(
      {required this.title, required this.description, required this.objectId});

  // factory Task.fromJson(Map<String, dynamic> json) {
  //   return Task(
  //     title: json['title'] ?? '',
  //     description: json['description'] ?? '',
  //   );
  // }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    'HEPzTjyY0rD1LSjhRbQI3pOMk95ChxDv3eltA466',
    'https://parseapi.back4app.com/',
    clientKey: 'jUzoINBS0ljBgoOeOycLdkfdiqCfivbNMJ5oOfpK',
    autoSendSessionId: true,
    debug: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Task App with Back4App Integration',
      home: Directionality(
        textDirection: TextDirection
            .ltr, // or TextDirection.rtl for right-to-left languages
        child:
            TaskListScreen(), // Replace YourHomePage with your actual home page widget.
      ),
    );
  }
}

class TaskService {
  Future<void> createTask(Task task) async {
    var taskObject = ParseObject('Task')
      ..set('title', task.title)
      ..set('description', task.description);

    var response = await taskObject.save();
    if (response.success) {
      // ignore: avoid_print
      print('Task created successfully!');
    } else {
      // ignore: avoid_print
      print('Error creating task: ${response.error!.message}');
    }
  }

  Future<List<Task>> fetchTasks() async {
    QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(ParseObject('Task'));

    var response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results!.map((taskObject) {
        return Task(
          title: taskObject.get<String>('title') ?? '',
          description: taskObject.get<String>('description') ?? '',
          objectId: taskObject.get<String>('objectId') ?? '',
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch tasks: ${response.error!.message}');
    }
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskService _taskService = TaskService();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Task task = Task(
  //     title: 'Sample Task', description: 'This is a sample task description');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _taskService.fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Task> tasks = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 255, 0, 43),
              title: const Text('Tasks List from back4App'),
            ),
            body: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TaskDetailsScreen(task: tasks[index]),
                      ),
                    ).then((_) {
                      // Refresh the task list when coming back from task details screen
                      setState(() {
                        // Perform setState to trigger rebuild and refresh the task list
                      });
                    });
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskCreationScreen()),
                ).then((_) {
                  // Refresh the task list when coming back from task creation screen
                  setState(() {
                    // Perform setState to trigger rebuild and refresh the task list
                  });
                });
              },
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const Center(child: Text('No tasks available.'));
        }
      },
    );
  }
}

class TaskCreationScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TaskCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _createTask(context);
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _createTask(BuildContext context) async {
    var task = ParseObject('Task')
      ..set<String>('title', _titleController.text)
      ..set<String>('description', _descriptionController.text);

    var response = await task.save();
    if (response.success) {
      Navigator.pop(
          context); // Pop the screen to navigate back to the task list
    } else {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to create task. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _editTask(context, task);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteTask(context, task.objectId);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Title: ${task.title}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${task.description}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void _editTask(BuildContext context, Task task) async {
    var updatedTitle = task.title; // Initial value for the updated title
    var updatedDescription =
        task.description; // Initial value for the updated description

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  updatedTitle = value;
                },
                controller: TextEditingController(text: task.title),
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  updatedDescription = value;
                },
                controller: TextEditingController(text: task.description),
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var updatedTask = ParseObject('Task')
                  //..objectId = task.objectId
                  ..set<String>('title', updatedTitle)
                  ..set<String>('description', updatedDescription);

                var response = await updatedTask.save();
                if (response.success) {
                  Navigator.of(context).pop(); // Pop the edit task dialog
                  Navigator.of(context).pop(); // Pop the task details screen
                } else {
                  // Handle error
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Failed to update task. Please try again later.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // ignore: unused_element
  void _deleteTask(BuildContext context, String objectId) async {
    var task = ParseObject('Task')..objectId = objectId;

    var response = await task.delete();
    if (response.success) {
      Navigator.of(context).pop(); // Pop the task details screen
    } else {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to delete task. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
