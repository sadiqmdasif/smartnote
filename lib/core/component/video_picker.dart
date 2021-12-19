// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartnote/core/component/custom_buttom.dart';
import 'package:smartnote/core/screen/bottom_navigtor_bar/bottom_navigator.dart';
import 'package:video_player/video_player.dart';


class VideoPickerPage extends StatefulWidget {
  VideoPickerPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _VideoPickerPageState createState() => _VideoPickerPageState();
}

class _VideoPickerPageState extends State<VideoPickerPage> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      const double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }
   XFile? file;

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
     file = await _picker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 30));
      await _playVideo(file);
    } 
  }
  @override
  void initState() {
    // TODO: implement initState
        if(widget.title=="camera"){
      isVideo = true;
      _onImageButtonPressed(ImageSource.camera);
    }
    else{
      isVideo = true;
      _onImageButtonPressed(ImageSource.gallery);
    }
    super.initState();
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _previewVideo() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }


  Widget _handlePreview() {
      return _previewVideo();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }
  bool btnStatus=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Video",style: TextStyle(color: Colors.black),),
      ),
      body: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
          ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                decoration: const InputDecoration(
                labelText: 'Enter your Captions',
                isCollapsed: true
              ),
              ),
              ),
              SizedBox(
                height: 500,
                child: FutureBuilder<void>(
                    future: retrieveLostData(),
                    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Text(
                            'You have not yet picked an video.',
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.done:
                          return _handlePreview();
                        default:
                          if (snapshot.hasError) {
                            return Text(
                              'Pick image/video error: ${snapshot.error}}',
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return const Text(
                              'You have not yet picked an video.',
                              textAlign: TextAlign.center,
                            );
                          }
                      }
                    },
                  ),
              ),

              SizedBox(
                width: 200,
                child: CustomButton.small(
                  showProgressIndicator: btnStatus,
                  onPressed: ()async{
                    setState(() {
                    btnStatus=true;
                    });
                     final snackBar = SnackBar(
            content: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Text('Succesfully Upload'),
              ],
            ),
          ),
          backgroundColor: Colors.green.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
          width: 300,
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          duration: Duration(seconds: 2),
        );
       await Future.delayed(new Duration(seconds: 2), (){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
           setState(() {
           btnStatus=false;
         });
       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavBar()), (route) => false);
       });
              await Future.delayed(new Duration(seconds: 3), (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavBar()), (route) => false);
       });
                  },
                  text: "Post",
                ),
              )
            ],
          )
          : _handlePreview(),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container(
        height: 600,
      );
    }
  }
}