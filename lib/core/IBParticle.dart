import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class IBParticle extends NodeWithSize {
  ParticleSystem particleSystem;

  final ImageMap images;
  final Offset _position;
  final Size _size;
  final String particleData;
  final String preset;

  // optional
  // TEXTURE & COLORS
  // int optRedVar; // 0.0 -> 255.0
  // int optGreenVar; // 0.0 -> 255.0
  // int optBlueVar; // 0.0 -> 255.0
  // int optAlphaVar; // 0.0 -> 255.0
  // // SIZE & ROTATION
  // double optStartRotation; // -360.0 -> 360.0
  // double optStartRotationVar; // 0.0 -> 360.0
  // double optEndRotation; // -360.0 -> 360.0
  // double optEndRotationVar; // 0.0 -> 360.0
  // double optStartSize; // 0.0 -> 10.0
  // double optStartSizeVar; // 0.0 -> 10.0
  // double optEndSize; // 0.0 -> 10.0
  // double optEndSizeVar; // 0.0 -> 10.0
  // bool optRotateToMovement; // 0.0 -> 10.0
  // // MOVEMENT
  // Offset optPosVar; // 0.0 -> 512.0
  // double optTangentialAcceleration; // -500.0 -> 500.0
  // double optTangentialAccelerationVar; // 0.0 -> 500.0
  // double optRadialAcceleration; // -500.0 -> 500.0
  // double optRadialAccelerationVar; // 0.0 -> 500.0
  // double optSpeed; // 0.0 -> 250.0
  // double optSpeedVar; // 0.0 -> 250.0
  // double optDirection; // -360.0 -> 360.0
  // double optDirectionVar; // 0.0 -> 360.0
  // Offset optGravity; // -512.0 -> 512.0
  // // EMISSION
  // int optNumParticlesToEmit; // 0.0 -> 500.0
  // double optEmissionRate; // 0.0 -> 200.0
  // int optMaxParticles; // 0.0 -> 500.0
  // double optLife; // 0.0 -> 10.0
  // double optLifeVar; // 0.0 -> 10.0

  IBParticle(
      this.images, this.preset, this._position, this._size, this.particleData)
      : super(_size) {
    SpriteTexture texture = new SpriteTexture(images['assets/particle-5.png']);
    particleSystem = new ParticleSystem(
      texture,
      autoRemoveOnFinish: false,
    );
    this.position = this._position;
    particleSystem.position = Offset(this._position.dx + this._size.width / 2,
        this._position.dy + this._size.height / 2);
    particleSystem.insertionOffset = Offset.zero;
    userInteractionEnabled = true;
    addChild(particleSystem);
    deserializeParticleSystem(json.decode(this.particleData),
        particleSystem: particleSystem);
  }

//   @override
//   bool isPointInside(Offset point) {
//     // Offset postionParticle = particleSystem.position;
//     // if (point.dx >= postionParticle.dx &&
//     //     point.dx <= _size.width + postionParticle.dx &&
//     //     point.dy <= _size.height + postionParticle.dy &&
//     //     point.dy >= postionParticle.dy) return true;

//     // return false;
//     return true;
//   }

//   @override
//   bool handleEvent(SpriteBoxEvent event) {
//     // if (event.type == PointerDownEvent || event.type == PointerMoveEvent) {
//     //   particleSystem.insertionOffset = convertPointToNodeSpace(event.boxPosition) - const Offset(512.0, 512.0);
//     // }

//     if (event.type == PointerDownEvent) {
//       print("cac");
//       particleSystem.reset();
//     }

//     return true;
//   }
// }
}
