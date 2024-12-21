import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen>
    with StyleExtension {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours(context).backgroundColor,
      body: Center(
        child: Text('This is product listing screen',
            style: textStyles(context).asgardTextStyle1),
      ),
    );
  }
}
