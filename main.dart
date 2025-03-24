import 'dart:io';

void main() {
  List<List<String>> seats = List.generate(5, (_) => List.filled(5, 'E'));

  Map<String, Map<String, String>> bookings = {};

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
        bookSeat(seats, bookings);
        break;
      case '2':
        showSeats(seats);
        break;
      case '3':
        showBookings(bookings);
        break;
      case '4':
        print("\nHave a nice day! Thank you!");
        return;
      default:
        print("Invalid choice, please try again.");
    }
  }
}

void bookSeat(
  List<List<String>> seats,
  Map<String, Map<String, String>> bookings,
) {
  while (true) {
    stdout.write("\nEnter row (1-5) or 'exit' to quit: ");
    String? rowInput = stdin.readLineSync();
    if (rowInput == 'exit') return;

    stdout.write("Enter column (1-5): ");
    String? colInput = stdin.readLineSync();

    int? row = int.tryParse(rowInput ?? '');
    int? col = int.tryParse(colInput ?? '');

    if (row == null ||
        col == null ||
        row < 1 ||
        row > 5 ||
        col < 1 ||
        col > 5) {
      print("Invalid seat number, please enter values between 1-5.");
      continue;
    }

    row -= 1;
    col -= 1;

    if (seats[row][col] == 'B') {
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
        seats[row][col] = 'B';
        bookings['${row + 1},${col + 1}'] = {'Name': name, 'Phone': phone};
        print("Seat booked successfully!");
        return;
      } else {
        print("Invalid name or phone number, please try again.");
      }
    }
  }
}

void showSeats(List<List<String>> seats) {
  print("\nTheater Seats:");
  for (var row in seats) {
    print(row.join(' '));
  }
}

void showBookings(Map<String, Map<String, String>> bookings) {
  if (bookings.isEmpty) {
    print("\nNo bookings yet.");
  } else {
    print("\nUsers Booking Details:");
    bookings.forEach((seat, details) {
      print(
        "Seat ($seat) =>  '{'Name': ${details['Name']}, 'Phone': ${details['Phone']}}' ",
      );
    });
  }
}
