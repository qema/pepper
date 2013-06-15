//
//  TestStage.m
//  Pepper
//
//  Created by Andrew Wang on 6/4/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "TestStage.h"

@implementation TestStage

-(void)stageDidLoad
{
    spritesheet = [[PPSpritesheet alloc] initWithFile:@"test.plist" scale:2];
    spriteLayer = [[PPSpriteLayer alloc] initWithFrame:self.frame spritesheet:spritesheet];
    sprite = [spritesheet createSpriteWithFrame:@"player-r" position:CGPointMake(20, 20)];
    sprite.anchor = CGPointZero;
    enemySprite = [spritesheet createSpriteWithFrame:@"1-d" position:CGPointMake(0,0)];
   // enemySprite.anchor = CGPointZero;
    [spriteLayer addSprite:sprite];
    [spriteLayer addSprite:enemySprite];
    [self.animationController addAnimationSequence:
     [NSArray arrayWithObjects:[PPAnimationMoveTo moveToWithStageElement:sprite destPosition:CGPointMake(300, 40) duration:2],
      [PPAnimationFrameTo frameToWithSprite:sprite destFrame:[spritesheet frameInfoForName:@"player-l"] duration:0],
      [PPAnimationMoveTo moveToWithStageElement:sprite destPosition:CGPointMake(20, 20) duration:2],
      [PPAnimationFrameTo frameToWithSprite:sprite destFrame:[spritesheet frameInfoForName:@"player-r"] duration:0],nil] repeat:YES];
    newSprite = [spritesheet createSpriteWithFrame:@"player-r" position:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [spriteLayer addSprite:newSprite];
    
    tileMap = [[PPTileMap alloc] initWithFile:@"desert.tmx" tilesetScale:1];
    tileLayer = [[PPTileLayer alloc] initWithFrame:self.frame tileMap:tileMap];
    [self addLayer:tileLayer];
    [self addLayer:spriteLayer];
    //self.camera.position = CGPointMake(tileMap.size.width/2, tileMap.size.height/2);
    tileLayer.position = CGPointMake(0,0);
    
    //spriteLayer.position = CGPointMake(0, 0);
}

-(void)update:(float)delta
{
    newSprite.position = self.camera.position;
    [super update:delta];
    static int timer=0;
    timer++;
    if (timer%10 == 5) {
        if ([sprite.frameInfo.name isEqualToString:@"player-r"])
            [spritesheet sprite:sprite setFrame:@"player-rw"];
        else
            [spritesheet sprite:sprite setFrame:@"player-lw"];
    } else if (timer%10 == 0) {
        if ([sprite.frameInfo.name isEqualToString:@"player-rw"])
            [spritesheet sprite:sprite setFrame:@"player-r"];
        else
            [spritesheet sprite:sprite setFrame:@"player-l"];
    }
}
@end
