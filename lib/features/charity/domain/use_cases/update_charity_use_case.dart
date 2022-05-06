import 'package:either_dart/src/either.dart';
import '../../../../core/base_classes/failures.dart';
import '../../../../core/base_classes/use_cases.dart';
import '../entities/charity.dart';
import '../repositories/charity_repository.dart';

class CharityUpdateUseCase extends UseCase<bool, Charity> {

  final CharityRepository repository;

  CharityUpdateUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Charity charity) async {
    return await repository.updateCharity(charity);
  }
}
