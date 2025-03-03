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
  Duration? _selectedDelay; // Selected fixed delay (e.g., 10 seconds, 30 seconds)
  TimeOfDay? _selectedTime; // Store the selected time (hour and minute)

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
    _selectedDelay = widget.rule.delayDuration; // Initialize fixed delay
    _selectedTime = widget.rule.delayDuration != null
        ? TimeOfDay(
            hour: widget.rule.delayDuration!.inHours,
            minute: widget.rule.delayDuration!.inMinutes.remainder(60),
          )
        : null; // Initialize specific time
  }

  @override
  void dispose() {
    _nameController.dispose();
    _conditionValueController.dispose();
    _replyMessageController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
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
                          if (!_enableDelay) {
                            _enableSpecificTime = false; // Disable specific time if delay is disabled
                          }
                        });
                      },
                    ),
                    const Text('Enable Delayed Response'),
                  ],
                ),
                if (_enableDelay) ...[
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      RadioListTile<Duration>(
                        title: const Text('10 seconds'),
                        value: const Duration(seconds: 10),
                        groupValue: _selectedDelay,
                        onChanged: (value) {
                          setState(() {
                            _selectedDelay = value;
                            _enableSpecificTime = false; // Disable specific time if a fixed delay is selected
                          });
                        },
                      ),
                      RadioListTile<Duration>(
                        title: const Text('30 seconds'),
                        value: const Duration(seconds: 30),
                        groupValue: _selectedDelay,
                        onChanged: (value) {
                          setState(() {
                            _selectedDelay = value;
                            _enableSpecificTime = false; // Disable specific time if a fixed delay is selected
                          });
                        },
                      ),
                      RadioListTile<Duration>(
                        title: const Text('1 minute'),
                        value: const Duration(minutes: 1),
                        groupValue: _selectedDelay,
                        onChanged: (value) {
                          setState(() {
                            _selectedDelay = value;
                            _enableSpecificTime = false; // Disable specific time if a fixed delay is selected
                          });
                        },
                      ),
                      RadioListTile<Duration>(
                        title: const Text('5 minutes'),
                        value: const Duration(minutes: 5),
                        groupValue: _selectedDelay,
                        onChanged: (value) {
                          setState(() {
                            _selectedDelay = value;
                            _enableSpecificTime = false; // Disable specific time if a fixed delay is selected
                          });
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _enableSpecificTime,
                            onChanged: (value) {
                              setState(() {
                                _enableSpecificTime = value!;
                                if (_enableSpecificTime) {
                                  _selectedDelay = null; // Clear fixed delay if specific time is enabled
                                }
                              });
                            },
                          ),
                          const Text('Enable Specific Time'),
                        ],
                      ),
                      if (_enableSpecificTime) ...[
                        const SizedBox(height: 10),
                        ListTile(
                          title: const Text('Select Time'),
                          subtitle: Text(
                            _selectedTime != null
                                ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
                                : 'Not set',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.timer),
                            onPressed: () => _pickTime(context),
                          ),
                        ),
                      ],
                    ],
                  ),
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
                        delayDuration: _enableSpecificTime && _selectedTime != null
                            ? Duration(
                                hours: _selectedTime!.hour,
                                minutes: _selectedTime!.minute,
                              )
                            : _selectedDelay, // Use fixed delay or specific time
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