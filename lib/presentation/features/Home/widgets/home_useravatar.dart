import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/manager/app_imagepicker.dart';
import 'package:login_signin/core/providers/app_drawerStateManager.dart';
import 'package:provider/provider.dart';

class Useravatar extends StatefulWidget {
  const Useravatar({super.key});

  @override
  State<Useravatar> createState() => _UseravatarState();
}

class _UseravatarState extends State<Useravatar> {
  Future<void> _selectImage(BuildContext context) async {
    final XFile img = await pickImage(ImageSource.gallery);
    final Uint8List imgBytes = await img.readAsBytes();
    Provider.of<DrawerStateInfo>(
      context,
      listen: false,
    ).setAvatarImage(imgBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerStateInfo>(
      builder: (context, state, _) {
        return Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: state.avatarImage != null
                    ? MemoryImage(state.avatarImage!)
                    : const AssetImage(AppAssets.defultAvatar) as ImageProvider,
              ),
              Positioned(
                bottom: -10,
                left: 70,
                child: IconButton(
                  onPressed: () => _selectImage(context),
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
