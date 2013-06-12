//
//  PPAnimationController.h
//  Pepper
//
//  Created by Andrew Wang on 6/10/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"

@interface PPAnimationElement : PPObject
@property (nonatomic,retain) PPStageElement *stageElement;
@property (nonatomic) float timeElapsed;
@property (nonatomic) float duration;
-(id)initWithStageElement:(PPStageElement *)element duration:(float)duration;
@end

@interface PPAnimationMoveTo : PPAnimationElement
@property (nonatomic) CGPoint startPosition;
@property (nonatomic) CGPoint destPosition;
-(id)initWithStageElement:(PPStageElement *)element dest:(CGPoint)destPosition duration:(float)duration;
@end

/** Manages interpolation of points given for it to manage */
@interface PPAnimationController : PPObject
{
    NSMutableArray *animations;
}

-(void)stageElement:(PPStageElement *)element moveTo:(CGPoint)pos duration:(float)duration;
@end
