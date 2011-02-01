//
//  CCGaussianBlurSprite.h
//  AWTextureFilter
//
//  Created by Keisuke Hata on 11/01/19.
//

#import <Foundation/Foundation.h>
#import "AWTextureFilter.h"
#import "CCTexture2DMutable.h"
#import "cocos2d.h"

@interface CCGaussianBlurSprite : CCSprite {

	CCMutableTexture2D *mutableGBTexture_;
	int blurCount_;
	int blurSpeed_;
	BOOL isAnimating_;
}

+ (id) blurSpriteWithFile:(NSString *)filename blurCount:(int)blurCount;
- (void) startAnimation;
- (void) stopAnimation;

@property (nonatomic,readwrite) int blurSpeed;
@property (nonatomic,readonly) BOOL isAnimating;

@end
