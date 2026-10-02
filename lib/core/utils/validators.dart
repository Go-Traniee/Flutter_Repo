class AppValidators {
  // 1. حقل عام للتحقق من النص المطلوب
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? 'حقل $fieldName مطلوب' : 'هذا الحقل مطلوب';
    }
    return null;
  }

  // 2. التحقق التقني الصارم للبريد الإلكتروني (Gmail Strictly)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    // Regex يضمن الصيغة الدقيقة لـ gmail.com ويتقبل الحروف الكبيرة والصغيرة دون خطأ
    final gmailStrictRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[gG][mM][aA][iI][lL]\.[cC][oO][mM]$',
    );

    if (!gmailStrictRegex.hasMatch(value.trim())) {
      return 'يرجى إدخال البريد بشكل  صحيح ';
    }

    return null;
  }

  // 3. كلمة المرور (8 أحرف على الأقل)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 8) {
      return 'يجب ألا تقل كلمة المرور عن 8 أحرف';
    }
    return null;
  }

  // 4. تأكيد كلمة المرور
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }
    return null;
  }

  // 5. رابط الموقع الإلكتروني (اختياري للشركات)
  static String? validateWebsite(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final urlRegex = RegExp(r'^(https?:\/\/)?([\w\d\-_]+\.)+[\w\d\-_]+(\/.*)?$');
    if (!urlRegex.hasMatch(value.trim())) {
      return 'يرجى إدخال رابط موقع صحيح';
    }
    return null;
  }
}