#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
    UIImageView *fullScreenView;
    BOOL showingMonkey;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    showingMonkey = YES;
    
    fullScreenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    fullScreenView.image = [UIImage imageNamed:@"monkey.png"];
    fullScreenView.contentMode = UIViewContentModeScaleToFill;
    fullScreenView.userInteractionEnabled = YES;
    [self.view addSubview:fullScreenView];
    
    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenTap:)];
    [fullScreenView addGestureRecognizer:screenTap];
}

- (void)handleScreenTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView transitionWithView:fullScreenView
                          duration:0.20
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
            if (self->showingMonkey) {
                fullScreenView.image = [UIImage imageNamed:@"text.png"];
                self->showingMonkey = NO;
            } else {
                fullScreenView.image = [UIImage imageNamed:@"monkey.png"];
                self->showingMonkey = YES;
            }
        } completion:nil];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
