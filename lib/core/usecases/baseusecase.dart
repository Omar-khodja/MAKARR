import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:makarr/core/error/failure.dart';

abstract class UseCase<T, params> {

  Future<Either<Failure, T>> call(params params);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object> get props => [];
}
