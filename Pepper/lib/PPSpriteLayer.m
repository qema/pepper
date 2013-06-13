//
//  PPSpriteLayer.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPSpriteLayer.h"
#import "PPSprite.h"
#import "ppConstants.h"

@implementation PPSpriteLayer

-(id)initWithFrame:(CGRect)frame spritesheet:(PPSpritesheet *)spritesheet
{
    if (self=[super initWithFrame:frame]) {
        _spritesheet = spritesheet;
        self.shader.texture2d0.name = _spritesheet.texture.name;
        //self.shader.texture2d0.envMode = GLKTextureEnvModeDecal;
        self.shader.texture2d0.enabled = YES;
        
        self.sprites = [[NSMutableArray alloc] initWithCapacity:16];
        numSprites = 0;
    }
    return self;
}

-(int)addSprite:(PPSprite *)sprite
{
    [self.sprites addObject:sprite];
    int index = numSprites;
    numSprites++;
    return index;
}

-(void)removeSpriteAtIndex:(int)index
{
    [self.sprites removeObjectAtIndex:index];
}

-(void)removeSpriteWithTag:(int)tag
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i=0;i<[self.sprites count];i++) {
        if (((PPSprite *)self.sprites[i]).tag == tag)
            [indexSet addIndex:i];
    }
    [self.sprites removeObjectsAtIndexes:indexSet];
    return;
}

-(void)removeAllSprites
{
    [self.sprites removeAllObjects];
}

-(void)draw
{
    [super draw];
    GLKMatrix4 originalModelview = self.shader.transform.modelviewMatrix;
    for (PPSprite *sprite in self.sprites) {
        Quad spriteVertexQuad = [sprite quad];
        Quad spriteTexQuad = [self.spritesheet normalizedQuadForFrame:sprite.frameInfo];
        GLKMatrix4 transform=GLKMatrix4Identity;
        CGPoint anchor = sprite.realAnchorBeforeTransformations;
        // translate
        transform = GLKMatrix4Translate(transform,sprite.position.x,sprite.position.y, 0);
        // scale
        transform = GLKMatrix4Scale(transform, sprite.scale.x, sprite.scale.y, 0);
        // rotate
        transform = GLKMatrix4RotateZ(transform,-GLKMathDegreesToRadians(sprite.rotation));
        // translate back
        transform = GLKMatrix4Translate(transform, -anchor.x, -anchor.y, 0);
        // apply transformations
        self.shader.transform.modelviewMatrix = GLKMatrix4Multiply(self.shader.transform.modelviewMatrix, transform);
        [self.shader prepareToDraw];
        // draw
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0,&spriteVertexQuad);
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0,&spriteTexQuad);
        glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
        self.shader.transform.modelviewMatrix = originalModelview;
    }
}

-(void)dealloc
{
}

@end
