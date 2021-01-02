import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DesignSystemDimensions extends Equatable {
  final double imageInListSize;
  final double listViewPadding;
  final double galleryTileInnerPadding;
  final double maxInteractiveViewerScale;

  const DesignSystemDimensions({
    @required this.imageInListSize,
    @required this.listViewPadding,
    @required this.galleryTileInnerPadding,
    @required this.maxInteractiveViewerScale,
  });

  @override
  List<Object> get props {
    return [
      imageInListSize,
      listViewPadding,
      galleryTileInnerPadding,
      maxInteractiveViewerScale,
    ];
  }
}
