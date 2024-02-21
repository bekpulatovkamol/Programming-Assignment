import 'dart:core';
import 'dart:io';
int totalMoney = 0;
void main(){
  int? a = 3;
  print(
      "Welcome to our Restaurant\n"
      "Please make a choice:\n"
      "Admin - 1\n"
      "Waiter - 2\n"
      "User - 3\n"
      "Your choice:"
      );
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      admin_login();
      break;
    case 2:
      waiter_login();
      break;
    case 3:
      user_login_or_register();
      break;
    case null:
      main();
      break;
    default:
      main();
  }
}
///admin_login method
void admin_login(){
  String? login;
  String? password;
  print("Please enter your login:");
  login = stdin.readLineSync();
  if(login != admin_info["login"]){
    print("Login is Invalid!\nPlease enter your login correctly!");
    admin_login();
  }
  else if(login == admin_info["login"]){
    print("Please enter your password:");
    password = stdin.readLineSync();
    if(password != admin_info["password"]){
      print("Password is Invalid\nPlease enter your login and password correctly!");
      admin_login();
    }
    else if(password == admin_info["password"]){
      print("Successfully logged in!");
      admin_panel();
    }
  }
}

///admin panel
void admin_panel(){
  int? a;
  print("\nWelcome to Admin Panel!\n"
      "Available Actions:\n"
      "View Waiters Info - 1\n"
      "Edit Waiters info - 2\n"
      "View Menu - 3\n"
      "Edit Menu - 4\n"
      "View Users Database - 5\n"
      "View User's Order - 6\n"
      "Go back to Main Menu - 7\n"
      "Exit - 0\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      view_waiters_info();
      break;
    case 2:
      edit_waiter_info();
      break;
    case 3:
      view_menu();
      break;
    case 4:
      edit_menu();
      break;
    case 5:
      user_info();
      break;
    case 6:
      view_users_order();
      break;
    case 7:
      main();
      break;
    case 0:
      exit(0);
    case null:
      admin_panel();
      break;
    default:
      admin_panel();
  }
}

///view_waiters_info
void view_waiters_info(){
  print("------All Waiters Database------");
  for(int i = 0; i < waiters_logins.length; i++){
    print("Waiter number ${i + 1}: Login - ${waiters_logins[i]}; Password - ${waiters_passwords[i]}");
  }
  admin_panel();
}

///edit_waiter_info
void edit_waiter_info(){
  int? a;
  print("\nAvailable Actions:\n"
      "Add new Waiter - 1\n"
      "Edit Waiters Logins and Passwords - 2\n"
      "Remove Waiter - 3\n"
      "Back - 4\n"
      "Go back to Main Menu - 5\n"
      "Exit - 0\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      new_waiter_register();
      break;
    case 2:
      edit_waiter_login_and_password();
      break;
    case 3:
      remove_waiter();
      break;
    case 4:
      admin_panel();
      break;
    case 5:
      main();
      break;
    case 0:
      exit(0);
    case null:
      edit_waiter_info();
      break;
    default:
      edit_waiter_info();
  }
}

///new_waiter_register
void new_waiter_register(){
  String? new_login;
  String? new_password;
  print("Please enter new login:");
  new_login = stdin.readLineSync();
  print("Please enter new password:");
  new_password = stdin.readLineSync();
  waiters_logins.add(new_login!);
  waiters_passwords.add(new_password!);
  print("New login and password added!");
  admin_panel();
}

///edit_waiter_login_and_password
void edit_waiter_login_and_password(){
  print("Please enter the login of the waiter to edit:");
  String? login = stdin.readLineSync();

  int index = waiters_logins.indexOf(login!);
  if(index != -1){
    String removedLogin = waiters_logins.removeAt(index);
    waiters_passwords.removeAt(index);
    print("Enter the new login for $removedLogin:");
    String? newLogin = stdin.readLineSync();
    print("Enter the new password for $removedLogin:");
    String? newPassword = stdin.readLineSync();
    waiters_logins.insert(index, newLogin!);
    waiters_passwords.insert(index, newPassword!);
    print("Waiter $removedLogin has been successfully updated.\n");
    admin_panel();
  }
  else{
    print("Waiter not found. Please enter a valid login.\n");
    edit_waiter_login_and_password();
  }
}

