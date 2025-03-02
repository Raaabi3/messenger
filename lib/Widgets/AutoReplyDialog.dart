import 'package:flutter/material.dart';
import '../Controller/ChatController.dart';
import '../Models/RuleModel.dart';
import 'RuleFormDialog.dart';

class AutoReplyDialog extends StatelessWidget {
  final ChatController chatController;

  const AutoReplyDialog({super.key, required this.chatController});

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
              child: ListView.builder(
                itemCount: chatController.rules.length,
                itemBuilder: (context, index) {
                  final rule = chatController.rules[index];
                  return ListTile(
                    title: Text(rule.name),
                    subtitle: Text('Condition: ${rule.conditionType} - ${rule.conditionValue}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        chatController.deleteRule(rule.id);
                      },
                    ),
                    onTap: () {
                      _showRuleForm(context, rule);
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
      builder: (context) => RuleFormDialog(chatController: chatController, rule: rule),
    );
  }
}