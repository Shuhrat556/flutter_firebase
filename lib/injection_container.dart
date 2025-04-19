import 'package:firebase_core/firebase_core.dart';
import 'package:test_firebase_app/features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  await Firebase.initializeApp();
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInWithEmailAndPassword(sl()));

  // BLoC
  sl.registerFactory(() => AuthBloc(
    signInWithEmailAndPassword: sl(),
    signUpWithEmailAndPassword: sl(),
    signOut: sl(),
  ));
}