///remove_waiter
void remove_waiter(){
  print("\nPlease enter the login of the waiter to remove:");
  String? login = stdin.readLineSync();

  int index = waiters_logins.indexOf(login!);
  if(index != -1){
    print("Are you sure you want to delete the waiter with login $login?");
    print("Yes - 1");
    print("No - 2");
    print("Back to menu - 3");
    int? choice = int.tryParse(stdin.readLineSync()!);
    switch(choice){
      case 1:
        String removedLogin = waiters_logins.removeAt(index);
        waiters_passwords.removeAt(index);
        print("Waiter $removedLogin has been successfully deleted.");
        admin_panel();
        break;
      case 2:
        print("Operation canceled.");
        admin_panel();
        break;
      case 3:
        edit_waiter_info();
        break;
      default:
        print("Invalid choice. Please try again.");
        remove_waiter();
    }
  }
  else{
    print("Waiter not found. Please enter a valid login.");
    remove_waiter();
  }
  edit_waiter_info();
}

void view_menu(){
  int? a;
  print("Please select a section:\n"
      "Dishes - 1\n"
      "Drinks - 2\n"
      "Salads - 3\n"
      "Back to Admin Panel - 4\n"
      "Exit - 5\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      print("---------All Dishes---------");
      for(int i = 0; i < dishes.length; i++){
        print('---Price of ${dishes.keys.elementAt(i)}: ${dishes.values.elementAt(i)}---');
      }
      view_menu();
      break;
    case 2:
      print("---------All Drinks---------");
      for(int i = 0; i < drinks.length; i++){
        print('---Price of ${drinks.keys.elementAt(i)}: ${drinks.values.elementAt(i)}---');
      }
      view_menu();
      break;
    case 3:
      print("---------All Salads---------");
      for(int i = 0; i < salads.length; i++){
        print('---Price of ${salads.keys.elementAt(i)}: ${salads.values.elementAt(i)}---');
      }
      view_menu();
      break;
    case 4:
      admin_panel();
      break;
    case 5:
      exit(0);
    case null:
      view_menu();
      break;
  }
}

void edit_menu(){
  int? a;
  print("Please select a section:\n"
      "Add New Meal - 1\n"
      "Edit Meal - 2\n"
      "Delete Meal - 3\n"
      "View Edited Menu - 4\n"
      "Go back to Admin Panel - 5\n"
      "Exit - 0\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      add_meal();
      break;
    case 2:
      edit_meal();
      break;
    case 3:
      remove_meal();
      break;
    case 4:
      view_menu();
      break;
    case 5:
      admin_panel();
      break;
    case 0:
      exit(0);
    case null:
      edit_menu();
      break;
  }
}

void add_meal(){
  int? a;
  print("Please select a section:\n"
      "Dishes - 1\n"
      "Drinks - 2\n"
      "Salads - 3\n"
      "Back to Admin Panel - 4\n"
      "Exit - 5\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      print("---------All Dishes---------");
      for(int i = 0; i < dishes.length; i++){
        print('---Price of ${dishes.keys.elementAt(i)}: ${dishes.values.elementAt(i)}---');
      }
      String? new_dish_name;
      int? price;
      print("\nPlease enter new dish name:");
      new_dish_name = stdin.readLineSync();
      print("Please enter new dish price:");
      price = int.tryParse(stdin.readLineSync()!);
      if(price != null){
        dishes[new_dish_name!] = price;
        print("$new_dish_name has been successfully added to the menu with price $price.\n");
      }
      else{
        print("Invalid price. Please enter a valid integer.\n");
      }
      admin_panel();
      break;
    case 2:
      print("---------All Drinks---------");
      for(int i = 0; i < drinks.length; i++){
        print('---Price of ${drinks.keys.elementAt(i)}: ${drinks.values.elementAt(i)}---');
      }
      String? new_dish_name;
      int? price;
      print("\nPlease enter new drink name:");
      new_dish_name = stdin.readLineSync();
      print("Please enter new drink price:");
      price = int.tryParse(stdin.readLineSync()!);
      if(price != null){
        drinks[new_dish_name!] = price;
        print("$new_dish_name has been successfully added to the menu with price $price.\n");
      }
      else{
        print("Invalid price. Please enter a valid integer.\n");
      }
      admin_panel();
      break;
    case 3:
      print("---------All Salads---------");
      for(int i = 0; i < salads.length; i++){
        print('---Price of ${salads.keys.elementAt(i)}: ${salads.values.elementAt(i)}---');
      }
      String? new_dish_name;
      int? price;
      print("\nPlease enter new salad name:");
      new_dish_name = stdin.readLineSync();
      print("Please enter new salad price:");
      price = int.tryParse(stdin.readLineSync()!);
      if(price != null){
        salads[new_dish_name!] = price;
        print("$new_dish_name has been successfully added to the menu with price $price.\n");
        admin_panel();
      }
      else{
        print("Invalid price. Please enter a valid integer.\n");
        add_meal();
      }
      break;
    case 4:
      admin_panel();
      break;
    case 5:
      exit(0);
    case null:
      add_meal();
      break;
    default:
      add_meal();
  }
}

