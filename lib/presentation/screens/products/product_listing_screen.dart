import 'package:clean_architecture/core/components/error.dart';
import 'package:clean_architecture/core/components/no_internet.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/utils/animations_util.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:clean_architecture/core/utils/permissions_util.dart';
import 'package:clean_architecture/main.dart';
import 'package:clean_architecture/presentation/screens/products/bloc/products_bloc.dart';
import 'package:clean_architecture/presentation/screens/products/widgets/google_map_products.dart';
import 'package:clean_architecture/presentation/screens/products/widgets/page_loading.dart';
import 'package:clean_architecture/presentation/screens/products/widgets/product_card.dart';
import 'package:clean_architecture/presentation/screens/products/widgets/zero_products.dart';
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
  late AnimationController _googleMapAnimationController;

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
    _googleMapAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours(context).backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(Dimens.dm60),
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colours.purple, Colours.purple1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimens.dm16),
                      bottomRight: Radius.circular(Dimens.dm16))),
              child: AppBar(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colours.white,
                  actions: [
                    Padding(
                        padding: const EdgeInsets.only(right: Dimens.dm6),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.shield_moon,
                                color: Colours.white, size: Dimens.dm30)))
                  ],
                  shadowColor: Colours.black.withOpacity(0.5),
                  title: Text(Strings.productListingScreenHeading,
                      style: TextStyles.textStyle3),
                  centerTitle: true,
                  elevation: 5))),
      body: BlocProvider(
        create: (context) =>
            ProductsBloc(productRepository: getIt())..add(FetchProductsEvent()),
        child: SafeArea(
          bottom: false,
          child: BlocBuilder<ProductsBloc, ProductsState>(
            buildWhen: (current, previous) {
              return current.status != previous.status;
            },
            builder: (context, state) {
              if (state.status == ApiStatus.noInternet) {
                return NoInternet(tryAgain: () {
                  context.read<ProductsBloc>().add(FetchProductsEvent());
                });
              } else if (state.status == ApiStatus.loading) {
                _animationControllers = [];
                _animationControllers = AnimationsUtil.createControllers(
                    vsync: this,
                    itemCount: 1,
                    autoPlay: true,
                    itemDuration: 500,
                    delayDuration: 150);
                return Loading(
                    animationController: _animationControllers[0],
                    lottiePath: Lotties.loadingProducts,
                    message: Strings.productsLoadingMessage,
                    lottieHeight: context.contextWidth / 2);
              } else if (state.status == ApiStatus.completed) {
                if (state.products.isNotEmpty) {
                  _animationControllers = [];
                  _animationControllers = AnimationsUtil.createControllers(
                      vsync: this,
                      autoPlay: true,
                      itemCount: state.products.length,
                      itemDuration: 500,
                      delayDuration: 150);
                  _googleMapAnimationController =
                      AnimationsUtil.createController(
                          vsync: this, autoPlay: true, itemDuration: 750);
                  return RefreshIndicator(
                    backgroundColor: colours(context).backgroundColor,
                    color: Colours.purple,
                    onRefresh: () async {
                      context.read<ProductsBloc>().add(FetchProductsEvent());
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                            child: GoogleMapProducts(
                                products: state.products,
                                animationController:
                                    _googleMapAnimationController)),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: state.products.length,
                              (context, index) {
                            return ProductCard(
                                currentLocation: currentLocation,
                                animationController:
                                    _animationControllers[index],
                                product: state.products[index]);
                          }),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const ZeroProducts();
                }
              } else {
                return Error(onTap: () {
                  context.read<ProductsBloc>().add(FetchProductsEvent());
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
