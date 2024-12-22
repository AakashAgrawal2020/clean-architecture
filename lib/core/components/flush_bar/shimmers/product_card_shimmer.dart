import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget productCardShimmer(BuildContext context) {
  return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Container(
      color: Colours.white,
      child: Column(
        children: [
          Dimens.dm20.verticalSpace,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: Colours.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0.0, 8.0),
                      blurRadius: 16.0)
                ],
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 32.0),
              child: Shimmer.fromColors(
                baseColor: Colours.ng100,
                highlightColor: Colours.ng50,
                direction: ShimmerDirection.ltr,
                enabled: true,
                period: const Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 52.0),
                      child: Row(
                        children: [
                          Container(
                              height: 44.0,
                              width: 44.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colours.ng100)),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 24.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100)),
                              const SizedBox(height: 8.0),
                              Container(
                                  height: 16.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: Row(
                        children: [
                          Container(
                              height: 44.0,
                              width: 44.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colours.ng100)),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 24.0,
                                  width: 160.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100)),
                              const SizedBox(height: 8.0),
                              Container(
                                  height: 16.0,
                                  width: 110.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: 32.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colours.ng100))
                  ],
                ),
              ),
            ),
          ),
          Dimens.dm20.verticalSpace,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: Colours.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0.0, 8.0),
                      blurRadius: 16.0)
                ],
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 32.0),
              child: Shimmer.fromColors(
                baseColor: Colours.ng100,
                highlightColor: Colours.ng50,
                direction: ShimmerDirection.ltr,
                enabled: true,
                period: const Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 52.0),
                      child: Row(
                        children: [
                          Container(
                              height: 44.0,
                              width: 44.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colours.ng100)),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 24.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100)),
                              const SizedBox(height: 8.0),
                              Container(
                                  height: 16.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: Row(
                        children: [
                          Container(
                              height: 44.0,
                              width: 44.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colours.ng100)),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 24.0,
                                  width: 160.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100)),
                              const SizedBox(height: 8.0),
                              Container(
                                  height: 16.0,
                                  width: 110.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: Colours.ng100))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: 32.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colours.ng100))
                  ],
                ),
              ),
            ),
          ),
          Dimens.dm20.verticalSpace,
        ],
      ),
    ),
  );
}
