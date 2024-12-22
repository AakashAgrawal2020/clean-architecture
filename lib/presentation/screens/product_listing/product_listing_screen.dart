import 'package:clean_architecture/core/components/error.dart';
import 'package:clean_architecture/core/components/no_internet.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/location_permission_handler.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/main.dart';
import 'package:clean_architecture/presentation/screens/product_listing/bloc/products_bloc.dart';
import 'package:clean_architecture/presentation/screens/product_listing/widgets/page_loading.dart';
import 'package:clean_architecture/presentation/screens/product_listing/widgets/product_card.dart';
import 'package:clean_architecture/presentation/screens/product_listing/widgets/zero_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen>
    with StyleExtension, WidgetsBindingObserver {
  late List<bool> _isVisible;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchLocation();
    _isVisible = [];
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && currentLocation == null) {
      _fetchLocation();
    }
  }

  Future<void> _fetchLocation() async {
    final value = await requestLocationPermission();
    setState(() {
      currentLocation = value;
    });
  }

  void _initializeAnimation(List<ProductModel> products) {
    for (int i = 0; i < products.length; i++) {
      _isVisible.add(false);
      Future.delayed(Duration(milliseconds: i * 80), () {
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
      appBar: AppBar(
          backgroundColor: colours(context).backgroundColor,
          surfaceTintColor: colours(context).backgroundColor,
          title: Text(Strings.productListingScreenHeading,
              style: textStyles(context).asgardTextStyle2)),
      body: BlocProvider(
        create: (context) =>
            ProductsBloc(productRepository: getIt())..add(FetchProductsEvent()),
        child: SafeArea(
          bottom: false,
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state.status == ApiStatus.noInternet) {
                return NoInternet(tryAgain: () {
                  context.read<ProductsBloc>().add((FetchProductsEvent()));
                });
              } else if (state.status == ApiStatus.loading) {
                _isVisible = [];
                return Loading(
                    lottiePath: Lotties.loadingProducts,
                    message: Strings.productsLoadingMessage,
                    lottieHeight: context.contextWidth / 2);
              } else if (state.status == ApiStatus.completed) {
                if (state.products.isNotEmpty) {
                  if (_isVisible.isEmpty) {
                    _initializeAnimation(state.products);
                  }
                  return RefreshIndicator(
                      backgroundColor: colours(context).backgroundColor,
                      color: Colours.purple,
                      onRefresh: () async {
                        context
                            .read<ProductsBloc>()
                            .add((FetchProductsEvent()));
                      },
                      child: ListView.separated(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                                image: state.products[index].imageUrl,
                                currentLocation: currentLocation,
                                title: state.products[index].title,
                                description: state.products[index].body,
                                isVisible: _isVisible[index],
                                latitude: state.products[index].coordinates[0],
                                longitude:
                                    state.products[index].coordinates[1]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Dimens.dm20.verticalSpace;
                          }));
                } else {
                  return const ZeroProducts();
                }
              } else {
                return Error(onTap: () {
                  context.read<ProductsBloc>().add((FetchProductsEvent()));
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
