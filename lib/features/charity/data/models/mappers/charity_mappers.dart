import '../../../../../core/enums/charity_type.dart';
import '../../../domain/entities/charity.dart';
import '../charity_api_model.dart';

class CharityMapper {
  /// converts string -> charity type
  static CharityType stringToCharityType(String charityTypeString) {
    if (charityTypeString == CharityType.zakat.rawValue()) {
      return CharityType.zakat;
    } else if (charityTypeString == CharityType.sadaqa.rawValue()) {
      return CharityType.sadaqa;
    } else if (charityTypeString == CharityType.interest.rawValue()) {
      return CharityType.interest;
    } else if (charityTypeString == CharityType.notAssigned.rawValue()) {
      return CharityType.notAssigned;
    }
    return CharityType.notAssigned;
  }

  /// converts CharityApiModel -> Charity domain model
  static Charity apiModelToCharity(CharityApiModel apiModel) {
    return Charity(
        description: apiModel.description,
        amount: apiModel.amount,
        currency: apiModel.currency,
        date: apiModel.date,
        createdBy: apiModel.createdBy,
        type: apiModel.type,
        key: apiModel.key ?? "");
  }

  /// converts CharityApiModel -> Charity domain model
  static CharityApiModel charityToApiModel(Charity charity) {
    return CharityApiModel(
        description: charity.description,
        amount: charity.amount,
        currency: charity.currency,
        date: charity.date,
        createdBy: charity.createdBy,
        type: charity.type,
        key: charity.key);
  }

  /// converts List<CharityApiModel> -> List<Charity> domain model
  static List<Charity> apiModelListToCharityList(List<CharityApiModel> apiModelList) {
    return apiModelList.map((e) => apiModelToCharity(e)).toList();
  }
}
