//
//  PPAnimation.h
//  Pepper
//
//  Created by Andrew Wang on 6/10/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"
#import "PPSpriteFrameInfo.h"
#import "PPSprite.h"

@interface PPAnimationElement : PPObject
@property (nonatomic,strong) PPStageElement *stageElement;
@property (nonatomic) float timeElapsed;
@property (nonatomic) float duration;
@property (nonatomic) BOOL isRunning;   // PPAnimationController manages this
@property (nonatomic) BOOL hasFinished;
@property (nonatomic) BOOL isPaused;
@property (nonatomic,strong) PPAnimationElement *next;
-(id)initWithStageElement:(PPStageElement *)element duration:(float)duration;
-(void)start;
-(void)finish;
@end

@interface PPAnimationMoveTo : PPAnimationElement
@property (nonatomic) CGPoint startPosition;
@property (nonatomic) CGPoint destPosition;
-(id)initWithStageElement:(PPStageElement *)element dest:(CGPoint)destPosition duration:(float)duration;
+(PPAnimationMoveTo *)moveToWithStageElement:(PPStageElement *)element dest:(CGPoint)destPosition duration:(float)duration;
@end

@interface PPAnimationScaleTo : PPAnimationElement
@property (nonatomic) CGPoint startScale;
@property (nonatomic) CGPoint destScale;
-(id)initWithStageElement:(PPStageElement *)element dest:(CGPoint)destScale duration:(float)duration;
+(PPAnimationScaleTo *)scaletoWithStageElement:(PPStageElement *)element dest:(CGPoint)destScale duration:(float)duration;
@end

@interface PPAnimationFrameTo : PPAnimationElement
@property (nonatomic) PPSpriteFrameInfo *destFrame;
-(id)initWithSprite:(PPSprite *)sprite dest:(PPSpriteFrameInfo *)frame duration:(float)duration;
+(PPAnimationFrameTo *)frameToWithSprite:(PPSprite *)sprite dest:(PPSpriteFrameInfo *)frame duration:(float)duration;
@end

@interface PPAnimationPause : PPAnimationElement
+(PPAnimationPause *)pauseWithElement:(PPStageElement *)element duration:(float)duration;
@end

/** Manages animation of scene elements given for it to manage */
@interface PPAnimationController : PPObject
{
    NSMutableArray *animations;
}

-(void)stageElement:(PPStageElement *)element moveTo:(CGPoint)pos duration:(float)duration;
-(void)stageElement:(PPStageElement *)element scaleTo:(CGPoint)scale duration:(float)duration;
-(void)sprite:(PPSprite *)sprite frameTo:(PPSpriteFrameInfo *)frame duration:(float)duration;
-(void)stageElement:(PPStageElement *)element pause:(float)duration;
-(void)addAnimation:(PPAnimationElement *)element;
-(void)addAnimationSequence:(NSArray *)sequence repeat:(BOOL)repeat;
-(void)pauseAnimation:(PPAnimationElement *)element;
-(void)pauseAllAnimations;
-(void)resumeAnimation:(PPAnimationElement *)element;
-(void)resumeAllAnimations;
@end
