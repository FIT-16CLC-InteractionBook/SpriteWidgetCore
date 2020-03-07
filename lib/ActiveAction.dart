import 'package:spritewidget/spritewidget.dart';
import 'package:yaml/yaml.dart';

class ActiveAction {
  Type type;
  YamlMap motion;

  ActiveAction(this.type, this.motion);
}