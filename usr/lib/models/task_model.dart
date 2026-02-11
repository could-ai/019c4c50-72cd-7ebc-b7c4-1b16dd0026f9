enum TaskStatus {
  inProgress,
  completed,
  pending,
  rejected,
  submitted,
}

enum TaskPriority {
  high,
  medium,
  low,
}

enum TaskType {
  task,
  checklist,
}

class Task {
  final String id;
  final String title;
  final String location;
  final TaskType type;
  final TaskStatus status;
  final TaskPriority priority;
  final DateTime dueDate;
  final DateTime assignedDate;
  final String assigneeName;
  final String? assigneeAvatarUrl; // Using initials if null
  final bool hasAction;
  final String? actionLabel;
  final bool isDestructiveAction;

  Task({
    required this.id,
    required this.title,
    required this.location,
    required this.type,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.assignedDate,
    required this.assigneeName,
    this.assigneeAvatarUrl,
    this.hasAction = false,
    this.actionLabel,
    this.isDestructiveAction = false,
  });
}
