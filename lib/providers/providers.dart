import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sonar/providers/personal_info.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider<PersonalInfo>(
      create: (context) => PersonalInfo(),
    ),
  ];
}
