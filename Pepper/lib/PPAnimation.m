//
//  PPAnimation.m
//  Pepper
//
//  Created by Andrew Wang on 6/10/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPAnimation.h"

// PPAnimationElement
@implementation PPAnimationElement
-(id)initWithStageElement:(PPStageElement *)element duration:(float)duration
{
    if (self=[super init]) {
        _stageElement = element;
        _duration = duration;
        _isPaused = NO;
    }
    return self;
}
-(void)finish
{
    self.hasFinished = YES;
}
-(void)start
{
    self.hasFinished = NO;
    self.timeElapsed = 0;
}
-(void)update:(float)delta
{
    if (!self.isPaused) {
        self.timeElapsed += delta;
        if (self.timeElapsed > self.duration) {
            self.timeElapsed = self.duration;
            [self finish];
        }
    }
}
@end

// PPAnimationMoveTo
@implementation PPAnimationMoveTo
+(PPAnimationMoveTo *)moveToWithStageElement:(PPStageElement *)element destPosition:(CGPoint)destPosition duration:(float)duration
{
    return [[PPAnimationMoveTo alloc] initWithStageElement:element destPosition:destPosition duration:duration];
}
-(id)initWithStageElement:(PPStageElement *)element destPosition:(CGPoint)destPosition duration:(float)duration
{
    if (self=[super initWithStageElement:element duration:duration]) {
        _destPosition = destPosition;
    }
    return self;
}
-(void)start
{
    [super start];
    self.startPosition = self.stageElement.position;
}
-(void)update:(float)delta
{
    [super update:delta];
    self.stageElement.position = CGPointMake(self.startPosition.x + self.timeElapsed/self.duration * (self.destPosition.x - self.startPosition.x), self.startPosition.y + self.timeElapsed/self.duration * (self.destPosition.y - self.startPosition.y));
}
@end

// PPAnimationScaleTo
@implementation PPAnimationScaleTo
+(PPAnimationScaleTo *)scaletoWithStageElement:(PPStageElement *)element destScale:(CGPoint)destScale duration:(float)duration
{
    return [[PPAnimationScaleTo alloc] initWithStageElement:element destScale:destScale duration:duration];
}
-(id)initWithStageElement:(PPStageElement *)element destScale:(CGPoint)destScale duration:(float)duration
{
    if (self=[super initWithStageElement:element duration:duration]) {
        _destScale = destScale;
    }
    return self;
}
-(void)start
{
    [super start];
    self.startScale = self.stageElement.scale;
}
-(void)update:(float)delta
{
    [super update:delta];
    CGPoint scale;
    scale.x = self.startScale.x + self.timeElapsed/self.duration * (self.destScale.x - self.startScale.x);
    scale.y = self.startScale.y + self.timeElapsed/self.duration * (self.destScale.y - self.startScale.y);
    self.stageElement.scale = scale;
}
@end

// PPAnimationFrameTo
@implementation PPAnimationFrameTo
+(PPAnimationFrameTo *)frameToWithSprite:(PPSprite *)sprite destFrame:(PPSpriteFrameInfo *)frame duration:(float)duration
{
    return [[PPAnimationFrameTo alloc] initWithSprite:sprite destFrame:frame duration:duration];
}
-(id)initWithSprite:(PPSprite *)sprite destFrame:(PPSpriteFrameInfo *)frame duration:(float)duration
{
    if (self=[super initWithStageElement:sprite duration:duration]) {
        _destFrame = frame;
    }
    return self;
}
-(void)update:(float)delta
{
    [super update:delta];
    if (self.hasFinished) ((PPSprite *)self.stageElement).frameInfo = self.destFrame;
}
@end

// PPAnimationRotateTo
@implementation PPAnimationRotateTo
+(PPAnimationRotateTo *)rotateToWithStageElement:(PPStageElement *)element destRotation:(float)rotation duration:(float)duration
{
    return [[PPAnimationRotateTo alloc] initWithStageElement:element destRotation:rotation duration:duration];
}
-(id)initWithStageElement:(PPStageElement *)element destRotation:(float)destRotation duration:(float)duration
{
    if (self=[super initWithStageElement:element duration:duration]) {
        _destRotation = destRotation;
    }
    return self;
}
-(void)start
{
    [super start];
    self.startRotation = self.stageElement.rotation;
}
-(void)update:(float)delta
{
    [super update:delta];
    self.stageElement.rotation = self.startRotation + self.timeElapsed / self.duration * (self.destRotation-self.startRotation);
}
@end

