//
//  AppDelegate.h
//  MyFavoritesListObjc
//
//  Created by Kevin Yan on 4/20/18.
//  Copyright © 2018 Kevin Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

