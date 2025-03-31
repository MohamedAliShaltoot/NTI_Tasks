import 'dart:io';

class Seat {
  bool isBooked;
  User? user;

  Seat() : isBooked = false;

  void book(User user) {
    isBooked = true;
    this.user = user;
  }

  @override
  String toString() => isBooked ? 'B' : 'E';
}

class User {
  final String name;
  final String phone;

  User(this.name, this.phone);
}

class Theater {
  final int rows;
  final int cols;
  late List<List<Seat>> seats;
  final Map<String, User> bookings = {};

  Theater({this.rows = 5, this.cols = 5}) {
    seats = List.generate(rows, (_) => List.generate(cols, (_) => Seat()));
  }

  void bookSeat() {
    while (true) {
      stdout.write("\nEnter row (1-$rows) or 'exit' to quit: ");
      String? rowInput = stdin.readLineSync();
      if (rowInput?.toLowerCase() == 'exit') return;

      stdout.write("Enter column (1-$cols): ");
      String? colInput = stdin.readLineSync();

      int? row = int.tryParse(rowInput ?? '');
      int? col = int.tryParse(colInput ?? '');

      if (row == null ||
          col == null ||
          row < 1 ||
          row > rows ||
          col < 1 ||
          col > cols) {
        print("Invalid seat number, please enter values between 1-$rows.");
        continue;
      }

      row -= 1;
      col -= 1;

      if (seats[row][col].isBooked) {
        print("Seat is already booked. Please choose another seat.");
      } else {
        stdout.write("Enter your name: ");
        String? name = stdin.readLineSync();
        stdout.write("Enter your phone number: ");
        String? phone = stdin.readLineSync();

        if (name != null &&
            phone != null &&
            name.isNotEmpty &&
            phone.isNotEmpty) {
          User user = User(name, phone);
          seats[row][col].book(user);
          bookings['${row + 1},${col + 1}'] = user;
          print("Seat booked successfully!");
          return;
        } else {
          print("Invalid name or phone number, please try again.");
        }
      }
    }
  }

  void showSeats() {
    print("\nTheater Seats:");
    for (var row in seats) {
      print(row.map((seat) => seat.toString()).join(' '));
    }
  }

  void showBookings() {
    if (bookings.isEmpty) {
      print("\nNo bookings yet.");
    } else {
      print("\nUsers Booking Details:");
      bookings.forEach((seat, user) {
        print("Seat $seat: ${user.name} - ${user.phone}");
      });
    }
  }
}

void main() {
  Theater theater = Theater();

  print("Welcome To Our Theater");

  while (true) {
    print("\nPress 1 to book a new seat");
    print("Press 2 to show the theater seats");
    print("Press 3 to show users data");
    print("Press 4 to exit");

    stdout.write("Input => ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        theater.bookSeat();
        break;
      case '2':
        theater.showSeats();
        break;
      case '3':
        theater.showBookings();
        break;
      case '4':
        print("Exiting... Thank you!");
        return;
      default:
        print("Invalid choice, please try again.");
    }
  }
}
