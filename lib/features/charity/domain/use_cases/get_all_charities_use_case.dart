import 'package:either_dart/either.dart';
import '../../../../core/base_classes/failures.dart';
import '../../../../core/base_classes/use_cases.dart';
import '../entities/charity.dart';
import '../repositories/charity_repository.dart';

class GetAllCharitiesUseCase extends UseCase<List<Charity>, NoParams> {

  final CharityRepository repository;

  GetAllCharitiesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Charity>>> call(NoParams params) async {
    return await repository.getAll();
  }
}
