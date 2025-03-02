import 'package:flutter/material.dart';
import '../Controller/ChatController.dart';
import '../Models/RuleModel.dart';

class RuleFormDialog extends StatefulWidget {
  final ChatController chatController;
  final RuleModel rule;

  const RuleFormDialog({super.key, required this.chatController, required this.rule});

  @override
  _RuleFormDialogState createState() => _RuleFormDialogState();
}

class _RuleFormDialogState extends State<RuleFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _conditionValueController;
  late TextEditingController _replyMessageController;
  late String _selectedCondition;
  late String _selectedAction;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule.name);
    _conditionValueController = TextEditingController(text: widget.rule.conditionValue);
    _replyMessageController = TextEditingController(text: widget.rule.replyMessage);
    _selectedCondition = widget.rule.conditionType;
    _selectedAction = widget.rule.actionType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _conditionValueController.dispose();
    _replyMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add/Edit Rule'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Rule Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Rule Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a rule name' : null,
              ),
              const SizedBox(height: 10),

              // Condition Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCondition,
                items: widget.chatController.conditions.map((condition) {
                  return DropdownMenuItem(
                    value: condition,
                    child: Text(condition),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCondition = value!;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),

              // Condition Value Field (Dynamic)
              if (_selectedCondition == 'Contains' || _selectedCondition == 'Does Not Contain')
                TextFormField(
                  controller: _conditionValueController,
                  decoration: const InputDecoration(
                    labelText: 'Text to Check',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a value' : null,
                ),
              if (_selectedCondition == 'Budget')
                TextFormField(
                  controller: _conditionValueController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Budget',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a budget' : null,
                ),
              if (_selectedCondition == 'Time')
                ElevatedButton(
                  onPressed: () {
                    // Show time picker
                  },
                  child: const Text('Pick Date & Time'),
                ),
              const SizedBox(height: 10),

              // Action Dropdown
              DropdownButtonFormField<String>(
                value: _selectedAction,
                items: widget.chatController.actions.map((action) {
                  return DropdownMenuItem(
                    value: action,
                    child: Text(action),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAction = value!;
                  });
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),

              // Action Fields
              if (_selectedAction == 'Send Reply')
                TextFormField(
                  controller: _replyMessageController,
                  decoration: const InputDecoration(
                    labelText: 'Reply Message',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a reply message' : null,
                ),
              if (_selectedAction == 'Forward to Email')
                TextFormField(
                  controller: _replyMessageController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter an email address' : null,
                ),
              const SizedBox(height: 20),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.chatController.updateRule(RuleModel(
                        id: widget.rule.id,
                        name: _nameController.text,
                        conditionType: _selectedCondition,
                        conditionValue: _conditionValueController.text,
                        actionType: _selectedAction,
                        replyMessage: _replyMessageController.text,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Rule'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}