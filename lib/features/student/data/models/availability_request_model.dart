class AvailabilityRequestModel {
  final String workType; // remote / on_site / hybrid
  final String hours;    // 5-10 / 10-15 / 20+
  final List<String> days;

  AvailabilityRequestModel({
    required this.workType,
    required this.hours,
    required this.days,
  });

  Map<String, dynamic> toJson() {
    return {
      'preferred_work_type': workType,
      'available_hours': {
        'weekly_hours': hours,
        'days': days,
      },
      // ⚠️ TODO حرج: availability_status مطلوب (required) بالباك اند حسب
      // UpdateAvailabilityRequest، بس مش موجود بالتصميم أصلاً.
      // لازم جواب الليدر قبل أي تجربة فعلية، وإلا الطلب هيرجع 422.
      'availability_status': 'available', // قيمة مؤقتة بس
    };
  }
}