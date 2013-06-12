//
//  PPAnimationController.m
//  Pepper
//
//  Created by Andrew Wang on 6/10/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPAnimationController.h"

@implementation PPAnimationElement
-(id)initWithStageElement:(PPStageElement *)element duration:(float)duration
{
    if (self=[super init]) {
        _stageElement = element;
        _duration = duration;
    }
    return self;
}
@end

@implementation PPAnimationMoveTo
-(id)initWithStageElement:(PPStageElement *)element dest:(CGPoint)destPosition duration:(float)duration
{
    if (self=[super initWithStageElement:element duration:duration]) {
        _startPosition = self.stageElement.position;
        _destPosition = destPosition;
    }
    return self;
}
-(void)update:(float)delta
{
    self.timeElapsed += delta;
    self.stageElement.position = CGPointMake(self.startPosition.x + self.timeElapsed/self.duration * (self.destPosition.x - self.startPosition.x), self.startPosition.y + self.timeElapsed/self.duration * (self.destPosition.y - self.startPosition.y));
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

-(void)stageElement:(PPStageElement *)element moveTo:(CGPoint)pos duration:(float)duration
{
    PPAnimationMoveTo *moveTo = [[PPAnimationMoveTo alloc] init];
    [animations addObject:moveTo];
}

-(void)update:(float)delta
{
    for (PPAnimationElement *animation in animations) {
        [animation update:delta];
    }
}
@end
