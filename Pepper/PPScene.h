//
//  PPScene.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPLayer.h"

@interface PPScene : PPNode

@property (nonatomic,strong) NSMutableArray *layers;

-(void)addLayer:(PPLayer *)layer;
-(void)draw;
@end