///edit_meal
void edit_meal(){
  int? a;
  print("Please select a section:\n"
      "Dishes - 1\n"
      "Drinks - 2\n"
      "Salads - 3\n"
      "Back to Admin Panel - 4\n"
      "Exit - 5\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      print("---------All Dishes---------");
      for(int i = 0; i < dishes.length; i++){
        print('---Price of ${dishes.keys.elementAt(i)}: ${dishes.values.elementAt(i)}---');
      }
      print("\nEnter the name of the dish to remove:");
      String? dishName = stdin.readLineSync();
      if(dishes.containsKey(dishName)){
        dishes.remove(dishName);
        print("$dishName removed from the menu.\n");
        for(int i = 0; i < dishes.length; i++){
          print('Price of ${dishes.keys.elementAt(i)}: ${dishes.values.elementAt(i)}');
        }
        String? new_dish_name;
        int? price;
        print("\nPlease enter new dish name:");
        new_dish_name = stdin.readLineSync();
        print("Please enter new dish price:");
        price = int.tryParse(stdin.readLineSync()!);
        if (price != null){
          dishes[new_dish_name!] = price;
          print("$new_dish_name has been successfully added to the menu with price $price.\n");
        }
        else{
          print("Invalid price. Please enter a valid integer.\n");
        }
      }
      else{
        print("$dishName not found in the menu.\n");
      }
      break;
    case 2:
      print("---------All Drinks---------");
      for(int i = 0; i < drinks.length; i++){
        print('---Price of ${drinks.keys.elementAt(i)}: ${drinks.values.elementAt(i)}---');
      }
      print("\nEnter the name of the drink to remove:");
      String? dishName = stdin.readLineSync();
      if(drinks.containsKey(dishName)){
        drinks.remove(dishName);
        print("$dishName removed from the menu.\n");
        String? new_dish_name;
        int? price;
        print("Please enter new drink name:");
        new_dish_name = stdin.readLineSync();
        print("Please enter new drink price:");
        price = int.tryParse(stdin.readLineSync()!);
        if(price != null){
          drinks[new_dish_name!] = price;
          print("$new_dish_name has been successfully added to the menu with price $price.\n");
          admin_panel();
        }
        else{
          print("Invalid price. Please enter a valid integer.\n");
          edit_meal();
        }
      }
      else{
        print("$dishName not found in the menu.\n");
        edit_meal();
      }
      break;
    case 3:
      print("---------All salads---------");
      for(int i = 0; i < salads.length; i++){
        print('---Price of ${salads.keys.elementAt(i)}: ${salads.values.elementAt(i)}---');
      }
      print("\nEnter the name of the salad to remove:");
      String? dishName = stdin.readLineSync();
      if(salads.containsKey(dishName)){
        salads.remove(dishName);
        print("$dishName removed from the menu.\n");
        String? new_dish_name;
        int? price;
        print("Please enter new salad name:");
        new_dish_name = stdin.readLineSync();
        print("Please enter new salad price:");
        price = int.tryParse(stdin.readLineSync()!);
        if(price != null){
          salads[new_dish_name!] = price;
          print("$new_dish_name has been successfully added to the menu with price $price.\n");
          admin_panel();
        }
        else{
          print("Invalid price. Please enter a valid integer.\n");
          edit_meal();
        }
      }
      else{
        print("$dishName not found in the menu.\n");
        edit_meal();
      }
      break;
    case 4:
      admin_panel();
      break;
    case 5:
      exit(0);
    case null:
      edit_meal();
      break;
    default:
      edit_meal();
  }
}

