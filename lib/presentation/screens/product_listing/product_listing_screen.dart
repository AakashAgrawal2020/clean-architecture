import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/location_permission_handler.dart';
import 'package:clean_architecture/presentation/screens/product_listing/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen>
    with StyleExtension, WidgetsBindingObserver {
  late List<String> _images;
  late List<String> _title;
  late List<String> _description;
  late List<bool> _isVisible;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchLocation();
    _isVisible = [];
    _images = [
      'https://dummyimage.com/600x400/000/fff',
      'https://placekitten.com/400/300',
      'https://dummyimage.com/600x400/000/fff',
      'https://loremflickr.com/320/240',
      'https://dummyimage.com/600x400/000/fff',
      'https://placekitten.com/400/300',
      'https://dummyimage.com/600x400/000/fff',
      'https://loremflickr.com/320/240'
    ];
    _title = [
      'Sample title 1',
      'Sample title 2',
      'Sample title 3',
      'Sample title 4',
      'Sample title 5',
      'Sample title 6',
      'Sample title 7',
      'Sample title 8',
    ];
    _description = [
      'Sample body content for item 1',
      'Sample body content for item 2',
      'Sample body content for item 3',
      'Sample body content for item 4',
      'Sample body content for item 5',
      'Sample body content for item 6',
      'Sample body content for item 7',
      'Sample body content for item 8',
    ];
    _initializeAnimation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _fetchLocation();
    }
  }

  Future<void> _fetchLocation() async {
    final value = await requestLocationPermission();
    setState(() {
      currentLocation = value;
    });
  }

  void _initializeAnimation() {
    for (int i = 0; i < _images.length; i++) {
      _isVisible.add(false);
      Future.delayed(Duration(milliseconds: i * 200), () {
        setState(() {
          _isVisible[i] = true;
        });
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours(context).backgroundColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.dm10),
                  child: Text(Strings.productListingScreenHeading,
                      style: textStyles(context).asgardTextStyle2)),
              Expanded(
                child: ListView.separated(
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        image: _images[index],
                        currentLocation: currentLocation,
                        title: _title[index],
                        description: _description[index],
                        isVisible: _isVisible[index],
                        latitude: 28.447720,
                        longitude: 77.524567,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Dimens.dm20.verticalSpace;
                    }),
              ),
            ],
          ),
        ));
  }
}
