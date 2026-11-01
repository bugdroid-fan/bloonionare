#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIApplicationDelegate> {
    UIImage *monkeyImg;
    UIImage *textImg;
    // 🛡️ THE CRASH FIX: Prevents touch collisions from overlapping inside the emulator
    BOOL isProcessingTouch;
}
@property (nonatomic, assign) BOOL showingMonkey;
@property (nonatomic, retain) UIImageView *fullScreenView;
@property (nonatomic, retain) UIWindow *window;
@end

@implementation RootViewController

@synthesize showingMonkey = _showingMonkey;
@synthesize fullScreenView = _fullScreenView;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
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
    isProcessingTouch = NO;
    
    // Load the assets directly into permanent memory variables
    monkeyImg = [[UIImage imageNamed:@"monkey.png"] retain];
    textImg = [[UIImage imageNamed:@"text.png"] retain];
    
    // 🗺️ HORIZONTAL LANDSCAPE FIX:
    // We bind the container layout to a clean 320x480 coordinate layout, but apply 
    // a 90-degree rotation matrix to pivot the graphics sideways inside iDared!
    self.fullScreenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.fullScreenView.center = self.view.center;
    self.fullScreenView.transform = CGAffineTransformMakeRotation(M_PI / 2.0); // Perfect 90-degree landscape turn!
    self.fullScreenView.image = monkeyImg;
    self.fullScreenView.contentMode = UIViewContentModeScaleAspectFit;
    self.fullScreenView.userInteractionEnabled = YES;
    [self.view addSubview:self.fullScreenView];
}

// 🚀 ZERO-CRASH TOUCH CONTROLLER: Pure, isolated single-execution loop
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // If a touch cycle is already being processed, immediately drop this block!
    if (isProcessingTouch) return;
    isProcessingTouch = YES;
    
    if (self.showingMonkey) {
        self.fullScreenView.image = textImg;
        self.showingMonkey = NO;
    } else {
        self.fullScreenView.image = monkeyImg;
        self.showingMonkey = YES;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Release the touch block lock only after your finger completely leaves the glass surface
    isProcessingTouch = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    isProcessingTouch = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc {
    [monkeyImg release];
    [textImg release];
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