///remove_meal
void remove_meal(){
  int? a;
  print("Please select a section:\n"
      "Dishes - 1\n"
      "Drinks - 2\n"
      "Salads - 3\n"
      "Back to Admin Panel - 4\n"
      "Exit - 5\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      print("---------All Dishes:---------");
      for(int i = 0; i < dishes.length; i++){
        print('---Price of ${dishes.keys.elementAt(i)}: ${dishes.values.elementAt(i)}---');
      }
      print("\nEnter the name of the dish to remove:");
      String? dishName = stdin.readLineSync();
      if (dishes.containsKey(dishName)) {
        dishes.remove(dishName);
        print("$dishName removed from the menu.\n");
        admin_panel();
      } else {
        print("$dishName not found in the menu.\n");
        remove_meal();
      }
      break;
    case 2:
      print("---------All Drinks---------");
      for(int i = 0; i < drinks.length; i++){
        print('---Price of ${drinks.keys.elementAt(i)}: ${drinks.values.elementAt(i)}---');
      }
      print("\nEnter the name of the drink to remove:");
      String? dishName = stdin.readLineSync();
      if (drinks.containsKey(dishName)) {
        drinks.remove(dishName);
        print("$dishName removed from the menu.\n");
        admin_panel();
      }
      else {
        print("$dishName not found in the menu.\n");
        remove_meal();
      }
      break;
    case 3:
      print("---------All salads:---------");
      for(int i = 0; i < salads.length; i++){
        print('---Price of ${salads.keys.elementAt(i)}: ${salads.values.elementAt(i)}---');
      }
      print("\nEnter the name of the salad to remove:");
      String? dishName = stdin.readLineSync();
      if(salads.containsKey(dishName)){
          salads.remove(dishName);
          print("$dishName removed from the menu.\n");
          admin_panel();
      }
      else{
        print("$dishName not found in the menu.\n");
        remove_meal();
      }
      break;
    case 4:
      admin_panel();
      break;
    case 5:
      exit(0);
    case null:
      edit_meal();
      break;
    default:
      remove_meal();
  }
}

///user information
void user_info(){
  print("---------All Users Information:---------");
  for(int i = 0; i < user_login_pass.length; i++){
    print("User number ${i + 1}: Name - ${user_names.values.elementAt(i)}; Surname - ${user_surnames.values.elementAt(i)}; Age - ${user_ages.values.elementAt(i)}; Login - ${user_login_pass.keys.elementAt(i)}; Password - ${user_login_pass.values.elementAt(i)}");
  }
  admin_panel();
}

///view user's order
void view_users_order(){
  int totalPrice = 0;
  print("\n-----Order Summary-----");
  for(var item in orderItems){
    totalPrice += getItemPrice(item);
    print("$item - \$${getItemPrice(item)}");
  }
  print("Total Price: \$${totalPrice}");
  admin_panel();
}

///admin information such as a login and password
Map<String, String> admin_info = {
  "login":"bekpulatov_kamol",
  "password":"admin123"
};

///dishes
Map<String, int> dishes = {
  'Beef Burger': 186750,
  'Chicken Tika Masala': 149400,
  'Beef Stir Fry': 224100,
  'Chicken Caesar Salad': 124500,
  'Beef Fajitas': 249000,
  'Chicken Parmesan': 174300,
  'Beef Tenderloin Steak': 311250,
  'Chicken Alfredo Pasta': 199200,
  'Beef Sharma Wrap': 161850,
  'Chicken Satay Skewers': 137550,
};
///drinks
Map<String, int> drinks = {
  'Iced Tea': 50000,
  'Mojito': 70000,
  'Lemonade': 45000,
  'Green Smoothie': 60000,
  'Sparkling Water': 35000
};
///salads
Map<String, int> salads = {
  'Garden Salad': 80000,
  'Caesar Salad': 85000,
  'Greek Salad': 90000,
  'Caresse Salad': 95000,
  'Cobb Salad': 85000
};

///waiter_login method
void waiter_login(){
  String? login;
  String? password;
  print("\nPlease enter your login:");
  login = stdin.readLineSync();
  int index = waiters_logins.indexOf(login!);
  if(index != 1){
    print("Please enter your password:");
    password = stdin.readLineSync();
    if(password == waiters_passwords[index]){
      print("Successfully logged in!\n");
      waiter_panel();
    }
    else{
      print("Password is incorrect. Please enter your data again!\n");
      waiter_login();
    }
  }
  else{
    print("Please enter your login again\n");
    waiter_login();
  }
}

