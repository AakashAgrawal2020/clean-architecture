import 'package:clean_architecture/core/components/error.dart';
import 'package:clean_architecture/core/components/no_internet.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/animations.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/location_permission_handler.dart';
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
    with StyleExtension, WidgetsBindingObserver, TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _animationControllers = [];
    if (currentLocation == null) {
      _fetchLocation();
    }
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (var controller in _animationControllers) {
      controller.dispose();
    }
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
                _animationControllers = [];
                _animationControllers =
                    AnimationUtils.createStaggeredControllers(
                        vsync: this,
                        itemCount: 1,
                        itemDuration: 500,
                        delayDuration: 150);
                return AnimatedBuilder(
                  animation: _animationControllers[0],
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _animationControllers[0]
                          .drive(CurveTween(curve: Curves.easeIn)),
                      child: Loading(
                          lottiePath: Lotties.loadingProducts,
                          message: Strings.productsLoadingMessage,
                          lottieHeight: context.contextWidth / 2),
                    );
                  },
                );
              } else if (state.status == ApiStatus.completed) {
                if (state.products.isNotEmpty) {
                  _animationControllers = [];
                  _animationControllers =
                      AnimationUtils.createStaggeredControllers(
                          vsync: this,
                          itemCount: state.products.length,
                          itemDuration: 500,
                          delayDuration: 150);

                  return RefreshIndicator(
                      backgroundColor: colours(context).backgroundColor,
                      color: Colours.purple,
                      onRefresh: () async {
                        context
                            .read<ProductsBloc>()
                            .add((FetchProductsEvent()));
                      },
                      child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                                animation: _animationControllers[index],
                                builder: (context, child) {
                                  return SlideTransition(
                                      position: Tween<Offset>(
                                              begin: const Offset(-1.0, 0.2),
                                              end: Offset.zero)
                                          .animate(CurvedAnimation(
                                              parent:
                                                  _animationControllers[index],
                                              curve: Curves.decelerate)),
                                      child: FadeTransition(
                                        opacity: _animationControllers[index]
                                            .drive(CurveTween(
                                                curve: Curves.easeIn)),
                                        child: ProductCard(
                                            image:
                                                state.products[index].imageUrl,
                                            currentLocation: currentLocation,
                                            title: state.products[index].title,
                                            description:
                                                state.products[index].body,
                                            latitude: state
                                                .products[index].coordinates[0],
                                            longitude: state.products[index]
                                                .coordinates[1]),
                                      ));
                                });
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
