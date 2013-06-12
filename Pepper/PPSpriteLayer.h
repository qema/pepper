//
//  PPSpriteLayer.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPLayer.h"
#import "PPSpritesheet.h"
#import "PPSprite.h"

/** Manages/draws a batch of sprites with the same spritesheet */
@interface PPSpriteLayer : PPLayer
{
    int numSprites;
}

/** The sprites' spritesheet */
@property (nonatomic,strong) PPSpritesheet *spritesheet;
@property (nonatomic,strong) NSMutableArray *sprites;

/** @name Initializing a sprite layer */
/** Initializing with a spritesheet
 @param frame Frame of layer view
 @param spritesheet The spritesheet to use
 */
-(id)initWithFrame:(CGRect)frame spritesheet:(PPSpritesheet *)spritesheet;

/** @name Sprite management */
/** Add a sprite
 @param sprite The sprite to add
 @return The index of the sprite
 */
-(int)addSprite:(PPSprite *)sprite;
/** Remove a sprite with index
 @param index The sprite index to remove
 */
-(void)removeSpriteAtIndex:(int)index;
/** Remove all sprites with tag
 @param tag The tag to use; if any sprite has this tag, it will be removed
 */
-(void)removeSpriteWithTag:(int)tag;
/** Remove all sprites
 */
-(void)removeAllSprites;
@end
