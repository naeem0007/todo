class ToDoModel {
  String title;
  bool isCompleted;

  ToDoModel({required this.title, required this.isCompleted});

  void toggleComplete() {
    isCompleted = !isCompleted;
  }
}
