#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIApplicationDelegate>
@property (nonatomic, assign) BOOL showingMonkey;
@property (nonatomic, retain) UIImageView *fullScreenView;
@property (nonatomic, retain) UIWindow *window;
@end

@implementation RootViewController

@synthesize showingMonkey = _showingMonkey;
@synthesize fullScreenView = _fullScreenView;
@synthesize window = _window;

// Handles generating the core window layout frame on legacy startup
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showingMonkey = YES;
    
    // Set up the full-screen 480x320 landscape canvas boundaries
    self.fullScreenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    self.fullScreenView.image = [UIImage imageNamed:@"monkey.png"];
    self.fullScreenView.contentMode = UIViewContentModeScaleToFill;
    self.fullScreenView.userInteractionEnabled = YES;
    [self.view addSubview:self.fullScreenView];
    
    // Wire up the full-screen input sensor
    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenTap:)];
    [self.fullScreenView addGestureRecognizer:screenTap];
}

- (void)handleScreenTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        // Triggers the retro cross-dissolve frame swap transition
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

// 🚀 THE EMULATOR CRASH FIX: Using classic memory pool hooks for touchHLE
int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"RootViewController");
    [pool release];
    return retVal;
}
