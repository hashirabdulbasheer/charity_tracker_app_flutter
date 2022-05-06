import 'package:charity_tracker/core/misc/date_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../core/base_classes/responses.dart';
import '../../../../core/configs/charity_configs.dart';
import '../models/charity_api_model.dart';

abstract class CharityFirebaseDataSource {
  /// Create and add a new charity object
  Future<CharityResponse> createCharity(CharityApiModel charity);

  /// Update an existing charity object
  Future<CharityResponse> updateCharity(CharityApiModel charity);

  /// Delete an existing charity object
  Future<CharityResponse> deleteCharity(CharityApiModel charity);

  /// Firebase specific query
  Query getCharityQuery();

  /// Returns the list of saved charities
  Future<CharityResponse> getAll();
}

class CharityFirebaseDataSourceImpl extends CharityFirebaseDataSource {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child('charities').child(CharityConfig.charityBox);

  /// Create and add a new charity object
  @override
  Future<CharityResponse> createCharity(CharityApiModel charity) async {
    try {
      await _messagesRef.push().set(charity.toJson());
      return const CharityResponse(isSuccessful: true);
    } catch (error) {
      return CharityResponse(isSuccessful: false, errorMessage: error.toString());
    }
  }

  /// Update an existing charity object
  @override
  Future<CharityResponse> updateCharity(CharityApiModel charity) async {
    try {
      if (charity.key != null && charity.key?.isNotEmpty == true) {
        await _messagesRef.child(charity.key!).update(charity.toJson());
        return const CharityResponse(isSuccessful: true);
      }
    } catch (error) {
      return CharityResponse(isSuccessful: false, errorMessage: error.toString());
    }
    return const CharityResponse(isSuccessful: false);
  }

  /// Delete an existing charity object
  @override
  Future<CharityResponse> deleteCharity(CharityApiModel charity) async {
    try {
      if (charity.key != null) {
        await _messagesRef.child(charity.key!).remove();
        return const CharityResponse(isSuccessful: true);
      }
    } catch (error) {
      return CharityResponse(isSuccessful: false, errorMessage: error.toString());
    }
    return const CharityResponse(isSuccessful: false);
  }

  @override
  Query getCharityQuery() {
    return _messagesRef;
  }

  /// Returns the list of saved charities
  @override
  Future<CharityResponse> getAll() async {
    try {
      List<CharityApiModel> charities = [];
      DataSnapshot snapshot = await _messagesRef.once();
      if (snapshot.value != null) {
        for (var val in snapshot.value.entries) {
          CharityApiModel charity = CharityApiModel.fromJson(val.value);
          charity.key = val.key;
          charities.add(charity);
        }
      }
      // applying date filter
      int startDateTimestamp = CharityDateUtils.timestampFromString(CharityConfig.startDate);
      charities = charities.where((element) => element.date >= startDateTimestamp).toList();
      return CharityResponse(isSuccessful: true, successObject: charities);
    } catch (error) {
      return CharityResponse(isSuccessful: false, errorMessage: error.toString());
    }
  }
}
