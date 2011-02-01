//
//  CCGaussianBlurSprite.m
//  AWTextureFilter
//
//  Created by Keisuke Hata on 11/01/19.
//

#import "CCGaussianBlurSprite.h"

@interface CCGaussianBlurSprite(private) 

- (id) initWithBlurSprite : (NSString *)filename blurCount:(int)blurCount;

@end

@implementation CCGaussianBlurSprite

@synthesize blurSpeed = blurSpeed_;
@synthesize isAnimating = isAnimating_;

- (void) updateBlur {

	if( isAnimating_==NO ) 
		return;
	
	if( blurCount_ > 0 )
		blurCount_--;
	
	[mutableGBTexture_ restore];
	if( blurCount_ == 0 ) {
	
		CCLOG(@"blur end");
		// update schedule stop
		[self unschedule:_cmd];
		
		// Release caching texture data
		[mutableGBTexture_ release];
		mutableGBTexture_ = nil;
		
		return;
	}
	
	// update blur effect
	[AWTextureFilter blur:mutableGBTexture_ radius:blurCount_];
}

+ (id) blurSpriteWithFile:(NSString *)filename blurCount:(int)blurCount {

	return [[self alloc] initWithBlurSprite:filename blurCount:blurCount];
}

- (void) startAnimation {

	isAnimating_ = YES;
}

- (void) stopAnimation {
	
	isAnimating_ = NO;
}

- (id) initWithBlurSprite : (NSString *)filename blurCount:(int)blurCount {
	
	UIImage *img = [UIImage imageNamed:filename];
	NSAssert( img != nil , @"CCGaussianBlurSprite:Image is nil" );
	
	mutableGBTexture_ = [[CCTexture2DMutable alloc] initWithImage:img];
	NSAssert( mutableGBTexture_ != nil , @"CCGaussianBlurSprite:MutableSprite is nil" );
	
	blurCount_ = blurCount;
	blurSpeed_ = 1;
	isAnimating_ = NO;
	
	if( (self = [super initWithTexture:mutableGBTexture_]) ) {
		
		[AWTextureFilter blur:mutableGBTexture_ radius:blurCount_];
		[self schedule:@selector(updateBlur) interval:1./30.];
	}
	return self;
}

- (void) dealloc {

	[mutableGBTexture_ release];
	mutableGBTexture_ = nil;
	[super dealloc];
}

@end
