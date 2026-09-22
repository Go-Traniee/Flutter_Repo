import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary & Secondary Colors (الألوان الرئيسية)
  static const Color navy = Color(0xFF123B68);
  static const Color navyDark = Color(0xFF011751);
  static const Color gold = Color(0xFFE2A519);
  static const Color goldAccent = Color(0xFFF2B233);

  // Status & Feedback Colors (حالات النظام)
  static const Color error = Color(0xFFE60000);
  static const Color success = Color(0xFF008000);
  static const Color warning = Color(0xFFF59E0B);

  // Background, Containers & Borders (الخلفيات والإطارات)
  static const Color white = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color tabBackground = Color(0xFFE3E9F0);
  static const Color borderLight = Color(0xFFD9D9D9);
  static const Color borderUnselected = Color(0xFFBBBBBB);
  static const Color inputBorder = Color(0xFFE2E8F0);
  static const Color inputFill = Color(0xFFF8FAFC);

  // Text & Label Colors (النصوص والعناوين)
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textBody = Color(0xFF525355);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF8E8E8E);
  static const Color textGoogle = Color(0xFF686868);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color iconColor = Color(0xFF94A3B8);
}