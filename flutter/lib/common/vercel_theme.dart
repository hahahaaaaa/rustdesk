import 'package:flutter/material.dart';

/// Design tokens translated from DESIGN.md (Vercel / Geist).
class VcColors {
  VcColors._();

  static const ink = Color(0xFF171717);
  static const paper = Color(0xFFFFFFFF);
  static const gray600 = Color(0xFF4D4D4D);
  static const gray500 = Color(0xFF666666);
  static const gray400 = Color(0xFF808080);
  static const gray100 = Color(0xFFEBEBEB);
  static const gray50 = Color(0xFFFAFAFA);
  static const link = Color(0xFF0072F5);
  static const focus = Color(0xFF0070F5);
  static const ship = Color(0xFFFF5B4F);
  static const preview = Color(0xFFDE1D8D);
  static const develop = Color(0xFF0A72EF);
  static const badgeBg = Color(0xFFEBF5FF);
  static const badgeText = Color(0xFF0068D6);

  static const darkCanvas = Color(0xFF000000);
  static const darkSurface = Color(0xFF0A0A0A);
  static const darkElevated = Color(0xFF141414);
  static const darkText = Color(0xFFEDEDED);
  static const darkMuted = Color(0xFFA1A1A1);
  static const darkBorder = Color(0xFF262626);

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color canvas(BuildContext context) =>
      isDark(context) ? darkCanvas : paper;

  static Color surface(BuildContext context) =>
      isDark(context) ? darkSurface : paper;

  static Color elevated(BuildContext context) =>
      isDark(context) ? darkElevated : gray50;

  static Color text(BuildContext context) =>
      isDark(context) ? darkText : ink;

  static Color muted(BuildContext context) =>
      isDark(context) ? darkMuted : gray600;

  static Color faint(BuildContext context) =>
      isDark(context) ? const Color(0xFF7D7D7D) : gray400;

  static Color border(BuildContext context) =>
      isDark(context) ? darkBorder : gray100;

  static Color inverse(BuildContext context) =>
      isDark(context) ? const Color(0xFF0A0A0A) : paper;

  static Color inverseText(BuildContext context) =>
      isDark(context) ? const Color(0xFF0A0A0A) : paper;

  static List<BoxShadow> borderShadow(BuildContext context) => [
        BoxShadow(
          color: isDark(context) ? darkBorder : const Color(0x14000000),
          offset: Offset.zero,
          blurRadius: 0,
          spreadRadius: 1,
        ),
      ];

  static List<BoxShadow> cardShadows(BuildContext context) => [
        ...borderShadow(context),
        BoxShadow(
          color: Colors.black.withOpacity(isDark(context) ? 0.32 : 0.04),
          offset: const Offset(0, 2),
          blurRadius: 2,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(isDark(context) ? 0.24 : 0.04),
          offset: const Offset(0, 8),
          blurRadius: 8,
          spreadRadius: -8,
        ),
      ];
}

class VcType {
  VcType._();

  static const sans = 'Geist';
  static const mono = 'Geist Mono';
  static const fallback = <String>[
    'Microsoft YaHei',
    'PingFang SC',
    'Noto Sans SC',
    'Segoe UI',
    'Roboto',
  ];

  static double tracking(double size) {
    if (size >= 40) return -2.4;
    if (size >= 30) return -1.28;
    if (size >= 22) return -0.96;
    if (size >= 16) return -0.32;
    return 0;
  }

  static TextStyle display(BuildContext context, {double size = 48}) =>
      TextStyle(
        fontFamily: sans,
        fontFamilyFallback: fallback,
        fontSize: size,
        fontWeight: FontWeight.w600,
        height: 1.04,
        letterSpacing: tracking(size),
        color: VcColors.text(context),
      );

  static TextStyle heading(BuildContext context, {double size = 32}) =>
      display(context, size: size);

  static TextStyle title(BuildContext context, {double size = 24}) =>
      display(context, size: size);

  static TextStyle body(BuildContext context,
          {double size = 16, FontWeight weight = FontWeight.w400}) =>
      TextStyle(
        fontFamily: sans,
        fontFamilyFallback: fallback,
        fontSize: size,
        fontWeight: weight,
        height: 1.55,
        letterSpacing: size >= 16 ? -0.32 : 0,
        color: VcColors.text(context),
      );

