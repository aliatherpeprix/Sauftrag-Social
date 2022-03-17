// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:sauftrag/app/locator.dart';
// import 'package:sauftrag/viewModels/main_view_model.dart';
// import 'package:stacked/stacked.dart';
//
// class CommentZoomedImage extends StatefulWidget {
//
//   final int? index;
//
//   const CommentZoomedImage({Key? key, this.index}) : super(key: key);
//
//   @override
//   _CommentZoomedImageState createState() => _CommentZoomedImageState();
// }
//
// class _CommentZoomedImageState extends State<CommentZoomedImage> {
//
//   PageController pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<MainViewModel>.reactive(
//       builder: (context, model, child) {
//         return Scaffold(
//           backgroundColor: Colors.black,
//           body: SafeArea(
//             child: Center(
//               child: Container(
//                 width: double.infinity,
//                 child: PhotoViewGallery.builder(
//                   itemCount: model.reviewImagesList[widget.index!].Review_image!.length,
//                   pageController: pageController,
//                   //pageController: pageController,
//                   builder: (context, index) {
//                     return  PhotoViewGalleryPageOptions(
//                       imageProvider: CachedNetworkImageProvider(model.reviewImagesList[index].Review_image!),
//                       initialScale: PhotoViewComputedScale.contained * 1,
//                       //heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       viewModelBuilder: () => locator<MainViewModel>(),
//       onModelReady: (model){
//         Future.delayed(Duration(milliseconds: 100)).then((value)async{
//           pageController.jumpToPage(widget.index!);
//         });
//       },
//       disposeViewModel: false,
//     );
//   }
// }