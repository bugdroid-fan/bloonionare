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

// Natively handles building the window canvas for both modern and early runtimes
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([self.window respondsToSelector:@selector(setRootViewController:)]) {
        self.window.rootViewController = self;
    } else {
        [self.window addSubview:self.view];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.showingMonkey = YES;
    
    self.fullScreenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    self.fullScreenView.image = [UIImage imageNamed:@"monkey.png"];
    self.fullScreenView.contentMode = UIViewContentModeScaleToFill;
    
    // We keep user interaction enabled so the view hierarchy passes screen inputs down cleanly
    self.fullScreenView.userInteractionEnabled = YES;
    [self.view addSubview:self.fullScreenView];
    
    // 🛑 GESTURE RECOGNIZERS REMOVED COMPLETELY TO PREVENT EMULATOR CRASHES!
}

// 🚀 THE EMULATION FIX: Pure, retro 2008 hardware touch tracking loop
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Cross-dissolve asset-toggling block
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

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"RootViewController");
    [pool release];
    return retVal;
}
