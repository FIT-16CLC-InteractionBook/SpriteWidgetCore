import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class ParticleWorld extends NodeWithSize {
  ParticleSystem particleSystem;

  final ImageMap images;
  final Offset _position;
  final Size _size;
  // optional
  // TEXTURE & COLORS
  int optRedVar; // 0.0 -> 255.0
  int optGreenVar; // 0.0 -> 255.0
  int optBlueVar; // 0.0 -> 255.0
  int optAlphaVar; // 0.0 -> 255.0
  // SIZE & ROTATION
  double optStartRotation; // -360.0 -> 360.0
  double optStartRotationVar; // 0.0 -> 360.0
  double optEndRotation; // -360.0 -> 360.0
  double optEndRotationVar; // 0.0 -> 360.0
  double optStartSize; // 0.0 -> 10.0
  double optStartSizeVar; // 0.0 -> 10.0
  double optEndSize; // 0.0 -> 10.0
  double optEndSizeVar; // 0.0 -> 10.0
  bool optRotateToMovement; // 0.0 -> 10.0
  // MOVEMENT
  Offset optPosVar; // 0.0 -> 512.0
  double optTangentialAcceleration; // -500.0 -> 500.0
  double optTangentialAccelerationVar; // 0.0 -> 500.0
  double optRadialAcceleration; // -500.0 -> 500.0
  double optRadialAccelerationVar; // 0.0 -> 500.0
  double optSpeed; // 0.0 -> 250.0
  double optSpeedVar; // 0.0 -> 250.0
  double optDirection; // -360.0 -> 360.0
  double optDirectionVar; // 0.0 -> 360.0
  Offset optGravity; // -512.0 -> 512.0
  // EMISSION
  int optNumParticlesToEmit; // 0.0 -> 500.0
  double optEmissionRate; // 0.0 -> 200.0
  int optMaxParticles; // 0.0 -> 500.0
  double optLife; // 0.0 -> 10.0
  double optLifeVar; // 0.0 -> 10.0

  int _selectedTexture = 5;

  int get selectedTexture => _selectedTexture;

  set selectedTexture(int texture) {
    particleSystem.texture = new SpriteTexture(images['assets/particle-$texture.png']);
    _selectedTexture = texture;
  }


  ParticleWorld(
    this.images, 
    this._position, 
    this._size, 
    [ optRedVar, optGreenVar , optBlueVar, optAlphaVar,
     optStartRotation, optStartRotationVar, optEndRotation, optEndRotationVar, optStartSize, optStartSizeVar, optEndSize, optEndSizeVar, optRotateToMovement,
     optPosVar, optTangentialAcceleration, optTangentialAccelerationVar, optRadialAcceleration, optRadialAccelerationVar, optSpeed, optSpeedVar, optDirection, optDirectionVar, optGravity,
     optNumParticlesToEmit, optEmissionRate, optMaxParticles, optLife, optLifeVar ]) : super(_size) {
    userInteractionEnabled = true;

    SpriteTexture texture = new SpriteTexture(images['assets/particle-$_selectedTexture.png']);

    particleSystem = new ParticleSystem(
      texture,
      autoRemoveOnFinish: false,
    );
    particleSystem.position = _position;
    particleSystem.insertionOffset = Offset.zero;
    addChild(particleSystem);
  }

  @override bool handleEvent(SpriteBoxEvent event) {
    // if (event.type == PointerDownEvent || event.type == PointerMoveEvent) {
    //   particleSystem.insertionOffset = convertPointToNodeSpace(event.boxPosition) - const Offset(512.0, 512.0);
    // }

    if (event.type == PointerDownEvent) {
      particleSystem.reset();
    }

    return true;
  }
}

String saved;

