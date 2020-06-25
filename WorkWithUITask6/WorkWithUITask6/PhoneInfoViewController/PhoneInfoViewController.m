//
//  PhoneInfoViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/21/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "PhoneInfoViewController.h"
#import "IconView.h"
#import "UIColor+HexColors.h"
//#import <WebKit/WebKit.h>

int const ICONS_SIZE = 70;

@interface PhoneInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneName;
@property (weak, nonatomic) IBOutlet UILabel *phoneModel;
@property (weak, nonatomic) IBOutlet UILabel *systemOS;
@property (weak, nonatomic) IBOutlet IconView *circleView;
@property (weak, nonatomic) IBOutlet IconView *rectangleView;
@property (weak, nonatomic) IBOutlet IconView *triangleView;
@property (weak, nonatomic) IBOutlet UIButton *openGitButton;
@property (weak, nonatomic) IBOutlet UIButton *goToStartButton;

@end

@implementation PhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor customWhite];
    [self setupIconViews];
    [self setupButtons];
    [self setupLabels];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(onRotateDevice) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationBar];
    [self.circleView animateView];
    [self.rectangleView animateView];
    [self.triangleView animateView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.circleView.layer removeAllAnimations];
    [self.rectangleView.layer removeAllAnimations];
    [self.triangleView.layer removeAllAnimations];
}

-(void)onRotateDevice {
    [self.circleView.layer removeAllAnimations];
    [self.rectangleView.layer removeAllAnimations];
    [self.triangleView.layer removeAllAnimations];

    [self.circleView animateView];
    [self.rectangleView animateView];
    [self.triangleView animateView];
}

- (void)setupLabels {
    self.phoneName.text = [[UIDevice currentDevice] name];
    self.phoneModel.text = [UIDevice currentDevice].model;
    self.systemOS.text = [UIDevice currentDevice].systemVersion;
}

- (void)setupIconViews {
    self.circleView.type = IconViewCircle;
    self.circleView.color = [UIColor customRed];
    self.circleView.backgroundColor = [UIColor customWhite];
    
    self.rectangleView.type = IconViewRectangle;
    self.rectangleView.color = [UIColor customBlue];
    self.rectangleView.backgroundColor = [UIColor customWhite];

    self.triangleView.type = IconViewTriangle;
    self.triangleView.color = [UIColor customGreen];
    self.triangleView.backgroundColor = [UIColor customWhite];
}

- (void)setupButtons {
    
    self.openGitButton.backgroundColor = [UIColor customYellow];
    [self.openGitButton setTitleColor:[UIColor customBlack] forState:UIControlStateNormal];
    [self.openGitButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
    [self.openGitButton addTarget:self action:@selector(openGitAction:) forControlEvents:UIControlEventTouchUpInside];
    self.openGitButton.layer.cornerRadius = 55 / 2;
    self.openGitButton.clipsToBounds = YES;
    
    self.goToStartButton.backgroundColor = [UIColor customRed];
    [self.goToStartButton setTitleColor:[UIColor customWhite] forState:UIControlStateNormal];
    [self.goToStartButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
    [self.goToStartButton addTarget:self action:@selector(goToStartAction:) forControlEvents:UIControlEventTouchUpInside];
    self.goToStartButton.layer.cornerRadius = 55 / 2;
    self.goToStartButton.clipsToBounds = YES;
}

-(void)openGitAction:(UIButton *)button {
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://meilyd07.github.io/rsschool-cv/cv"] options:@{} completionHandler:nil];
}

-(void)goToStartAction:(UIButton *)button {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupNavigationBar {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (@available(iOS 13, *)) {
        self.navigationController.navigationBar.standardAppearance = [[UINavigationBarAppearance alloc] init];
        [self.navigationController.navigationBar.standardAppearance configureWithDefaultBackground];
        self.navigationController.navigationBar.standardAppearance.backgroundColor = [UIColor customYellow];
       self.navigationController.navigationBar.standardAppearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor customBlack], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor customYellow];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor customBlack], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"RSSchool Task 6";
}

@end
