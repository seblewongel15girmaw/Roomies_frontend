
abstract class ThemeEvent {}

class ThemeChange extends ThemeEvent{
  bool isDark;
  ThemeChange(this.isDark);
}