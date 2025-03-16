import 'package:flutter/material.dart';

class TypoBox extends StatefulWidget {
  final void Function(String,String) onTaskAdded;
  final BuildContext context; // Define a named parameter 'context'

  const TypoBox({super.key, required this.onTaskAdded, required this.context});

  @override
  State<TypoBox> createState() => _TypoBoxState();
}

class _TypoBoxState extends State<TypoBox> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  void _updateTaskList() {
    if (_controller.text.isNotEmpty) {
      
      widget.onTaskAdded(_controller.text,_controller2.text.isEmpty? 'No Description' : _controller2.text);
      _controller.clear();
      Navigator.pop(widget.context); // Use widget.context
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
         
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Task',border: OutlineInputBorder(borderSide: const BorderSide(width: 1),borderRadius: BorderRadius.circular(15)),
              prefixIcon: const Icon(Icons.edit)
              ),
                    
            ),
            const SizedBox(height: 8),
            TextFormField(
              
              controller: _controller2,
              decoration: InputDecoration(labelStyle: const TextStyle(fontStyle: FontStyle.italic,fontSize: 10) ,labelText: 'Description',border: OutlineInputBorder(borderSide: const BorderSide(width: 1),borderRadius: BorderRadius.circular(15)),
              prefixIcon: const Icon(Icons.description)
              ),
                    
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(widget.context),
                  child: const Icon(Icons.close),
                ),
                ElevatedButton(
                  onPressed: _updateTaskList,
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}