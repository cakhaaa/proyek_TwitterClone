import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:proyek/constants/constants.dart';
import 'package:proyek/core/core.dart';
import 'package:proyek/core/providers.dart';
import 'package:proyek/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabaseProvider)
  );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
   try {
   await _db.createDocument(
      databaseId: AppwriteConstants.databaseId, 
      collectionId: AppwriteConstants.usersCollection, 
      documentId: ID.unique(),
      data: userModel.toMap ()
      );
      return right(null);
   } on AppwriteException catch (e, st) {
    return left(
      Failure(
         e.message??'Some unexpected error occured' , 
         st,
        ),
      );
    }catch (e, st) {
    return left(Failure(e.toString(), st));
    }
  }
}