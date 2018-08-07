//
//  DetailViewController.m
//  PodcastsV5
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.

#import "DetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "KPiLocalImageFull+CoreDataClass.h"
#import "NSString+stringFromDate.h"
#import "KPIContent+CoreDataClass.h"
#import "CheckForOldHanselman.h"
#import <QuartzCore/QuartzCore.h>

static float progress;

@interface DetailViewController ()<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>


@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *detailsLabel;
@property (strong, nonatomic) UIButton *downloadButton;

@property (strong, nonatomic) UIStackView* stackView;
@property (strong, nonatomic) KPIItem* item;
@property (strong, nonatomic) UIImageView* playImgView;
@property (strong, nonatomic) NSLayoutConstraint *changableConstraint;

@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, readwrite, nonatomic ) NSProgress* progress;


@end


static NSString * const kPlaceHolder = @"videoPlaceholder";

CGFloat multiplier = 0.5;

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}



- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        self.navigationItem.leftItemsSupplementBackButton = YES;
        self.view.backgroundColor = UIColor.whiteColor;
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    [self setupScrollView];
    [self setupImageView];
    [self setupDownloadButton];
    [self setupTitleLabel];
    [self setupAuthorLabel];
    [self setupDateLabel];
    [self setupDetailsLabel];
    [self createStackView];
    [self setupConstraints];
    [self setupPlayView];
    [self setupProgressView];
}


#pragma mark - Views Layouting
-(void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = UIColor.clearColor;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.clipsToBounds = YES;
    [self.view addSubview: self.scrollView];
    
   
}

-(void)setupImageView {
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: kPlaceHolder]];
    self.imageView.layer.contentsGravity = kCAGravityResizeAspect;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 5);
    self.imageView.layer.shadowOpacity = 0.8;
    self.imageView.layer.backgroundColor = UIColor.blackColor.CGColor;
    [self.imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapGestureHandle:)];
    [self.imageView addGestureRecognizer:tap];
    [self setupPlayView];
   
}

-(void) setupPlayView{
    [self.scrollView addSubview:self.imageView];
    
    
    UIImageView* playImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Play"]];
    
     playImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView addSubview:playImage];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:playImage.superview
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:playImage
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.0
                                                              constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint
                                  constraintWithItem:playImage.superview
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:playImage
                                  attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                  constant:0.0];
    [left setActive:YES];
    [bottom setActive:YES];
    [playImage.superview addConstraints: @[left, bottom]];

}

-(void)setupDownloadButton {
    self.downloadButton = [[UIButton alloc] init];
    [self.downloadButton addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadButton addSubview:self.progressView];
    
    
}

-(void) setupProgressView{
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.progressView layer]setBorderColor:[UIColor redColor].CGColor];
       self.progressView.trackTintColor = [UIColor clearColor];
    [self.progressView setProgress:0 animated:YES];
    [self.progressView setHidden:YES];
    
     [self.downloadButton addSubview:self.progressView];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.progressView.superview
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.progressView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.progressView.superview
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.progressView
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.progressView.superview
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.progressView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0.0];
    [self.progressView setObservedProgress:self.progress];
    
    [NSLayoutConstraint activateConstraints:@[leading, trailing, bottom]];
    [self.progressView.superview addConstraints: @[leading, trailing, bottom]];

    
//
//
//    UIProgressView *progressView;
//    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//    progressView.progressTintColor = [UIColor colorWithRed:187.0/255 green:160.0/255 blue:209.0/255 alpha:1.0];
//    [[progressView layer]setFrame:CGRectMake(20, 50, 200, 200)];
//    [[progressView layer]setBorderColor:[UIColor redColor].CGColor];
//    progressView.trackTintColor = [UIColor clearColor];
//    [progressView setProgress:(float)(50/100) animated:YES];  ///15
//
//    [[progressView layer]setCornerRadius:progressView.frame.size.width / 2];
//    [[progressView layer]setBorderWidth:3];
//    [[progressView layer]setMasksToBounds:TRUE];
//    progressView.clipsToBounds = YES;
    
   
}

-(void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    UIFont* gillSans = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    self.titleLabel.font = gillSans;
    
    
    
    self.titleLabel.text = @"Title Details I have a simple requirement, I want to have color change effect on UIButton when a user touch on button";
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
    self.titleLabel.numberOfLines = 0;
    
    
    
}

-(void)setupAuthorLabel {
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.authorLabel.font = [UIFont systemFontOfSize:20];
    self.authorLabel.text = @"Author";
    self.authorLabel.textAlignment = NSTextAlignmentLeft;
    self.authorLabel.textColor = [UIColor darkGrayColor];
  
}




-(void) check{
    self.downloadButton.enabled = YES;
    NSFileManager* filemanager = [NSFileManager defaultManager];
    NSString *pathToDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    NSString* pathToContent = [pathToDocuments stringByAppendingPathComponent:[self.item.mediaContentWebURL lastPathComponent]];
    
    if ([filemanager fileExistsAtPath:pathToContent] == NO){
        [self.downloadButton setImage:[UIImage imageNamed:@"save"]  forState:UIControlStateNormal ];
    } else{
        [self.downloadButton setImage:[UIImage imageNamed:@"del"]  forState:UIControlStateNormal ];
    }
    
}

-(void)setupDateLabel {
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dateLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    self.dateLabel.text = @"Date";
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    self.dateLabel.textColor = [UIColor darkGrayColor];
}



