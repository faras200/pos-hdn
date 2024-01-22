import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_hdn/core/components/spaces.dart';
import 'package:pos_hdn/core/constants/variabels.dart';
import 'package:pos_hdn/core/extensions/int_ext.dart';
import 'package:pos_hdn/data/models/response/product_response_model.dart';

class ItemProductCard extends StatelessWidget {
  final Product data;
  final EdgeInsetsGeometry? padding;

  const ItemProductCard({
    super.key,
    required this.data,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          margin: padding,
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xFFC7D0EB)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: CachedNetworkImage(
                  width: 66,
                  height: 66,
                  fit: BoxFit.cover,
                  imageUrl: "${Variables.imageBaseUrl}${data.image}",
                  placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.food_bank_outlined,
                    size: 46.0,
                  ),
                ),
              ),
              const SpaceWidth(24.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 120.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            data.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
