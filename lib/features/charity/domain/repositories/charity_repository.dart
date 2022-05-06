import 'package:either_dart/either.dart';
import '../../../../core/base_classes/failures.dart';
import '../entities/charity.dart';

abstract class CharityRepository {
  /// Create and add a new charity object
  Future<Either<Failure, bool>> createCharity(Charity charity);

  /// Update an existing charity object
  Future<Either<Failure, bool>> updateCharity(Charity charity);

  /// Delete an existing charity object
  Future<Either<Failure, bool>> deleteCharity(Charity charity);

  /// Returns the list of saved charities
  Future<Either<Failure, List<Charity>>> getAll();
}