///panel of waiters
void waiter_panel(){
  int? choice;
  print("\nWelcome to Waiter Panel!\n"
      "Available Actions:\n"
      "View Orders - 1\n"
      "Take an Order - 2\n"
      "View Balance - 3\n"
      "Go back to Main Menu - 4\n"
      "Exit - 0\n"
      "Your choice:");
  choice = int.tryParse(stdin.readLineSync()!);
  switch(choice){
    case 1:
      view_orders();
      break;
    case 2:
      take_an_order();
      break;
    case 3:
      view_my_balance();
      break;
    case 4:
      main();
      break;
    case 0:
      exit(0);
    case null:
      waiter_panel();
      break;
    default:
      waiter_panel();
      break;
  }
}

///
void view_orders(){
  int totalPrice = 0;
  print("\n-----User's Order Summary-----");
  for(var item in orderItems){
    totalPrice += getItemPrice(item);
    print("$item - \$${getItemPrice(item)}");
  }
  print("Total Price of User: \$${totalPrice}");
  waiter_panel();
}

///
void take_an_order(){
  String? answer;
  print("Are you sure to take a order from User?\n"
      "Enter 'yes' for confirmation\n"
      "Enter 'no' for cancel confirmation\n"
      "Enter '0' for back to Waiter Panel\n"
      "Your choice:");
  answer = stdin.readLineSync();
  switch(answer){
    case "yes":
      print("Order taken by You!");
      orderItems.clear();
      waiter_panel();
      break;
    case "no":
      print("Order take canceled");
      waiter_panel();
      break;
    case "0":
      waiter_panel();
      break;
    default:
      take_an_order();
  }
  waiter_panel();
}

///view balance of waiters
void view_my_balance(){
  int totalPrice = 0;
  print("\n-----Your Balance Summary-----");
  for(var item in orderItems){
    totalPrice += getItemPrice(item);
  }
  print("\$${totalPrice}");
  waiter_panel();
}

///waiters information such as a login and password
List<String> waiters_logins = [
  "kamol123",
  "yunus456",
  "tolib789",
  "shoxruh123"
];

List<String> waiters_passwords = [
  "pass_kamol123",
  "pass_yunus456",
  "pass_tolib789",
  "pass_shoxruh123"
];

///user_login_or_register
void user_login_or_register(){
  int? a;
  print("Please make a choice:\n"
      "Registration - 1\n"
      "Log In - 2\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      user_register();
      break;
    case 2:
      user_login();
      break;
    case null:
      user_login_or_register();
      break;
    default:
      user_login_or_register();
  }
}

///user_register
void user_register(){
  String? name;
  String? surname;
  String? new_login;
  String? new_password;
  int? age;

  print("\nPlease enter your name:");
  name = stdin.readLineSync();

  print("Please enter your surname:");
  surname = stdin.readLineSync();

  // Prompt the user to enter age until a valid numeric value is provided
  while (true) {
    print("Please enter your age:");
    String? ageInput = stdin.readLineSync();

    // Check if the input is a valid integer
    if (ageInput != null && int.tryParse(ageInput) != null) {
      age = int.parse(ageInput);
      break;
    } else {
      print("Invalid age! Please enter a valid numeric value.");
    }
  }

  if(age >= 18){
    print("Please enter your new login:");
    new_login = stdin.readLineSync();
    if(user_login_pass.containsKey(new_login)){
      print("This login is already used! Please use another login!\n");
      user_register();
    }
    else{
      print("Please enter your new password:");
      new_password = stdin.readLineSync();
      user_login_pass[new_login!] = new_password!;
      print("Successfully registered");
      user_names[new_login] = name!;
      user_surnames[new_login] = surname!;
      user_ages[new_login] = age;
      user_panel();
    }
  }
  else if(age < 18){
    print("You are under the registration age!\n");
    main();
  }
}


///user_login
void user_login(){
  String? login;
  String? password;
  print("Please enter your login:");
  login = stdin.readLineSync();
  if(user_login_pass.containsKey(login)){
    print("Please enter your password:");
    password = stdin.readLineSync();
    if(password == user_login_pass[login]){
      print("Successfully logged in!\n");
      user_panel();
    }
    else if(password != user_login_pass[login]){
      print("Password is invalid! Please enter your data carefully!");
      user_login();
    }
  }
  else{
    print("Login is invalid! Please enter your login again!\n");
    user_login();
  }

}