  static TextStyle muted(BuildContext context, {double size = 14}) =>
      TextStyle(
        fontFamily: sans,
        fontFamilyFallback: fallback,
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: 1.54,
        color: VcColors.muted(context),
      );

  static TextStyle monoLabel(BuildContext context, {Color? color}) => TextStyle(
        fontFamily: mono,
        fontFamilyFallback: fallback,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.7,
        color: color ?? VcColors.faint(context),
      );

  static TextStyle monoValue(
    BuildContext context, {
    double size = 22,
    FontWeight weight = FontWeight.w500,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: mono,
        fontFamilyFallback: fallback,
        fontSize: size,
        fontWeight: weight,
        height: 1.2,
        letterSpacing: -0.2,
        color: color ?? VcColors.text(context),
      );
}

class VcSurface extends StatelessWidget {
  const VcSurface({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.radius = 8,
    this.color,
    this.elevated = false,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color? color;
  final bool elevated;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final shadows = borderColor == null
        ? (elevated
            ? VcColors.cardShadows(context)
            : VcColors.borderShadow(context))
        : [
            BoxShadow(
              color: borderColor!,
              offset: Offset.zero,
              blurRadius: 0,
              spreadRadius: 1,
            ),
          ];
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? VcColors.surface(context),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}

class VcMonoLabel extends StatelessWidget {
  const VcMonoLabel(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: VcType.monoLabel(context, color: color),
    );
  }
}

class VcPill extends StatelessWidget {
  const VcPill({
    super.key,
    required this.label,
    this.active = false,
    this.leading,
  });

  final String label;
  final bool active;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final bg = active
        ? (VcColors.isDark(context) ? VcColors.badgeBg : VcColors.badgeBg)
        : VcColors.elevated(context);
    final fg = active
        ? VcColors.badgeText
        : (VcColors.isDark(context) ? VcColors.darkMuted : VcColors.gray600);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontFamily: VcType.sans,
              fontFamilyFallback: VcType.fallback,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.2,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

class VcPrimaryButton extends StatefulWidget {
  const VcPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 36,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double height;
  final bool expand;

  @override
  State<VcPrimaryButton> createState() => _VcPrimaryButtonState();
}

class _VcPrimaryButtonState extends State<VcPrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final base = VcColors.isDark(context) ? Colors.white : VcColors.ink;
    final hoverColor = VcColors.isDark(context)
        ? const Color(0xFFD4D4D4)
        : const Color(0xFF383838);
    final fg = VcColors.isDark(context) ? VcColors.ink : Colors.white;
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: widget.height,
          width: widget.expand ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: enabled
                ? (_hover ? hoverColor : base)
                : base.withOpacity(0.32),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                IconTheme(
                  data: IconThemeData(color: fg, size: 16),
                  child: widget.icon!,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: VcType.sans,
                  fontFamilyFallback: VcType.fallback,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VcSecondaryButton extends StatefulWidget {
  const VcSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 36,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double height;
  final bool expand;

  @override
  State<VcSecondaryButton> createState() => _VcSecondaryButtonState();
}

class _VcSecondaryButtonState extends State<VcSecondaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final fg = VcColors.text(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: widget.height,
          width: widget.expand ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: _hover ? VcColors.elevated(context) : VcColors.surface(context),
            borderRadius: BorderRadius.circular(6),
            boxShadow: VcColors.borderShadow(context),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                IconTheme(
                  data: IconThemeData(color: fg, size: 16),
                  child: widget.icon!,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: VcType.sans,
                  fontFamilyFallback: VcType.fallback,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VcIconButton extends StatefulWidget {
  const VcIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 32,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;

  @override
  State<VcIconButton> createState() => _VcIconButtonState();
}

class _VcIconButtonState extends State<VcIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final child = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _hover ? VcColors.elevated(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(color: VcColors.muted(context), size: 18),
            child: widget.icon,
          ),
        ),
      ),
    );
    if (widget.tooltip == null) return child;
    return Tooltip(message: widget.tooltip!, child: child);
  }
}
