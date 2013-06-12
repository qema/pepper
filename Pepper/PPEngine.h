//
//  PPEngine.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStage.h"
#import <GLKit/GLKit.h>

/** Controls the Pepper stage and game state
 */
@interface PPEngine : PPObject <GLKViewControllerDelegate>
{
}

@property (nonatomic,retain) PPStage *stage;

/**
 Start engine
 @param stage The stage the engine will manage
 */
-(void)runWithStage:(PPStage *)stage;
-(void)renderStage;

@end