///user_panel
void user_panel(){
  int? a;
  print("\nWelcome to User Panel!\n"
      "Available Actions:\n"
      "Create a order - 1\n"
      "View My orders - 2\n"
      "Cancel All My Orders - 3\n"
      "Go back to Main Menu - 4\n"
      "Exit - 0\n"
      "Your choice:");
  a = int.tryParse(stdin.readLineSync()!);
  switch(a){
    case 1:
      create_order();
      break;
    case 2:
      view_my_orders();
      break;
    case 3:
      cancel_my_orders();
      break;
    case 4:
      main();
      break;
    case 0:
      exit(0);
    case null:
      user_panel();
      break;
    default:
      user_panel();
      break;
  }
}

///create a new order
void create_order() {
  int totalPrice = 0;

  print("---------Menu---------");
  print("---Dishes---");
  dishes.forEach((dish, price) {
    print("$dish - \$${price}");
  });
  print("\n---Drinks---");
  drinks.forEach((drink, price) {
    print("$drink - \$${price}");
  });
  print("\n---Salads---");
  salads.forEach((salad, price) {
    print("$salad - \$${price}");
  });

  while(true){
    if(orderItems.length >= 10){
      print("\nYou have reached the maximum limit of 10 items in your order.");
      break;
    }
    print("\nAdd an item to your order (type 'done' when finished):");
    String? item = stdin.readLineSync();
    if(item == 'done' || item == "Done"){
      break;
    }
    if(dishes.containsKey(item)) {
      orderItems.add(item!);
      totalPrice += dishes[item]!;
    }
    else if(drinks.containsKey(item)){
      orderItems.add(item!);
      totalPrice += drinks[item]!;
    }
    else if(salads.containsKey(item)){
      orderItems.add(item!);
      totalPrice += salads[item]!;
    }
    else{
      print("Invalid item! Please choose from the menu.");
    }
  }
  if(orderItems.isEmpty){
    print("Your order is empty. Please add items to proceed.");
    create_order();
    return;
  }
  print("\n-----Your Order Summary-----");
  for(var item in orderItems){
    print("$item - \$${getItemPrice(item)}");
  }
  print("Total Price: \$${totalPrice}");
  print("\nDo you want to confirm this order?\n"
      "Enter 'yes' for confirmation\n"
      "Enter 'no' for cansel confirmation");
  String? confirmation = stdin.readLineSync();
  if(confirmation!.toLowerCase() == 'yes'){
    print("Order confirmed! Your order will be processed.");
    user_panel();
  }
  else if(confirmation.toLowerCase() == 'no'){
    print("Order canceled.");
    orderItems.clear();
    user_panel();
  }
  else{
  print("Order canceled.");
  orderItems.clear();
  create_order();
  }
  totalMoney = totalPrice;
}

int getItemPrice(String item){
  if(dishes.containsKey(item)) {
    return dishes[item]!;
  }
  else if(drinks.containsKey(item)){
    return drinks[item]!;
  }
  else if(salads.containsKey(item)){
    return salads[item]!;
  }
  else{
    return 0;
  }
}

///view user's order
void view_my_orders() {
  int totalPrice = 0;
  print("\n-----Your Order Summary-----");
  for(var item in orderItems){
    totalPrice += getItemPrice(item);
    print("$item - \$${getItemPrice(item)}");
  }
  print("Total Price: \$${totalPrice}");
  
  user_panel();
}

///cansel user's order
void cancel_my_orders(){
  String? answer;
  print("Do you sure to cansel all your orders? (yes/no)");
  answer = stdin.readLineSync();
  if(answer == "yes"){
      orderItems.clear();
      print("Your order has been canceled.");
      user_panel();
  }
  else if(answer == "no"){
    user_panel();
  }
  else{
    cancel_my_orders();
  }
}


///order of user
List<String> orderItems = [

];

///user names
Map<String, String> user_names = {
  "kamol321":"Kamol"
};

///user surnames
Map<String, String> user_surnames = {
  "kamol321":"Bekpulatov"
};

///user ages
Map<String, int> user_ages = {
  "kamol321":18
};

///user logins and passwords
Map<String, String> user_login_pass= {
  "kamol321":"pass_kamol321",
};