-(void)setupDetailsLabel {
    self.detailsLabel = [[UILabel alloc] init];
    self.detailsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailsLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    self.detailsLabel.text = @"Details";
    self.detailsLabel.textColor = [UIColor blackColor];
    self.detailsLabel.textAlignment = NSTextAlignmentNatural;
    self.detailsLabel.numberOfLines = 0;
    
}


-(void)createStackView {
    self.stackView = [[UIStackView alloc] initWithArrangedSubviews:
   @[self.downloadButton, self.authorLabel,self.titleLabel, self.dateLabel,self.detailsLabel]];

    [self.stackView setAxis:UILayoutConstraintAxisVertical];
    self.stackView.spacing = 10.f;
    [self.stackView setAlignment:UIStackViewAlignmentFill];
    [self.stackView setDistribution:UIStackViewDistributionFill];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.scrollView addSubview:self.stackView];
}


-(void)setupConstraints {
    //scrollView
    [NSLayoutConstraint activateConstraints:
     @[
       [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0],
       [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:0],
       [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:0],
       [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:0],
       ]];
    
    //changable constraint
    self.changableConstraint = [self.imageView.heightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.heightAnchor multiplier:0.5];
    
    //ImageView
    [NSLayoutConstraint activateConstraints:
     @[
       [self.imageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:0],
       [self.imageView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:0],
       [self.imageView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:0],
       self.changableConstraint,
       [self.imageView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor]
       ]];
    
    //StackView
    [NSLayoutConstraint activateConstraints:
     @[
       [self.stackView.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:20],
       [self.stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
       [self.stackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
       [self.stackView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-20]
       ]];
}

#pragma mark - SizeClasses
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [NSLayoutConstraint deactivateConstraints:@[self.changableConstraint]];
    
    if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact &&
        self.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        
        self.changableConstraint = [self.imageView.heightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.heightAnchor multiplier:1];
    } else {
        self.changableConstraint = [self.imageView.heightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.heightAnchor multiplier:0.5];
    }
    [NSLayoutConstraint activateConstraints:@[self.changableConstraint]];
}



#pragma mark - Delegate
- (void)itemWasSelected:(KPIItem *)item {
    
    self.item = item;
    self.authorLabel.text = item.author;
    self.titleLabel.text = item.title;
    self.dateLabel.text = [NSString getStringFromDate:item.publicationDate];
    self.detailsLabel.text = item.details;
    [self check];
  
    
    CheckForOldHanselman* check = [[CheckForOldHanselman alloc] init];
    
    BOOL oldHanselman = [check checkForOldHanselman:item];

    
    if (oldHanselman) {
        [self.imageView setImage: [UIImage imageNamed:@"hanselminutesimg"]];
        return;
    }
    [self.imageView setImage: [UIImage imageWithData: item.imageFull.image]];
    
}


-(void)tapGestureHandle:(UITapGestureRecognizer*)tap {
    
    NSFileManager* filemanager = [NSFileManager defaultManager];
    NSString* pathToContent = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self.item.content.name];
    
    NSURL* urlToContent;
    
    if ([filemanager fileExistsAtPath:pathToContent] == NO){
        urlToContent = [NSURL URLWithString:self.item.mediaContentWebURL];
    } else{
        urlToContent = [NSURL fileURLWithPath:pathToContent];
    }
    
   
     AVPlayer *player = [AVPlayer playerWithURL:urlToContent];
        
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    controller.player = player;
    [player play];
    
    
    
}

-(void)downloadAction:(UIButton*)button {
    [self changeButton:button forState:UIControlStateHighlighted animated:YES];
    [self changeButton:button forState:UIControlStateNormal animated:YES];

    NSFileManager* filemanager = [NSFileManager defaultManager];
    NSString* pathToContent = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self.item.content.name];
    
    if (![filemanager fileExistsAtPath:pathToContent]) {
        self.downloadButton.enabled = NO;
        [self downloadContent];
        [self.progressView setHidden:NO];
        return;
    }
    
    [filemanager removeItemAtPath:pathToContent error:nil];
    
    [self check];
}


- (void)changeButton:(UIButton*)button forState:(UIControlState)state animated:(BOOL)isAnimated {
    
    if (isAnimated) {
        [UIView animateWithDuration:1 animations:^{
            if (state == UIControlStateNormal) {
                button.backgroundColor = UIColor.whiteColor;
            } else {
                button.backgroundColor = UIColor.lightGrayColor;
            }
        }];
    }
}

-(void) downloadContent{
    NSURLSessionConfiguration* config =[NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setQualityOfService:NSQualityOfServiceUtility];
    queue.maxConcurrentOperationCount = 1;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
    NSURLSessionDownloadTask* task = [session downloadTaskWithURL:[NSURL URLWithString: self.item.mediaContentWebURL]];
    
    [task resume];
    [session finishTasksAndInvalidate];
    
}


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    self.progress  = downloadTask.progress;
    CGFloat prog = (float)totalBytesWritten/totalBytesExpectedToWrite;
    progress = (100.0*prog);
    self.progress = [NSProgress progressWithTotalUnitCount:(int)(100.0*prog)];
    NSLog(@"downloaded %d%%", (int)(100.0*prog));
    
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    // unused in this example
}



-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"completed; error: %@", error);
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSFileManager* filemanager = [NSFileManager defaultManager];
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    NSString* pathToContent = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self.item.content.name];
    [filemanager createFileAtPath:pathToContent contents:data attributes:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView setHidden:YES];
        [self check];
    }) ;
    
}


@end
