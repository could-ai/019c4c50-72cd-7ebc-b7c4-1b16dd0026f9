import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/dashboard_stats.dart';
import '../widgets/task_list_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 1; // Tasks tab selected by default

  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Store Cleanliness Check',
      location: 'Downtown Store',
      type: TaskType.task,
      status: TaskStatus.inProgress,
      priority: TaskPriority.high,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      assignedDate: DateTime.now().subtract(const Duration(days: 2)),
      assigneeName: 'John Smith',
    ),
    Task(
      id: '2',
      title: 'Weekly Performance Check Task',
      location: 'Central Plaza',
      type: TaskType.task,
      status: TaskStatus.inProgress,
      priority: TaskPriority.low,
      dueDate: DateTime.now().add(const Duration(days: 3)),
      assignedDate: DateTime.now().subtract(const Duration(days: 1)),
      assigneeName: 'Priya Sharma',
    ),
    Task(
      id: '3',
      title: 'Visual Merchandising Audit',
      location: 'Downtown Store',
      type: TaskType.checklist,
      status: TaskStatus.completed,
      priority: TaskPriority.high,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      assignedDate: DateTime.now().subtract(const Duration(days: 5)),
      assigneeName: 'John Smith',
    ),
    Task(
      id: '4',
      title: 'Update Store Signage',
      location: 'Downtown Store',
      type: TaskType.task,
      status: TaskStatus.pending,
      priority: TaskPriority.medium,
      dueDate: DateTime.now().add(const Duration(days: 2)),
      assignedDate: DateTime.now().subtract(const Duration(days: 3)),
      assigneeName: 'Sarah Johnson',
      hasAction: true,
      actionLabel: 'Respond',
    ),
    Task(
      id: '5',
      title: 'Store Cleanliness Task',
      location: 'Downtown Store',
      type: TaskType.task,
      status: TaskStatus.inProgress,
      priority: TaskPriority.high,
      dueDate: DateTime.now().add(const Duration(days: 4)),
      assignedDate: DateTime.now().subtract(const Duration(days: 2)),
      assigneeName: 'Sarah Johnson',
    ),
    Task(
      id: '6',
      title: 'Daily Store Operations Checklist',
      location: 'Mall Store',
      type: TaskType.checklist,
      status: TaskStatus.submitted,
      priority: TaskPriority.high,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      assignedDate: DateTime.now().subtract(const Duration(days: 4)),
      assigneeName: 'John Smith',
    ),
    Task(
      id: '7',
      title: 'Restock Premium Items Display',
      location: 'Mall Store',
      type: TaskType.task,
      status: TaskStatus.pending,
      priority: TaskPriority.high,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      assignedDate: DateTime.now().subtract(const Duration(days: 1)),
      assigneeName: 'Mike Chen',
      hasAction: true,
      actionLabel: 'Respond',
    ),
    Task(
      id: '8',
      title: 'Safety Compliance Audit',
      location: 'Mall Store',
      type: TaskType.checklist,
      status: TaskStatus.rejected,
      priority: TaskPriority.high,
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      assignedDate: DateTime.now().subtract(const Duration(days: 6)),
      assigneeName: 'James Martinez',
      hasAction: true,
      actionLabel: 'Resubmit',
      isDestructiveAction: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          'All Tasks',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: Text('JS', style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search tasks...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.blue),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const DashboardStats(),
                const SizedBox(height: 24),
                
                // Task List Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Task List',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sort, size: 18),
                      label: const Text('Sort by'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Tasks
                ..._tasks.map((task) => TaskListItem(task: task)),
                
                // Load More
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.blue[300]!),
                    ),
                    child: const Text('Load More Tasks'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
