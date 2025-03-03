import 'package:flutter/material.dart';

import '../Controller/ChatController.dart';
import '../Models/RuleModel.dart';
import 'RuleFormDialog.dart';

class AutoReplyDialog extends StatefulWidget {
  final ChatController chatController;

  const AutoReplyDialog({super.key, required this.chatController});

  @override
  _AutoReplyDialogState createState() => _AutoReplyDialogState();
}

class _AutoReplyDialogState extends State<AutoReplyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Auto-Reply Rules'),
      content: SizedBox(
        width: 400,
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // List of Rules
            Expanded(
              child: ListenableBuilder(
                listenable: widget
                    .chatController, // Listen to changes in ChatController
                builder: (context, _) {
                  return ListView.builder(
                    itemCount: widget.chatController.rules.length,
                    itemBuilder: (context, index) {
                      final rule = widget.chatController.rules[index];
                      return ListTile(
                        title: Text(rule.name),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Condition: ${rule.conditionType} - ${rule.conditionValue}'),
                              if (rule.enableDelay &&
                                  rule.delayDuration != null)
                                Text(
                                    'Delay: ${rule.delayDuration!.inHours}h ${rule.delayDuration!.inMinutes.remainder(60)}m ${rule.delayDuration!.inSeconds.remainder(60)}s'),
                            ]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            widget.chatController
                                .deleteRule(rule.id); // Delete the rule
                          },
                        ),
                        onTap: () {
                          _showRuleForm(context, rule);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _showRuleForm(
                  context,
                  RuleModel(
                    id: DateTime.now().toString(),
                    name: '',
                    conditionType: 'Contains',
                    conditionValue: '',
                    actionType: 'Send Reply',
                  ),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text('Add Rule'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRuleForm(BuildContext context, RuleModel rule) {
    showDialog(
      context: context,
      builder: (context) => RuleFormDialog(
        chatController: widget.chatController,
        rule: rule,
        onRuleUpdated: () {
          // Trigger a rebuild when the rule is updated
          setState(() {});
        },
      ),
    );
  }
}
