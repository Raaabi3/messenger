import 'package:flutter/material.dart';
import '../Controller/ChatController.dart';
import '../Models/RuleModel.dart';

class RuleFormDialog extends StatefulWidget {
  final ChatController chatController;
  final RuleModel rule;
  final VoidCallback onRuleUpdated;

  const RuleFormDialog({
    super.key,
    required this.chatController,
    required this.rule,
    required this.onRuleUpdated,
  });

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
  late bool _enableDelay;
  late bool _enableSpecificTime; // New checkbox for specific time
  DateTime? _selectedDateTime; // Store the selected date and time

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule.name);
    _conditionValueController =
        TextEditingController(text: widget.rule.conditionValue);
    _replyMessageController =
        TextEditingController(text: widget.rule.replyMessage);
    _selectedCondition = widget.rule.conditionType;
    _selectedAction = widget.rule.actionType;
    _enableDelay = widget.rule.enableDelay;
    _enableSpecificTime = widget.rule.delayDuration != null; // Initialize
    _selectedDateTime = widget.rule.delayDuration != null
        ? DateTime.now().add(widget.rule.delayDuration!)
        : null; // Initialize
  }

  @override
  void dispose() {
    _nameController.dispose();
    _conditionValueController.dispose();
    _replyMessageController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date == null) return; // User canceled date picker

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return; // User canceled time picker

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
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
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a rule name'
                    : null,
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
              if (_selectedCondition == 'Contains' ||
                  _selectedCondition == 'Does Not Contain')
                TextFormField(
                  controller: _conditionValueController,
                  decoration: const InputDecoration(
                    labelText: 'Text to Check',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a value'
                      : null,
                ),
              if (_selectedCondition == 'Budget')
                TextFormField(
                  controller: _conditionValueController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Budget',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a budget'
                      : null,
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
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a reply message'
                      : null,
                ),
              if (_selectedAction == 'Send Reply') ...[
                Row(
                  children: [
                    Checkbox(
                      value: _enableDelay,
                      onChanged: (value) {
                        setState(() {
                          _enableDelay = value!;
                        });
                      },
                    ),
                    const Text('Enable Delayed Response'),
                  ],
                ),
                if (_enableDelay) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _enableSpecificTime,
                        onChanged: (value) {
                          setState(() {
                            _enableSpecificTime = value!;
                          });
                        },
                      ),
                      const Text('Enable Specific Time'),
                    ],
                  ),
                  if (_enableSpecificTime) ...[
                    const SizedBox(height: 10),
                    ListTile(
                      title: const Text('Select Date and Time'),
                      subtitle: Text(
                        _selectedDateTime != null
                            ? '${_selectedDateTime!.toLocal()}'
                            : 'Not set',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.timer),
                        onPressed: () => _pickDateTime(context),
                      ),
                    ),
                  ],
                ],
              ],
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
                        enableDelay: _enableDelay,
                        delayDuration: _enableSpecificTime && _selectedDateTime != null
                            ? _selectedDateTime!.difference(DateTime.now())
                            : null,
                      ));
                      widget.onRuleUpdated(); // Notify parent to rebuild
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