import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  late GetStorage _box;

  static const String _userSchoolKey = 'user_school';
  static const String _userEmailKey = 'user_email';
  static const String _quizResultsKey = 'quiz_results';
  static const String _userNameKey = 'user_name';
  static const String _bestScoreKey = 'best_score';
  static const String _totalAttemptsKey = 'total_attempts';
  static const String _userProfileImageKey = 'user_profile_image';

  Future<StorageService> init() async {
    _box = GetStorage();
    return this;
  }

  void saveUserProfile({
    required String name,
    required String school,
    required String email,
    String? profileImage,
  }) {
    _box.write(_userNameKey, name);
    _box.write(_userSchoolKey, school);
    _box.write(_userEmailKey, email);
    if (profileImage != null) {
      _box.write(_userProfileImageKey, profileImage);
    }
  }

  Map<String, String> getUserProfile() {
    return {
      'name': _box.read(_userNameKey) ?? '',
      'school': _box.read(_userSchoolKey) ?? '',
      'email': _box.read(_userEmailKey) ?? '',
      'profileImage': _box.read(_userProfileImageKey) ?? '',
    };
  }

  String? getUserSchool() {
    return _box.read(_userSchoolKey);
  }

  String? getUserEmail() {
    return _box.read(_userEmailKey);
  }

  String? getUserProfileImage() {
  return _box.read(_userProfileImageKey);
}


  void saveQuizResult({
    required String quizTitle,
    required int score,
    required int totalQuestions,
    required double percentage,
    required String grade,
    required DateTime completedAt,
    required Duration timeSpent,
    required List<Map<String, dynamic>> answers,
  }) {
    List<dynamic> results = getQuizResults();

    Map<String, dynamic> newResult = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'quizTitle': quizTitle,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'grade': grade,
      'completedAt': completedAt.toIso8601String(),
      'timeSpent': timeSpent.inSeconds,
      'answers': answers,
    };

    results.insert(0, newResult);

    if (results.length > 50) {
      results = results.take(50).toList();
    }

    _box.write(_quizResultsKey, results);

    _updateStatistics(score, totalQuestions, percentage);
  }

  List<Map<String, dynamic>> getQuizResults() {
    List<dynamic> results = _box.read(_quizResultsKey) ?? [];
    return results.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Map<String, dynamic>? getLatestQuizResult() {
    List<Map<String, dynamic>> results = getQuizResults();
    return results.isNotEmpty ? results.first : null;
  }

  List<Map<String, dynamic>> getQuizResultsByTitle(String quizTitle) {
    return getQuizResults()
        .where((result) => result['quizTitle'] == quizTitle)
        .toList();
  }

  void deleteQuizResult(String resultId) {
    List<Map<String, dynamic>> results = getQuizResults();
    results.removeWhere((result) => result['id'] == resultId);
    _box.write(_quizResultsKey, results);
  }

  void clearAllQuizResults() {
    _box.remove(_quizResultsKey);
    _box.remove(_bestScoreKey);
    _box.remove(_totalAttemptsKey);
  }

  void _updateStatistics(int score, int totalQuestions, double percentage) {
    double currentBest = getBestScore();
    if (percentage > currentBest) {
      _box.write(_bestScoreKey, percentage);
    }

    int attempts = getTotalAttempts();
    _box.write(_totalAttemptsKey, attempts + 1);
  }

  double getBestScore() {
    return _box.read(_bestScoreKey) ?? 0.0;
  }

  int getTotalAttempts() {
    return _box.read(_totalAttemptsKey) ?? 0;
  }

  double getAverageScore() {
    List<Map<String, dynamic>> results = getQuizResults();
    if (results.isEmpty) return 0.0;

    double total = 0.0;
    for (var result in results) {
      total += result['percentage'] ?? 0.0;
    }

    return total / results.length;
  }

  Map<String, dynamic> getStatistics() {
    List<Map<String, dynamic>> results = getQuizResults();

    return {
      'totalAttempts': getTotalAttempts(),
      'bestScore': getBestScore(),
      'averageScore': getAverageScore(),
      'lastScore': results.isNotEmpty ? results.first['percentage'] : 0.0,
      'totalQuizzes': results.length,
      'perfectScores': results.where((r) => r['percentage'] >= 100.0).length,
    };
  }

  void saveUserName(String name) {
    _box.write(_userNameKey, name);
  }

  String? getUserName() {
    return _box.read(_userNameKey);
  }

  static String calculateGrade(double percentage) {
    if (percentage >= 90) return 'A';
    if (percentage >= 80) return 'B';
    if (percentage >= 70) return 'C';
    if (percentage >= 60) return 'D';
    return 'E';
  }

  Map<String, dynamic> exportData() {
    return {
      'quizResults': getQuizResults(),
      'userName': getUserName(),
      'statistics': getStatistics(),
      'exportedAt': DateTime.now().toIso8601String(),
    };
  }

  void importData(Map<String, dynamic> data) {
    if (data.containsKey('quizResults')) {
      _box.write(_quizResultsKey, data['quizResults']);
    }
    if (data.containsKey('userName')) {
      _box.write(_userNameKey, data['userName']);
    }
  }
}
