import 'package:clean_architecture/core/config/theme/asgard_colors.dart';
import 'package:clean_architecture/core/config/theme/asgard_textstyles.dart';
import 'package:flutter/material.dart';

mixin StyleExtension {
  AsgardColours colours(BuildContext context) {
    return Theme.of(context).extension<AsgardColours>()!;
  }

  AsgardTextStyles textStyles(BuildContext context) {
    return Theme.of(context).extension<AsgardTextStyles>()!;
  }
}
