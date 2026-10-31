#import <UIKit/UIKit.h>

// We declare the class as both the view controller AND the application delegate loader
@interface RootViewController : UIViewController <UIApplicationDelegate>
@property (nonatomic, assign) BOOL showingMonkey;
@property (nonatomic, retain) UIImageView *fullScreenView;
@property (nonatomic, retain) UIWindow *window;
@end

@implementation RootViewController

@synthesize showingMonkey;
@synthesize fullScreenView;
@synthesize window = _window;

// Natively handles building the iOS window context on app launch
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showingMonkey = YES;
    
    // Set up the full-screen 480x320 canvas dimensions
    self.fullScreenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    self.fullScreenView.image = [UIImage imageNamed:@"monkey.png"];
    self.fullScreenView.contentMode = UIViewContentModeScaleToFill;
    self.fullScreenView.userInteractionEnabled = YES;
    [self.view addSubview:self.fullScreenView];
    
    // Wire up full-screen tap gestures
    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenTap:)];
    [self.fullScreenView addGestureRecognizer:screenTap];
}

- (void)handleScreenTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        // Asset-toggling dissolve sequence animation loop
        [UIView transitionWithView:self.fullScreenView
                          duration:0.20
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
            
            if (self.showingMonkey) {
                self.fullScreenView.image = [UIImage imageNamed:@"text.png"];
                self.showingMonkey = NO;
            } else {
                self.fullScreenView.image = [UIImage imageNamed:@"monkey.png"];
                self.showingMonkey = YES;
            }
            
        } completion:nil];
    }
}

// Lock application window environment strictly into Landscape matching our frames
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)dealloc {
    [_fullScreenView release];
    [_window release];
    [super dealloc];
}

@end

// 🚀 THE LINKER FIX: The direct native entry point loop execution block
int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, @"RootViewController");
    }
}
