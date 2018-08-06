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


@interface DetailViewController ()


@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *detailsLabel;

@property (strong, nonatomic) UIStackView* stackView;
@property (strong, nonatomic) KPIItem* item;
@property (strong, nonatomic) UIImageView* playImgView;

@property (strong, nonatomic) NSLayoutConstraint *changableConstraint;


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
 
    [self setupTitleLabel];
    [self setupAuthorLabel];
    [self setupDateLabel];
    [self setupDetailsLabel];
    [self createStackView];
    
    [self setupConstraints];
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
    [self.scrollView addSubview:self.imageView];
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
   @[self.authorLabel,self.titleLabel, self.dateLabel,self.detailsLabel]];

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

   

    
    self.authorLabel.text = item.author;
    self.titleLabel.text = item.title;
    self.dateLabel.text = [NSString getStringFromDate:item.publicationDate];
    self.detailsLabel.text = item.details;
   // self.itemType = item.sourceType;
    self.item = item;
    
    
    CheckForOldHanselman* check = [[CheckForOldHanselman alloc] init];
    
    BOOL oldHanselman = [check checkForOldHanselman:item];
    
    if (oldHanselman) {
        [self.imageView setImage: [UIImage imageNamed:@"hanselminutesimg"]];
        return;
    }
    [self.imageView setImage: [UIImage imageWithData: item.imageFull.image]];

        
}




-(void)tapGestureHandle:(UITapGestureRecognizer*)tap {
    
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:self.item.mediaContentWebURL]];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    controller.player = player;
    [player play];
    
    
    
}

- (void)changeButton:(UIButton*)button forState:(UIControlState)state animated:(BOOL)isAnimated {
    
    if (isAnimated) {
        [UIView animateWithDuration:1 animations:^{
            if (state == UIControlStateNormal) {
                button.backgroundColor = UIColor.whiteColor;
            } else {
                button.backgroundColor = UIColor.greenColor;
            }
        }];
    }
}

@end
