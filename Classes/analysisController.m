//
//  analysisController.m
//  iMienShiang
//
//  Created by hong liu on 10-10-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "analysisController.h"


@implementation analysisController

@synthesize delegate;
@synthesize leftImageView;
@synthesize frontImageView;
@synthesize rightImageView;
@synthesize leftButton;
@synthesize frontButton;
@synthesize rightButton;
@synthesize startButton;



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    buttonPressed = NO_PICKING;
}

-(void)Cancel:(id)sender
{
    [self.delegate analysisControllerDidFinishingSetting:self];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations
    return NO;
}

// NOTE you SHOULD cvReleaseImage() for the return value when end of the code.
- (IplImage *)CreateIplImageFromUIImage:(UIImage *)image 
{
    CGImageRef imageRef = image.CGImage;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    IplImage *iplimage = cvCreateImage(cvSize(image.size.width, image.size.height), IPL_DEPTH_8U, 4);
    CGContextRef contextRef = CGBitmapContextCreate(iplimage->imageData, iplimage->width, iplimage->height,
                                                    iplimage->depth, iplimage->widthStep,
                                                    colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);

    IplImage *ret = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 3);
    cvCvtColor(iplimage, ret, CV_RGBA2BGR);
    cvReleaseImage(&iplimage);

    return ret;
}

// NOTE You should convert color mode as RGB before passing to this function
- (UIImage *)UIImageFromIplImage:(IplImage *)image 
{
    NSLog(@"IplImage (%d, %d) %d bits by %d channels, %d bytes/row %s", image->width, image->height, image->depth, image->nChannels, image->widthStep, image->channelSeq);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSData *data = [NSData dataWithBytes:image->imageData length:image->imageSize];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    CGImageRef imageRef = CGImageCreate(image->width, image->height,
                                        image->depth, image->depth * image->nChannels, image->widthStep,
                                        colorSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault,
                                        provider, NULL, false, kCGRenderingIntentDefault);
    UIImage *ret = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    return ret;
}

- (void)showProgressIndicator:(NSString *)text 
{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.view.userInteractionEnabled = FALSE;
    if(!progressHUD) 
    {
        CGFloat w = 160.0f, h = 120.0f;
        progressHUD = [[UIProgressHUD alloc] initWithFrame:CGRectMake((self.view.frame.size.width-w)/2, (self.view.frame.size.height-h)/2, w, h)];
        [progressHUD setText:text];
        [progressHUD showInView:self.view];
    }
}

- (void)hideProgressIndicator 
{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.view.userInteractionEnabled = TRUE;
    if(progressHUD) 
    {
        [progressHUD hide];
        [progressHUD release];
        progressHUD = nil;
    }
}

- (IBAction)loadImage:(id)sender 
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                        delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Use Photo from Library", @"Take Photo with Camera", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    [actionSheet release];
    if (sender == leftButton)
    {
        buttonPressed = LEFT_EAR_PICKING;
    }
    else if(sender == frontButton )
    {
        buttonPressed = FRONT_FACE_PICKING;
    }
    else if(sender == rightButton)
    {
        buttonPressed = RIGHT_EAR_PICKING;
    }
    else 
    {
        /* This should not happen */
        buttonPressed = NO_PICKING;
    }
}

-(IBAction) startImageAnalysis:(id)sender
{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;

    if (buttonIndex == 0) 
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if(buttonIndex == 1) 
    {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    } 
    else 
    {
        // Cancel
        return;
    }
    if([UIImagePickerController isSourceTypeAvailable:sourceType]) 
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
        [picker release];
    }
}


- (UIImage *)scaleAndRotateImage:(UIImage *)image toView:(UIImageView *)view 
{
    int kMaxResolution = view.frame.size.width;

    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);

    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) 
    {
        CGFloat ratio = width/height;
        if (ratio > 1) 
        {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        } 
        else 
        {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }

    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;

    UIImageOrientation orient = image.imageOrientation;
    switch(orient) 
    {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }

    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) 
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } 
    else 
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return imageCopy;
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    UIImageView * imageView;
    IplImage * img;
    IplImage * img_processed;

    [self showProgressIndicator:@"Validating"];

    img = [self CreateIplImageFromUIImage:image];

    if (buttonPressed == LEFT_EAR_PICKING)
    {
        imageView = leftImageView;
        leftEarImage = img_processed = ims_clip_left_image(img);
    }
    else if (buttonPressed == RIGHT_EAR_PICKING)
    {
        imageView = rightImageView;
        frontFaceImage = img_processed = ims_clip_front_image(img);
    }
    else if (buttonPressed == FRONT_FACE_PICKING)
    {
        imageView = frontImageView;
        rightEarImage = img_processed = ims_clip_right_image(img);
    }

    [[picker parentViewController] dismissModalViewControllerAnimated:YES];

    if (NULL == img_processed)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Validating" message:@"Image is not valid"];
        [alert show];
    }
    else
    {
        imageView.image = [self scaleAndRotateImage:UIImageFromIplImage(img_processed) toView:imageView];
        cvReleaseImage(img);
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
