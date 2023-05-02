import 'package:fpdart/fpdart.dart';
import 'package:proyek/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;