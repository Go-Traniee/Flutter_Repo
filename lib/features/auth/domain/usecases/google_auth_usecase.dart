import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthUseCase {
  Future<Either<String, GoogleSignInAccount>> call() async {
    try {
      // الاستدعاء المباشر المتوافق مع الإصدار 7.x.x
      final GoogleSignInAccount? account = await GoogleSignIn.instance.authenticate();

      if (account != null) {
        return Right(account);
      } else {
        return const Left('تم إلغاء تسجيل الدخول بواسطة Google');
      }
    } catch (error) {
      return Left('حدث خطأ أثناء الاتصال بجوجل: $error');
    }
  }
}