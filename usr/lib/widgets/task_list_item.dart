import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      task.type == TaskType.checklist
                          ? Icons.checklist
                          : Icons.assignment_outlined,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.type == TaskType.checklist ? 'Checklist' : 'Task',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.more_vert, color: Colors.grey[400]),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Text(
                    task.location,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Tags Row
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildStatusChip(task.status),
                      _buildPriorityChip(task.priority),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Dates Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDateInfo('Due:', task.dueDate, isDue: true),
                    _buildDateInfo('Assigned:', task.assignedDate),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Assignee
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue[100],
                      child: Text(
                        task.assigneeName.substring(0, 1),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      task.assigneeName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Actions
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildStatusChip(TaskStatus status) {
    Color color;
    String label;
    Color textColor;

    switch (status) {
      case TaskStatus.inProgress:
        color = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange[800]!;
        label = 'In Progress';
        break;
      case TaskStatus.completed:
        color = Colors.green.withOpacity(0.1);
        textColor = Colors.green[800]!;
        label = 'Completed';
        break;
      case TaskStatus.pending:
        color = Colors.red.withOpacity(0.1);
        textColor = Colors.red[800]!;
        label = 'Pending';
        break;
      case TaskStatus.rejected:
        color = Colors.red.withOpacity(0.1);
        textColor = Colors.red[800]!;
        label = 'Rejected';
        break;
      case TaskStatus.submitted:
        color = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue[800]!;
        label = 'Submitted';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(TaskPriority priority) {
    Color color;
    String label;

    switch (priority) {
      case TaskPriority.high:
        color = Colors.blue;
        label = 'High';
        break;
      case TaskPriority.medium:
        color = Colors.blue[300]!;
        label = 'Medium';
        break;
      case TaskPriority.low:
        color = Colors.blue[100]!;
        label = 'Low';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDateInfo(String label, DateTime date, {bool isDue = false}) {
    final formatter = DateFormat('dd/MM/yyyy');
    return Row(
      children: [
        Icon(
          isDue ? Icons.calendar_today : Icons.assignment_ind_outlined,
          size: 14,
          color: isDue ? Colors.red[300] : Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Text(
          '$label ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          formatter.format(date),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDue ? Colors.red[700] : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    if (!task.hasAction) {
      return InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.visibility_outlined, size: 18, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'View',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.visibility_outlined, size: 18, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'View',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(width: 1, height: 45, color: Colors.grey[200]),
        Expanded(
          child: InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: task.isDestructiveAction ? Colors.red : Colors.blue,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    task.isDestructiveAction ? Icons.refresh : Icons.edit_note,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    task.actionLabel ?? 'Action',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
