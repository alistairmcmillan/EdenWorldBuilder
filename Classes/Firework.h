//
//  Firework.h
//  Eden
//
//  Created by Ari Ronen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <math.h>
#import "Util.h"
#import "Terrain.h"
#import "World.h"
#import "Camera.h"
#import "Input.h"
#import "OpenGL_Internal.h"

#define MAX_FIREWORK 40
typedef struct _firework{
    Vector pos;
    int color;
    float fuse;
    Vector vel;
    
}sfirework;
@interface Firework : NSObject{
    int n_firework;
    sfirework fireworks[MAX_FIREWORK];
    float frot;
    
}
-(void)addFirework:(int)x:(int)y:(int)z:(int)color;
-(void)removeAllFireworks;
-(void)update:(float)etime;
-(void)render;
@end
