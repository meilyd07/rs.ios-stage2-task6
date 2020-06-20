//
//  IconViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/19/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "IconViewController.h"
#import "IconView.h"
#import "UIColor+HexColors.h"

int const ICON_SIZE = 70;
int const LEFT_MARGIN = 55;
int const RIGHT_MARGIN = 55;
int const BOTTOM_MARGIN = 55;
int const BUTTON_HEIGHT = 55;

@interface IconViewController ()
@property(nonatomic, strong) IconView *iconViewTriangle;
@property(nonatomic, strong) IconView *iconViewCircle;
@property(nonatomic, strong) IconView *iconViewRectangle;
@property(nonatomic, strong) UILabel *descriptionLabel;
@property(nonatomic, strong) UIButton *startButton;
@end

@implementation IconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor customWhite];
    [self setupDescription];
    [self setupIconViews];
    [self setupButton];
    [self setupConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //start animation circle todo
}

- (void)setupDescription {
    
    self.descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.descriptionLabel.text = @"Are you ready?";
    self.descriptionLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    self.descriptionLabel.numberOfLines = 1;
    self.descriptionLabel.adjustsFontSizeToFitWidth = YES;
    self.descriptionLabel.textColor = [UIColor customBlack];
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.descriptionLabel sizeToFit];
    [self.view addSubview:self.descriptionLabel];
}

- (void)setupButton {
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.startButton.frame = CGRectMake(55, 250, 100.0, 55.0);
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    self.startButton.backgroundColor = [UIColor customYellow];
    [self.startButton setTitleColor:[UIColor customBlack] forState:UIControlStateNormal];
    [self.startButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
    //[playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.startButton.clipsToBounds = YES;
    [self.view addSubview:self.startButton];
}

- (void)setupIconViews {
    self.iconViewCircle = [[IconView alloc] initWithFrame:CGRectMake(0, 0, ICON_SIZE, ICON_SIZE) WithType:IconViewCircle andColor:[UIColor customRed]];
    self.iconViewCircle.backgroundColor = [UIColor customWhite];
    [self.view addSubview:self.iconViewCircle];
    
    self.iconViewRectangle = [[IconView alloc] initWithFrame:CGRectMake(100, 0, ICON_SIZE, ICON_SIZE) WithType:IconViewRectangle andColor:[UIColor customBlue]];
    self.iconViewRectangle.backgroundColor = [UIColor customWhite];
    [self.view addSubview:self.iconViewRectangle];

    self.iconViewTriangle = [[IconView alloc] initWithFrame:CGRectMake(200, 0, ICON_SIZE, ICON_SIZE) WithType:IconViewTriangle andColor:[UIColor customGreen]];
    self.iconViewTriangle.backgroundColor = [UIColor customWhite];
    [self.view addSubview:self.iconViewTriangle];
    
}

- (void)setupConstraints {
    
    //label
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:100].active = YES;
    } else {
        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    }
    [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:LEFT_MARGIN].active = YES;
    [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-RIGHT_MARGIN].active = YES;
    
    //rectangle, circle, triangle, button
    self.iconViewTriangle.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconViewCircle.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconViewRectangle.translatesAutoresizingMaskIntoConstraints = NO;
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.iconViewCircle.centerYAnchor constraintLessThanOrEqualToAnchor:self.descriptionLabel.bottomAnchor constant:self.view.frame.size.height / 4].active = YES;
    [self.iconViewRectangle.topAnchor constraintEqualToAnchor:self.iconViewCircle.topAnchor constant:0].active = YES;
    [self.iconViewTriangle.topAnchor constraintEqualToAnchor:self.iconViewCircle.topAnchor constant:0].active = YES;
    
    [self.iconViewRectangle.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
    if (@available(iOS 11.0, *)) {
        [self.iconViewCircle.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:LEFT_MARGIN].active = YES;
        [self.iconViewTriangle.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-RIGHT_MARGIN].active = YES;
        [self.startButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-BOTTOM_MARGIN].active = YES;
        [self.startButton.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:LEFT_MARGIN].active = YES;
        [self.startButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-RIGHT_MARGIN].active = YES;
    } else {
        [self.iconViewCircle.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:LEFT_MARGIN].active = YES;
        [self.iconViewTriangle.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-RIGHT_MARGIN].active = YES;
        [self.startButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-BOTTOM_MARGIN].active = YES;
        [self.startButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:LEFT_MARGIN].active = YES;
        [self.startButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-RIGHT_MARGIN].active = YES;
    }
    
    [self.iconViewCircle.heightAnchor constraintEqualToConstant:ICON_SIZE].active = YES;
    [self.iconViewCircle.widthAnchor constraintEqualToConstant:ICON_SIZE].active = YES;
    [self.iconViewTriangle.heightAnchor constraintEqualToConstant:ICON_SIZE].active = YES;
    [self.iconViewTriangle.widthAnchor constraintEqualToConstant:ICON_SIZE].active = YES;
    [self.iconViewRectangle.heightAnchor constraintEqualToConstant:ICON_SIZE].active = YES;
    [self.iconViewRectangle.widthAnchor constraintEqualToConstant:ICON_SIZE].active = YES;
    
    [self.startButton.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT].active = YES;
    
    [self.startButton.topAnchor constraintGreaterThanOrEqualToAnchor:self.iconViewTriangle.bottomAnchor constant:20].active = YES;
    
}

@end