final String _pDefault = '{"life":1.5,"lifeVar":1.0,"posVar":[0.0,0.0],"startSize":2.5,"startSizeVar":0.5,"endSize":0.0,"endSizeVar":0.0,"startRotation":0.0,"startRotationVar":0.0,"endRotation":0.0,"endRotationVar":0.0,"rotateToMovement":false,"direction":0.0,"directionVar":360.0,"speed":100.0,"speedVar":50.0,"radialAcceleration":0.0,"radialAccelerationVar":0.0,"tangentialAcceleration":0.0,"tangentialAccelerationVar":0.0,"maxParticles":100,"emissionRate":50.0,"colorSequence":{"colors":[4294967295,16777215],"colorStops":[0.0,1.0]},"alphaVar":0,"redVar":0,"greenVar":0,"blueVar":0,"numParticlesToEmit":0,"autoRemoveOnFinish":false,"gravity":[0.0,0.0]}';
final String _pStars = '{"life":4.7643979057591626,"lifeVar":1.0,"posVar":[412.8167539267017,376.62827225130894],"startSize":2.5,"startSizeVar":0.5,"endSize":1.6797550061610353,"endSizeVar":1.4616052517716172,"startRotation":0.0,"startRotationVar":360.0,"endRotation":0.0,"endRotationVar":360.0,"rotateToMovement":true,"direction":0.0,"directionVar":360.0,"speed":100.0,"speedVar":50.0,"radialAcceleration":0.0,"radialAccelerationVar":0.0,"tangentialAcceleration":0.0,"tangentialAccelerationVar":0.0,"maxParticles":100,"emissionRate":50.0,"colorSequence":{"colors":[4975871,4281591295,8597759],"colorStops":[0.0,0.5,1.0]},"alphaVar":0,"redVar":100,"greenVar":119,"blueVar":66,"numParticlesToEmit":0,"autoRemoveOnFinish":false,"gravity":[0.0,0.0]}';
final String _pFireworks = '{"life":0.7678881740070763,"lifeVar":2.3211166621502763,"posVar":[0.0,0.0],"startSize":1.6143099799830256,"startSizeVar":0.5,"endSize":0.8289696658468994,"endSizeVar":0.0,"startRotation":92.98428360704344,"startRotationVar":0.0,"endRotation":89.84291276382527,"endRotationVar":0.0,"rotateToMovement":true,"direction":0.0,"directionVar":360.0,"speed":181.50085928552443,"speedVar":35.776587680996414,"radialAcceleration":0.0,"radialAccelerationVar":0.0,"tangentialAcceleration":0.0,"tangentialAccelerationVar":0.0,"maxParticles":100,"emissionRate":200.0,"colorSequence":{"colors":[4288150893,4283564009,1507072],"colorStops":[0.0,0.46759255727132176,1.0]},"alphaVar":0,"redVar":4,"greenVar":91,"blueVar":158,"numParticlesToEmit":85,"autoRemoveOnFinish":false,"gravity":[0.0,50.931937172774724]}';
final String _pDisco = '{"life":1.5,"lifeVar":1.0,"posVar":[324.8027855039268,324.35602094240835],"startSize":6.937172774869113,"startSizeVar":6.849912074223862,"endSize":4.777486910994764,"endSizeVar":3.904885896213394,"startRotation":0.0,"startRotationVar":0.0,"endRotation":0.0,"endRotationVar":0.0,"rotateToMovement":true,"direction":0.0,"directionVar":360.0,"speed":100.0,"speedVar":50.0,"radialAcceleration":0.0,"radialAccelerationVar":0.0,"tangentialAcceleration":0.0,"tangentialAccelerationVar":0.0,"maxParticles":100,"emissionRate":50.0,"colorSequence":{"colors":[3778303,4284743662,4294915222,16711680],"colorStops":[0.0,0.22222222222222218,0.7384258906046551,1.0]},"alphaVar":0,"redVar":0,"greenVar":0,"blueVar":0,"numParticlesToEmit":0,"autoRemoveOnFinish":false,"gravity":[0.0,0.0]}';
final String _pFire = '{"life":1.5,"lifeVar":1.0,"posVar":[73.27049247382203,39.76263907068064],"startSize":1.2478182328309062,"startSizeVar":0.584642100708647,"endSize":1.038394149061272,"endSizeVar":0.7329842931937176,"startRotation":-90.47120418848164,"startRotationVar":0.0,"endRotation":-87.95812476991966,"endRotationVar":0.0,"rotateToMovement":true,"direction":271.4136125654451,"directionVar":38.32459774316914,"speed":39.26701570680628,"speedVar":50.0,"radialAcceleration":0.0,"radialAccelerationVar":0.0,"tangentialAcceleration":0.0,"tangentialAccelerationVar":0.0,"maxParticles":198,"emissionRate":82.89703049584841,"colorSequence":{"colors":[16639318,4294961739,4292819771,16728385],"colorStops":[0.0,0.2037036683824327,0.7060184478759767,1.0]},"alphaVar":0,"redVar":0,"greenVar":0,"blueVar":0,"numParticlesToEmit":0,"autoRemoveOnFinish":false,"gravity":[-9.828983965968234,-168.87958115183238],"blendMode":12}';
final String _pMagic = '{"life":4.2844674474905915,"lifeVar":1.0,"posVar":[62.994764397905755,62.99476439790575],"startSize":2.5,"startSizeVar":0.5,"endSize":0.0,"endSizeVar":0.0,"startRotation":0.0,"startRotationVar":0.0,"endRotation":0.0,"endRotationVar":0.0,"rotateToMovement":false,"direction":0.0,"directionVar":360.0,"speed":100.0,"speedVar":50.0,"radialAcceleration":-90.75044961499918,"radialAccelerationVar":0.0,"tangentialAcceleration":0.0,"tangentialAccelerationVar":73.2984293193717,"maxParticles":100,"emissionRate":8.551480757628434,"colorSequence":{"colors":[16777215,4294967295,4294967295,16777215],"colorStops":[0.0,0.21759255727132162,0.75,1.0]},"alphaVar":0,"redVar":103,"greenVar":112,"blueVar":0,"numParticlesToEmit":0,"autoRemoveOnFinish":false,"gravity":[0.0,0.0],"blendMode":15}';
final String _pSmoke = '{"life":2.722513089005234,"lifeVar":1.9633507853403134,"posVar":[122.41535094895283,39.76263907068064],"startSize":2.8272251308900516,"startSizeVar":1.649214659685864,"endSize":1.6841185404992225,"endSizeVar":1.2827225130890052,"startRotation":-90.47120418848164,"startRotationVar":68.79581151832463,"endRotation":-87.95812476991966,"endRotationVar":50.261775311375175,"rotateToMovement":true,"direction":271.4136125654451,"directionVar":38.32459774316914,"speed":39.26701570680628,"speedVar":50.0,"radialAcceleration":0.0,"radialAccelerationVar":0.0,"tangentialAcceleration":0.0,"tangentialAccelerationVar":0.0,"maxParticles":198,"emissionRate":38.7434554973822,"colorSequence":{"colors":[5788999,4288978837,12104615],"colorStops":[0.0,0.5046295589870878,1.0]},"alphaVar":0,"redVar":0,"greenVar":0,"blueVar":0,"numParticlesToEmit":0,"autoRemoveOnFinish":false,"gravity":[-9.828983965968234,-86.67367473821986],"blendMode":16}';

