//
//  analysisController.h
//  iMienShiang
//
//  Created by hong liu on 10-10-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv/cv.h>

#import	"analysisController.h"

#define NO_PICKING 0
#define FRONT_FACE_PICKING 1
#define RIGHT_EAR_PICKING 2
#define LEFT_EAR_PICKING 3

@protocol analysisControllerDelegate;

@interface UIProgressIndicator : UIActivityIndicatorView {
}

+ (struct CGSize)size;
- (int)progressIndicatorStyle;
- (void)setProgressIndicatorStyle:(int)fp8;
- (void)setStyle:(int)fp8;
- (void)setAnimating:(BOOL)fp8;
- (void)startAnimation;
- (void)stopAnimation;
@end

@interface UIProgressHUD : UIView {
    UIProgressIndicator *_progressIndicator;
    UILabel *_progressMessage;
    UIImageView *_doneView;
    UIWindow *_parentWindow;
    struct {
        unsigned int isShowing:1;
        unsigned int isShowingText:1;
        unsigned int fixedFrame:1;
        unsigned int reserved:30;
    } _progressHUDFlags;
}

- (id)_progressIndicator;
- (id)initWithFrame:(struct CGRect)fp8;
- (void)setText:(id)fp8;
- (void)setShowsText:(BOOL)fp8;
- (void)setFontSize:(int)fp8;
- (void)drawRect:(struct CGRect)fp8;
- (void)layoutSubviews;
- (void)showInView:(id)fp8;
- (void)hide;
- (void)done;
- (void)dealloc;
@end



@interface analysisController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	id <analysisControllerDelegate>  delegate;
	UIProgressHUD *progressHUD;
	UIImageView * leftImageView;
	UIImageView * frontImageView;
	UIImageView * rightImageView;
	UIButton * leftButton;
	UIButton * frontButton;
	UIButton * rightButton;
	UIButton * startButton;	
	
	IplImage * frontFaceImage;
	IplImage * leftEarImage;
	IplImage * rightEarImage;
	
	bool imagePicking;
	int buttonPressed;
}

@property (nonatomic, assign) id <analysisControllerDelegate>  delegate;
@property (nonatomic, retain) IBOutlet UIImageView * leftImageView;
@property (nonatomic, retain) IBOutlet UIImageView * frontImageView;
@property (nonatomic, retain) IBOutlet UIImageView * rightImageView;
@property (nonatomic, retain) IBOutlet UIButton * leftButton;
@property (nonatomic, retain) IBOutlet UIButton * frontButton;
@property (nonatomic, retain) IBOutlet UIButton * rightButton;
@property (nonatomic, retain) IBOutlet UIButton * startButton;


- (IBAction)Cancel:(id)sender;
- (IBAction)loadImage:(id)sender;
- (IBAction)startImageAnalysis:(id)sender;

- (UIImage *)scaleAndRotateImage:(UIImage *)image toView:(UIImageView *)view;


@end


@protocol analysisControllerDelegate
-(void) analysisControllerDidFinishingSetting:(analysisController *)controller;

@end
