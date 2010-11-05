/*
 *  ims.c
 *  iMienShiang
 *
 *  Created by hong liu on 10-10-31.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include "ims.h"

int ims_init()
{
	return 0;
}


int ims_deinit()
{
	return 0;
}


int ims_alloc()
{
	return 0;
}


int ims_dealloc()
{
	return 0;
}


int ims_add_photo()
{
	return 0;
}


int ims_remove_photo()
{
	return 0;
}


int ims_analysis(IplImage * image)
{
	
	
	return 0;
}

- (void) ims_validate_front_image(IplImage * image, string fileName)
{
	cvSetErrMode(CV_ErrModeParent);
		
	// Scaling down
	IplImage *small_image = cvCreateImage(cvSize(image->width/2,image->height/2), IPL_DEPTH_8U, 3);
	cvPyrDown(image, small_image, CV_GAUSSIAN_5x5);
	int scale = 2;
		
	// Load XML
	NSString *path = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_default" ofType:@"xml"];
		CvHaarClassifierCascade* cascade = (CvHaarClassifierCascade*)cvLoad([path cStringUsingEncoding:NSASCIIStringEncoding], NULL, NULL, NULL);
		CvMemStorage* storage = cvCreateMemStorage(0);
		
		// Detect faces and draw rectangle on them
		CvSeq* faces = cvHaarDetectObjects(small_image, cascade, storage, 1.2f, 2, CV_HAAR_DO_CANNY_PRUNING, cvSize(20, 20));
		cvReleaseImage(&small_image);
		
		// Create canvas to show the results
		CGImageRef imageRef = frontImageView.image.CGImage;
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGContextRef contextRef = CGBitmapContextCreate(NULL, frontImageView.image.size.width, frontImageView.image.size.height,
														8, frontImageView.image.size.width * 4,
														colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
		CGContextDrawImage(contextRef, CGRectMake(0, 0, frontImageView.image.size.width, frontImageView.image.size.height), imageRef);
		
		CGContextSetLineWidth(contextRef, 4);
		CGContextSetRGBStrokeColor(contextRef, 0.0, 0.0, 1.0, 0.5);
		
		// Draw results on the iamge
		for(int i = 0; i < faces->total; i++) {
			NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
			
			// Calc the rect of faces
			CvRect cvrect = *(CvRect*)cvGetSeqElem(faces, i);
			CGRect face_rect = CGContextConvertRectToDeviceSpace(contextRef, CGRectMake(cvrect.x * scale, cvrect.y * scale, cvrect.width * scale, cvrect.height * scale));
			
			if(overlayImage) {
				CGContextDrawImage(contextRef, face_rect, overlayImage.CGImage);
			} else {
				CGContextStrokeRect(contextRef, face_rect);
			}
			
			[pool release];
		}
		
		frontImageView.image = [UIImage imageWithCGImage:CGBitmapContextCreateImage(contextRef)];
		CGContextRelease(contextRef);
		CGColorSpaceRelease(colorSpace);
		
		cvReleaseMemStorage(&storage);
		cvReleaseHaarClassifierCascade(&cascade);
		
	}
}