enum ParticlePresetType {
  Default,
  Stars,
  Fireworks,
  Disco,
  Fire,
  Magic,
  Smoke,
}

class ParticlePreset {
  static void updateParticles(ParticleWorld world, ParticlePresetType type) {
    switch(type) {
      case ParticlePresetType.Default:
        deserializeParticleSystem(json.decode(_pDefault), particleSystem: world.particleSystem);
        world.selectedTexture = 5;
        break;
      case ParticlePresetType.Stars:
        deserializeParticleSystem(json.decode(_pStars), particleSystem: world.particleSystem);
        world.selectedTexture = 2;
        break;
      case ParticlePresetType.Fireworks:
        deserializeParticleSystem(json.decode(_pFireworks), particleSystem: world.particleSystem);
        world.selectedTexture = 1;
        break;
      case ParticlePresetType.Disco:
        deserializeParticleSystem(json.decode(_pDisco), particleSystem: world.particleSystem);
        world.selectedTexture = 0;
        break;
      case ParticlePresetType.Fire:
        deserializeParticleSystem(json.decode(_pFire), particleSystem: world.particleSystem);
        world.selectedTexture = 5;
        break;
      case ParticlePresetType.Magic:
        deserializeParticleSystem(json.decode(_pMagic), particleSystem: world.particleSystem);
        world.selectedTexture = 5;
        break;
      case ParticlePresetType.Smoke:
        deserializeParticleSystem(json.decode(_pSmoke), particleSystem: world.particleSystem);
        world.selectedTexture = 4;
        break;
    }

    world.particleSystem.insertionOffset = Offset.zero;
    world.particleSystem.reset();
  }
}