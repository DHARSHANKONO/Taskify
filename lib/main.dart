import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/typo_box.dart';
import 'package:todolist/themes/lightmode.dart';
import 'package:todolist/themes/darkmode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _tasks = [];
  final List<String> _desc = [];
  final List<Color> _done = [];

  void _showTypoBox() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => TypoBox(
        onTaskAdded: (newTask, desc) {
          setState(() {
            _tasks.add(newTask);
            _desc.add(desc);
            _done.add(const Color.fromARGB(255, 255, 99, 99));
          });
        },
        context: context, // Pass the context
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            onPressed: _showTypoBox,
            icon: const Icon(Icons.add_task_outlined),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final key = ValueKey(_tasks[index]);
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Slidable(
                key: key,
                startActionPane:
                    ActionPane(motion: const DrawerMotion(), children: [
                  SlidableAction(
                    flex: 1,
                    onPressed: ((context) {
                      setState(() {
                        //Not Completed:
                        _done[index] = const Color.fromARGB(255, 255, 99, 99);
                      });
                    }),
                    icon: Icons.close,
                    backgroundColor: const Color.fromARGB(255, 255, 99, 99),
                  ),
                  SlidableAction(
                    flex: 1,
                    onPressed: ((context) {
                      setState(() {
                        // completed:
                        _done[index] = const Color.fromARGB(255, 172, 255, 175);
                      });
                    }),
                    icon: Icons.check,
                    
                    backgroundColor: const Color.fromARGB(255, 172, 255, 175),
                  )
                ]),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  dismissible: DismissiblePane(
                    
                    onDismissed: () {
                    setState(() {
                      _desc.removeAt(index);
                      _tasks.removeAt(index);
                      _done.removeAt(index);
                    });
                  }),
                  children: [SlidableAction(
                      onPressed: (context) {},
                      icon: Icons.delete,
                      backgroundColor: const Color.fromARGB(255, 255, 99, 99),
                    ),],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric( horizontal:8),
                  leading: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _done[index],
                        borderRadius: BorderRadius.circular(10)),
                    height: 10,
                    width: 10,
                  ),
                  subtitle: Text(
                    _desc[index],
                    style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    
                    ),
                  ),
                  title: Text(
                    _tasks[index],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
