// // import 'dart:async';

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class QuizDatabase {
//   // singelton class
//   static final QuizDatabase _shared = QuizDatabase._sharedInstance();
//   QuizDatabase._sharedInstance();
//   factory QuizDatabase() => _shared;

//   Database? _db;

//   // // I think not needed
//   //  Future<Database> get database async {
//   //   if (_db != null) {
//   //     return _db!;
//   //   }
//   //   _db = await _open();
//   //   return _db!;
//   // }

//   // Future<Database> _initDatabase() async {
//   //   final path = join(await getDatabasesPath(), dbName);
//   //   return await openDatabase(path, version: 1, onCreate: _open);
//   // }

//   Future<void> _ensureDbIsOpen() async {
//     try {
//       await _open();
//     } catch (e) {
//       // TODO implement custom exceptions
//       throw Exception();
//     }
//   }

//   Future<void> _open() async {
//     if (_db != null) {
//       throw Exception();
//       // DatabaseAlreadyOpenedException();
//     }
//     try {
//       final path = join(await getDatabasesPath(), dbName);
//       final db = await openDatabase(path);
//       _db = db;
//       await db.execute(catagoryTable);
//       await db.execute(quizTable);
//       await db.execute(questionTable);
//       await db.execute(userTable);
//       await db.execute(userQuiz);
//       await db.execute(userResponse);
//     } catch (e) {
//       throw Exception();
//     }
//   }

//   Future<void> _close() async {
//     final db = _db;
//     if (db == null) {
//       // throw DatabaseNotOpenedException();
//     } else {
//       try {
//         await db.close();
//         _db = null;
//       } catch (e) {
//         throw Exception();
//       }
//     }
//   }
// }

// const dbName = "quiz_app.db";

// const catagoryTable = '''
//           CREATE TABLE Category (
//             category_id INTEGER PRIMARY KEY,
//             category_name TEXT NOT NULL 
//           )
//           ''';

// const quizTable = '''
//           CREATE TABLE Quiz (
//             quiz_id INTEGER PRIMARY KEY,
//             category_id INTEGER,
//             quiz_title TEXT NOT NULL,
//             quiz_description TEXT,
//             quiz_duration INTEGER,
//             FOREIGN KEY (category_id) REFERENCES Category (category_id)
//           )
//         ''';
// // quiz_total_questions INTEGER NOT NULL,

// const questionTable = '''
//           CREATE TABLE Question (
//             question_id INTEGER PRIMARY KEY,
//             quiz_id INTEGER NOT NULL,
//             question_text TEXT NOT NULL,
//             option_a TEXT NOT NULL,
//             option_b TEXT NOT NULL,
//             option_c TEXT NOT NULL,
//             option_d TEXT NOT NULL,
//             correct_option TEXT NOT NULL,
//             FOREIGN KEY (quiz_id) REFERENCES Quiz (quiz_id)
//           )
//         ''';

// const userTable = '''
//         CREATE TABLE User (
//           user_id INTEGER PRIMARY KEY
//         )
//       ''';
// //  , username TEXT NOT NULL,
// //  password TEXT NOT NULL

// const userQuiz = '''
//         CREATE TABLE UserQuiz (
//           user_quiz_id INTEGER PRIMARY KEY,
//           user_id INTEGER,
//           quiz_id INTEGER,
//           start_time INTEGER NOT NULL,
//           end_time INTEGER,
//           score INTEGER,
//           FOREIGN KEY (user_id) REFERENCES User (user_id),
//           FOREIGN KEY (quiz_id) REFERENCES Quiz (quiz_id)
//         )
//       ''';

// const userResponse = '''
//         CREATE TABLE UserResponse (
//           user_response_id INTEGER PRIMARY KEY,
//           user_quiz_id INTEGER,
//           question_id INTEGER,
//           selected_option TEXT NOT NULL,
//           is_correct INTEGER NOT NULL,
//           FOREIGN KEY (user_quiz_id) REFERENCES UserQuiz (user_quiz_id),
//           FOREIGN KEY (question_id) REFERENCES Question (question_id)
//         )
//       ''';
