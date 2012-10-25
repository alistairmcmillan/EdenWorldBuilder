//
//  SpecialEffects.m
//  prototype
//
//  Created by Ari Ronen on 11/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpecialEffects.h"
#import "Graphics.h"

#import "World.h"

vertexpStruct pbuffer[pbuffer_size];
static int pvbi_counter;

@implementation SpecialEffects



-(id) init{
   
	memset(pbuffer,0,sizeof(vertexpStruct)*pbuffer_size);
	pvbi_counter=0;

	bb=[[BlockBreak alloc] init];
	fire=[[Fire alloc] init];
	clouds=[[Clouds alloc] init];
	return self;
	
}
void setParticle(Vector p, int pvbi){
	
	pbuffer[pvbi].position[0]=p.x;
	pbuffer[pvbi].position[1]=p.y;
	pbuffer[pvbi].position[2]=p.z;
}
int getPVBI(){
	
	if(pvbi_counter==pbuffer_size-1){
		pvbi_counter=-1;	
	}
	return ++pvbi_counter;
}
- (BOOL)update: (float)etime{
   
	[bb update:etime];
	[fire update:etime];
	[clouds update:etime];
	return FALSE;
}

- (void)render{
	
    
	
	glColor4f(1.0, 0, 0, 1);
	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
		
	
	glVertexPointer(3, GL_FLOAT, sizeof(vertexpStruct),pbuffer[0].position);	
	glColorPointer(4, GL_UNSIGNED_BYTE,  sizeof(vertexpStruct),  pbuffer[0].colors);
    
    
		glEnable(GL_BLEND);
    glEnable(GL_POINT_SPRITE_OES);
    glEnableClientState(GL_POINT_SIZE_ARRAY_OES);
	glPointSizePointerOES(	GL_FLOAT,
                          sizeof(vertexpStruct),
                          pbuffer[0].size);

	
	
	
	
	
	glDepthMask(GL_FALSE);
	glTexEnvi(GL_POINT_SPRITE_OES, GL_COORD_REPLACE_OES, GL_TRUE);
	glBindTexture(GL_TEXTURE_2D, [[Resources getResources] getTex:ICO_SMOKE].name);
	
	
	glPointParameterf(GL_POINT_SIZE_MIN, 0.1f);
	//glPointParameterf(GL_POINT_SIZE_MAX,30.0f);
	float scaling2[3]={1,0,.002f};
	glPointParameterfv(GL_POINT_DISTANCE_ATTENUATION,scaling2);
	[fire render];
	
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
    
    glDepthMask(GL_TRUE);
    glDisable(GL_POINT_SPRITE_OES);
   
    glDisableClientState(GL_POINT_SIZE_ARRAY_OES);
	glDisable(GL_BLEND);
    
      glEnableClientState(GL_TEXTURE_COORD_ARRAY);


	[bb render];
	
    
    
    
	glDisableClientState(GL_COLOR_ARRAY);
	

}
- (void)addBlockBreak:(int)x:(int)z:(int)y:(int)type:(int)color{
	[bb addBlockBreak:(int)x:(int)z:(int)y:(int)type:(int)color];
	
}
- (int)addFire:(float)x:(float)z:(float)y:(int)type:(float)life{
	return [fire addFire:x :z :y :type :life];
	
}
- (void)addFirework:(float)x:(float)z:(float)y:(int)color{
    
    [bb addFirework:x :z :y :color ];
    
}
- (void)addCreatureVanish:(float)x:(float)z:(float)y:(int)color:(int)type{
   
    [bb addCreatureVanish2:x :z :y :color :type];
    
}
- (void)addBlockExplode:(int)x:(int)z:(int)y:(int)type:(int)color{
	[bb addBlockExplode:x:z:y:type:(int)color];
}
-(void)removeFire:(int)ppid{
	[fire removeFire:ppid];
}
-(void)updateFire:(int)idx:(Vector)pos
{
    [fire updateFire:idx:pos];
}
- (void)clearAllEffects{
	
	[bb clearAllEffects];
	[fire clearAllEffects];
	
}
@end
