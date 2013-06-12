//
//  PPViewController.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "PPEngine.h"

/** Manages the Pepper game view
 
 To use, subclass a PPViewController. In viewDidLoad, initialize a stage object and call engine runWithStage:
 */
@interface PPViewController : GLKViewController <GLKViewDelegate>
{
    EAGLContext *glContext;
}
/** The Pepper engine. */
@property (nonatomic,retain) PPEngine *engine;
/** Use this instead of self.view.frame!! */
-(CGRect)normalizedFrame;
@end
