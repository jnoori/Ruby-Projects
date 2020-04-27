#Airline System Reservation
#*** we have 2 plane, each 10 row and 4 column ***
#global variables 
$session = ""
$airbus = Array.new
$boeing = Array.new
$users = {
  1 => {
    "name" => "Mert",
    "surname" => "Tan",
    "email" => "mert.tan@itdcanada.ca",
    "password" => "123456",
    "roles" => ["admin", "crew"]
  },
  2 => {
    "name" => "Arshia",
    "surname" => "Lak",
    "email" => "arshia.lak@itdcanada.ca",
    "password" => "123456",
    "roles" => ["crew"]
  },
  3 => {
    "name" => "Mahnaz",
    "surname" => "Bagheri",
    "email" => "mahnaz.bagheri@itdcanada.ca",
    "password" => "123456",
    "roles" => ["crew"]
  },
  4 => {
    "name" => "Javad",
    "surname" => "Noori",
    "email" => "javad.noori@itdcanada.ca",
    "password" => "123456",
    "roles" => ["customer"]
  }
}
#***** start of add seat function *****
def addSeat(array, row, column)
  tempColumn = Array.new
  for p in 1..column
    tempColumn[p-1] = 0
  end
  for i in 1..row
    array << tempColumn
  end
  return array
end
#***** end of add seat function *****

#***** start of initialize function *****
def initialize
  for i in 1..10
    addSeat($airbus, 1, 4)
    addSeat($boeing, 1, 4)
  end
end
#***** end of initialize function *****

#***** start of plane_system function *****
def plane_system
  if $session == "" || $session == false
    login
  end
end
#***** end of plane_system function *****

#***** start of login function *****
def login
  puts "====== Welcome to Plane System Reservation ======"
  puts "Please Enter your E-mail"
  email = gets.chomp
  puts "Please Enter Your Password"
  pass = gets.chomp
  result = []
  $users.each do |key, value|
    if email == value["email"] && pass == value["password"]
      puts "The Logged user:"
      puts showUser(key)
      $session = key
      return menu
    end
  end
  if result.include?(true) == false
    puts "Credentials are not matching"
    return login
  else
    return menu
  end
end
#***** end of login function *****

#***** start of logout function *****
def logout
  $session = false
  plane_system
end
#***** start of logout function *****

#***** start of show user function *****
def showUser(id=false)
  if id == false
    $users.each do |key, value|
      puts "#{key} => #{value["name"]}  #{value["surname"]} (#{value["email"]} #{value["roles"]}"
    end
  else
    return "#{$users[id]['name']} #{$users[id]['surname']}"
  end
end
#***** end of show user function *****

#***** start of menu function *****
def menu
  puts "Please choose a following option"
  puts "1) Show Users"
  puts "2) Add a User"
  puts "3) Delete User"
  puts "4) Show Planes"
  puts "5) Make a reservation"
  puts "6) Create a reservation"
  puts "7) Cancel a reservation"
  puts "8) Log Out"
  selectedMenu = gets.chomp.to_i
  if( selectedMenu == 1 )
    showUser
  elsif( selectedMenu == 2 )
    addUser
  elsif( selectedMenu == 3 )
    deleteUser
  elsif( selectedMenu == 4 )
    showPlanes
  elsif( selectedMenu == 5 )
    make_reservation
  elsif( selectedMenu == 6 )
    create_reservation
  elsif( selectedMenu == 7 )
    cancel_reservation
  elsif( selectedMenu == 8 )
    logout
  else
    puts "This menu doesn't exist!"
  end
  kc
end
#***** end of menu function *****

#***** start of show planes function *****
def show_plane(called=false)
  puts $users[$session]["roles"]
  if $users[$session]["roles"].include?("admin")
    $cars.each do |key, value|
      puts "#{key} => #{value["make"]} - #{value["model"]} (#{value["engine"]}cc) / $#{value["price"]}"
    end
  else
    $cars.each do |key, value|
      if value["user_id"] == $session
        puts "#{key} => #{value["make"]} - #{value["model"]} (#{value["engine"]}cc) / $#{value["price"]}"
      end 
    end
  end
  if called == false
    kc
  end
end
#***** end of show planes function *****

#***** start of keep continue function *****
def kc
  puts "Would you like to keep continue"
  puts "1) Yes"
  puts "2) No"
  option = gets.chomp.to_i
  if(option == 1)
    menu
  else
    exit!
  end
end
#***** end of keep continue function *****
initialize
plane_system
puts "Session : #{$session}"
