import 'package:either_dart/either.dart';
import '../../../../core/base_classes/failures.dart';
import '../../../../core/base_classes/use_cases.dart';
import '../entities/charity.dart';
import '../repositories/charity_repository.dart';

class CharityCreateUseCase extends UseCase<bool, Charity> {

  final CharityRepository repository;

  CharityCreateUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Charity params) async {
    return await repository.createCharity(params);
  }
}
