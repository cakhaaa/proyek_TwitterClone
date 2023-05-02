import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:proyek/core/core.dart';
import 'package:proyek/core/providers.dart';

final authAPIProvider = Provider((ref) {
 final account = ref.watch(appwriteAccountProvider);
 return AuthAPI(account: account);
});

// untuk signup dan get user account -> Account
// untuk akses user related data -> model.Account

abstract class IAuthAPI {
  FutureEither <model.Account> signUp({
    required String email,
    required String password,
  }); 
   FutureEither <model.Session> login({
    required String email,
    required String password,
  });
  Future<model.Account?> currentUserAccount();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

@override
  Future<model.Account?> currentUserAccount() async {
    try {
        return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }
  @override
  FutureEither <model.Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(), 
        email: email, 
        password: password
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace){
      return left (
        Failure(e.message ?? 'Error yang tidak terduga', stackTrace),
        );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
       );
    }
  }
  
  @override
  FutureEither<model.Session> login({
    required String email, 
    required String password,
    }) async {
   try {
      final session = await _account.createEmailSession( 
        email: email, 
        password: password
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace){
      return left (
        Failure(e.message ?? 'Error yang tidak terduga', stackTrace),
        );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
       );
    }
  }
}
