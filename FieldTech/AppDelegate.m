//
//  BNRAppDelegate.m
//  FieldTech
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    NSLog(@"要求返回一个动画控制器 Animation Controller");
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

// 返回转场动画应该持续多长时间（以秒为单位）
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 2.0;
}

// 具体的转场动画实现代码在这里
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //  1.  拿到目标 viewController
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //  2.  创建一个目标 viewController 的截图，并让它先是全透明状态（即不可见）
    UIView *toViewSnapshot = [toVC.view snapshotViewAfterScreenUpdates:YES];
    toViewSnapshot.alpha = 0.0;
    
    //  3.  将这个截图放入动画的容器中，即 container view
    UIView *container = [transitionContext containerView];
    [container addSubview:toViewSnapshot];
    
    //  4.  开始动画，简单地渐隐渐现效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewSnapshot.alpha = 1.0;
    } completion:^(BOOL finished) {
        [toViewSnapshot removeFromSuperview];
        [container addSubview:toVC.view];
        [transitionContext completeTransition:YES];
    }];
}

@end
