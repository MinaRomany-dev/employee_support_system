import 'package:flutter/material.dart';
class ColorManager {

  static const Color whiteColor          = Colors.white;
  // ── Primary ──────────────────────────────
  static const Color primary        = Color(0xFF2563EB);
  static const Color primaryDark    = Color(0xFF1D4ED8);
  static const Color primaryLight   = Color(0xFFEFF6FF);

  // ── Surfaces ─────────────────────────────
  static const Color background     = Color(0xFFF8FAFC);
  static const Color surface        = Color(0xFFFFFFFF);
  static const Color border         = Color(0xFFE2E8F0);

  // ── Text ─────────────────────────────────
  static const Color textPrimary    = Color(0xFF0F172A);
  static const Color textSecondary  = Color(0xFF64748B);
  static const Color textMuted      = Color(0xFF94A3B8);

  // ── Status backgrounds ───────────────────
  static const Color openBg         = Color(0xFFEFF6FF);
  static const Color inProgressBg   = Color(0xFFFFFBEB);
  static const Color resolvedBg     = Color(0xFFF0FDF4);
  static const Color closedBg       = Color(0xFFF8FAFC);

  // ── Status text ──────────────────────────
  static const Color openText       = Color(0xFF1D4ED8);
  static const Color inProgressText = Color(0xFFB45309);
  static const Color resolvedText   = Color(0xFF15803D);
  static const Color closedText     = Color(0xFF475569);

  // ── Priority backgrounds ─────────────────
  static const Color highBg         = Color(0xFFFEF2F2);
  static const Color mediumBg       = Color(0xFFFFFBEB);
  static const Color lowBg          = Color(0xFFF0FDF4);

  // ── Priority text ────────────────────────
  static const Color highText       = Color(0xFFB91C1C);
  static const Color mediumText     = Color(0xFFB45309);
  static const Color lowText        = Color(0xFF15803D);

  // ── Semantic ─────────────────────────────
  static const Color success        = Color(0xFF22C55E);
  static const Color warning        = Color(0xFFF59E0B);
  static const Color error          = Color(0xFFEF4444);
  static const Color info           = Color(0xFF3B82F6);

  // ── SLA Alert (ticket متأخرة) ────────────
  static const Color slaBg          = Color(0xFFFEF2F2);
  static const Color slaBorder      = Color(0xFFFCA5A5);
  static const Color slaText        = Color(0xFFB91C1C);
}