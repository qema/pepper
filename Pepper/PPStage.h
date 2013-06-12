//
//  PPStage.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPLayer.h"
#import "PPCamera.h"
#import "PPAnimation.h"

/** Manages and draws a stack of PPLayers
 */
@interface PPStage : PPObject

@property (nonatomic) CGRect frame;
@property (nonatomic,strong) PPCamera *camera;
@property (nonatomic,strong) NSMutableArray *layers;
@property (nonatomic,strong) PPAnimationController *animationController;

-(id)initWithFrame:(CGRect)frame;
-(void)draw;
/** @name Events */
/** Called when stage finishes loading */
-(void)stageDidLoad;

/** @name Layer adding/removing */
/** Adds a layer to the scene graph
 @param layer The layer to add
 */
-(void)addLayer:(PPLayer *)layer;
/** Removes a layer from the scene graph
 @param index The layer index to remove (0 is first layer you added, 1 is 2nd, etc)
 */
-(void)removeLayerAtIndex:(int)index;
/** Removes a layer from the scene graph
 @param tag The tag of the layer to remove
 */
-(void)removeLayerWithTag:(int)tag;

/** @name Accessing layers */
/** Get layer by tag
 @param tag Tag of layer to retrieve; retrieves first one it finds.
 */
-(PPLayer *)layerWithTag:(int)tag;
/** Get layer by index
 @param index Index of layer to retrieve
 */
-(PPLayer *)layerWithIndex:(int)index;
@end
