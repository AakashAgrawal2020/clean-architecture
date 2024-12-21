import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/presentation/screens/product_listing/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen>
    with StyleExtension {
  late List<String> images;
  late List<String> title;
  late List<String> description;

  @override
  void initState() {
    super.initState();
    images = [
      'https://dummyimage.com/600x400/000/fff',
      'https://placekitten.com/400/300',
      'https://dummyimage.com/600x400/000/fff',
      'https://loremflickr.com/320/240'
    ];
    title = [
      'Sample title 1',
      'Sample title 2',
      'Sample title 3',
      'Sample title 4',
    ];
    description = [
      'Sample body content for item 1',
      'Sample body content for item 2',
      'Sample body content for item 3',
      'Sample body content for item 4',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours(context).backgroundColor,
        appBar: AppBar(
            backgroundColor: colours(context).backgroundColor,
            title: Text(Strings.productListingScreenHeading,
                style: textStyles(context).asgardTextStyle2)),
        body: ListView.separated(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ProductCard(
                image: images[index],
                title: title[index],
                description: description[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Dimens.dm20.verticalSpace;
          },
        ));
  }
}