// PPAnimationPause
@implementation PPAnimationPause
+(PPAnimationPause *)pauseWithElement:(PPStageElement *)element duration:(float)duration
{
    return [[PPAnimationPause alloc] initWithStageElement:element duration:duration];
}
@end

@implementation PPAnimationController

-(id)init
{
    if (self = [super init]) {
        animations = [[NSMutableArray alloc] initWithCapacity:16];
    }
    return self;
}

-(void)addAnimation:(PPAnimationElement *)element
{
    [animations addObject:element];
}

-(void)runAnimation:(PPAnimationElement *)element
{
    [element start];
    element.isRunning = YES;
}

-(void)stageElement:(PPStageElement *)element moveTo:(CGPoint)pos duration:(float)duration
{
    PPAnimationMoveTo *moveTo = [[PPAnimationMoveTo alloc] initWithStageElement:element destPosition:pos duration:duration];
    [self addAnimation:moveTo];
    [self runAnimation:moveTo];
}

-(void)stageElement:(PPStageElement *)element scaleTo:(CGPoint)scale duration:(float)duration
{
    PPAnimationScaleTo *scaleTo = [[PPAnimationScaleTo alloc] initWithStageElement:element destScale:scale duration:duration];
    [self addAnimation:scaleTo];
    [self runAnimation:scaleTo];
}

-(void)sprite:(PPSprite *)sprite frameTo:(PPSpriteFrameInfo *)frame duration:(float)duration
{
    PPAnimationFrameTo *frameTo = [[PPAnimationFrameTo alloc] initWithSprite:sprite destFrame:frame duration:duration];
    [self addAnimation:frameTo];
    [self runAnimation:frameTo];
}

-(void)stageElement:(PPStageElement *)element rotateTo:(float)rotation duration:(float)duration
{
    PPAnimationRotateTo *rotateTo = [[PPAnimationRotateTo alloc] initWithStageElement:element destRotation:rotation duration:duration];
    [self addAnimation:rotateTo];
    [self runAnimation:rotateTo];
}

-(void)stageElement:(PPStageElement *)element pause:(float)duration
{
    PPAnimationPause *pause = [[PPAnimationPause alloc] initWithStageElement:element duration:duration];
    [self addAnimation:pause];
    [self runAnimation:pause];
}

-(void)addAnimationSequence:(NSArray *)sequence repeat:(BOOL)repeat
{
    int numberOfElements = [sequence count];
    for (int i = 0;i<numberOfElements-1;i++) {
        PPAnimationElement *animation = sequence[i];
        PPAnimationElement *next = sequence[i+1];
        animation.next = next;
        [self addAnimation:animation];
    }
    PPAnimationElement *lastAnimation = sequence[numberOfElements-1];
    if (repeat) {
        lastAnimation.next = sequence[0];
    }
    [self addAnimation:lastAnimation];
    [self runAnimation:sequence[0]];
}

-(void)update:(float)delta
{
    NSMutableIndexSet *finishedAnimations = [NSMutableIndexSet indexSet];
    for (int i=0;i<[animations count];i++) {
        PPAnimationElement *animation = animations[i];
        if (animation.isRunning) {
            [animation update:delta];
            if (animation.hasFinished) {
                animation.isRunning = NO;
                [self runAnimation:animation.next];
            }
        }
    }
    [animations removeObjectsAtIndexes:finishedAnimations];
}

-(void)pauseAnimation:(PPAnimationElement *)element
{
    element.isPaused = YES;
}

-(void)pauseAllAnimations
{
    for (PPAnimationElement *element in animations) {
        [self pauseAnimation:element];
    }
}

-(void)resumeAnimation:(PPAnimationElement *)element
{
    element.isPaused = NO;
}

-(void)resumeAllAnimations
{
    for (PPAnimationElement *element in animations) {
        [self resumeAnimation:element];
    }
}
@end
