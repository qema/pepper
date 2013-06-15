//
//  PPTileset.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTileset.h"

@implementation PPTileset

-(void)processData:(NSDictionary *)dict
{
    tilesetDict = dict;
    int width = [[tilesetDict objectForKey:@"width"] intValue];
    int height = [[tilesetDict objectForKey:@"height"] intValue];
    self.textureSize = CGSizeMake(width, height);
    int tileWidth = [[tilesetDict objectForKey:@"tilewidth"] intValue];
    int tileHeight = [[tilesetDict objectForKey:@"tileheight"] intValue];
    self.tileSize = CGSizeMake(tileWidth, tileHeight);
    self.name = [tilesetDict objectForKey:@"name"];
    self.spacing = [[tilesetDict objectForKey:@"spacing"] intValue];
    self.margin = [[tilesetDict objectForKey:@"margin"] intValue];
    firstGID = [[tilesetDict objectForKey:@"firstgid"] intValue];
}

-(Quad)quadForTile:(int)tileID
{
    int i = tileID-firstGID;
    int rowLength = (self.textureSize.width+self.spacing)/(self.tileSize.width+self.spacing);
    CGRect rect = CGRectMake((i%rowLength)*(self.tileSize.width+self.spacing)+self.margin,floor(i/rowLength)*(self.tileSize.height+self.spacing)+self.margin, self.tileSize.width, self.tileSize.height);
    Quad q;
    q.x1 = rect.origin.x+0.25; q.y1 = rect.origin.y+0.25;
    q.x2 = rect.origin.x+0.25; q.y2 = rect.origin.y+rect.size.height-0.25;
    q.x3 = rect.origin.x+rect.size.width-0.25; q.y3 = rect.origin.y+rect.size.height-0.25;
    q.x4 = rect.origin.x+rect.size.width-0.25; q.y4 = rect.origin.y+0.25;
    return q;
}

-(Quad)normalizedQuadForTile:(int)tileID
{
    Quad q = [self quadForTile:tileID];
    CGSize size = self.textureSize;
    q.x1 /= size.width; q.y1 /= size.height;
    q.x2 /= size.width; q.y2 /= size.height;
    q.x3 /= size.width; q.y3 /= size.height;
    q.x4 /= size.width; q.y4 /= size.height;
    return q;
}

-(NSDictionary *)propertiesForTile:(int)tileID
{
    return [[tilesetDict objectForKey:@"tiles"] objectForKey:[NSNumber numberWithInt:tileID]];
}

-(id)initWithImageFile:(NSString *)file properties:(NSDictionary *)dict scale:(float)scale
{
    if (self=[super initWithScale:scale]) {
        self.textureFile = file;
        [self processData:dict];
        NSError *error;
        self.texture = [GLKTextureLoader textureWithContentsOfFile:[PPFileUtils fullPath:self.textureFile] options:nil error:&error];
        if (error) {
            NSLog(@"Error loading texture image %@: %@",self.textureFile,error);
        }
    }
    return self;
}
@end
