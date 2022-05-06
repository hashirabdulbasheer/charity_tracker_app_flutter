import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';
import '../../../../core/base_classes/failures.dart';
import '../../../../core/base_classes/responses.dart';
import '../../domain/entities/charity.dart';
import '../../domain/repositories/charity_repository.dart';
import '../data_sources/charity_firebase_datasource.dart';
import '../models/mappers/charity_mappers.dart';

class CharityRepositoryImpl extends CharityRepository {
  final CharityFirebaseDataSource dataSource;

  CharityRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> createCharity(Charity charity) async {
    CharityResponse response =
        await dataSource.createCharity(CharityMapper.charityToApiModel(charity));
    if (response.isSuccessful) {
      return const Right(true);
    } else {
      String errorMessage = response.errorMessage ?? "errors.create_charity_error".tr();
      return Left(GeneralFailure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCharity(Charity charity) async {
    CharityResponse response =
        await dataSource.deleteCharity(CharityMapper.charityToApiModel(charity));
    if (response.isSuccessful) {
      return const Right(true);
    } else {
      String errorMessage = response.errorMessage ?? "errors.delete_charity_error".tr();
      return Left(GeneralFailure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCharity(Charity charity) async {
    CharityResponse response =
        await dataSource.updateCharity(CharityMapper.charityToApiModel(charity));
    if (response.isSuccessful) {
      return const Right(true);
    } else {
      String errorMessage = response.errorMessage ?? "errors.update_charity_error".tr();
      return Left(GeneralFailure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Charity>>> getAll() async {
    CharityResponse response = await dataSource.getAll();
    if (response.isSuccessful) {
      List<Charity> charityList = CharityMapper.apiModelListToCharityList(response.successObject);
      return Right(charityList);
    }
    String errorMessage = response.errorMessage ?? "errors.general_error".tr();
    return Left(GeneralFailure(message: errorMessage));
  }
}
