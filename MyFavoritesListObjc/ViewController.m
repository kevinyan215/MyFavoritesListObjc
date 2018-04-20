//
//  ViewController.m
//  MyFavoritesListObjc
//
//  Created by Kevin Yan on 4/20/18.
//  Copyright © 2018 Kevin Yan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController () {
    NSManagedObjectContext *context;
    NSMutableArray *personList;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)add:(UIBarButtonItem *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)add:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Name" message:@"Add a new Name" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self saveWithName:[alert textFields][0].text];
        [self fetchData];
        [_tableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {}];
    [self presentViewController:alert animated:true completion:nil];
}

-(void)saveWithName:(NSString *)name {
    AppDelegate *appDelegate = UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSManagedObject *personObject = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    [personObject setValue:name forKeyPath:@"name"];
    [context save:nil];
}

-(void)fetchData {
    AppDelegate *appDelegate = UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    personList = [context executeFetchRequest:fetchRequest error:nil];
    NSLog(@"%@", personList);
}
@end

@implementation ViewController(DataSource)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *name = [personList[indexPath.row] valueForKey:@"name"];
    cell.textLabel.text = name;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return personList.count;
}

@end


