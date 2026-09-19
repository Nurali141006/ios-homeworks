// class Book {
// String title;
// String author;
// double price;
// bool isBorrowed;
//
// Book({
// required this.title,
// required this.author,
// required this.price,
// this.isBorrowed = false,
// });
// }
//
// class Library {
// List<Book> _books = [];
//
// void addBook(Book book) {
// _books.add(book);
// }
//
// List<Book> getAvailableBooks() {
// return _books.where((book) => book.isBorrowed == false).toList();
// }
//
// double getTotalValue() {
// return _books.fold(0.0, (total, book) => total + book.price);
// }
// }
//
// void main() {
// Library library = Library();
//
// library.addBook(Book(
// title: 'Абай жолы',
// author: 'Мұхтар Әуезов',
// price: 25.50,
// ));
//
// library.addBook(Book(
// title: 'Қан мен тер',
// author: 'Әбдіжәміл Нұрпейісов',
// price: 22.00,
// isBorrowed: true,
// ));
//
// library.addBook(Book(
// title: 'Менің атым Қожа',
// author: 'Бердібек Соқпақбаев',
// price: 25.00,
// ));
//
// library.addBook(Book(
// title: 'Ұлпан',
// author: 'Ғабит Мүсірепов',
// price: 30.50,
// ));
//
// print('Available Books:');
//
// for (var book in library.getAvailableBooks()) {
// print('${book.title} by ${book.author} - \$${book.price}');
// }
//
// print('\nTotal Collection Value: \$${library.getTotalValue()}');
// }



abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem(this.id, this.title, this.price);

  String getDetails();
}
mixin Downloadable {
  void download(String title) {
    print("Downloading $title...");
  }
}
class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook(
      String id,
      String title,
      double price,
      this.durationHours,
      this.narrator)
      : super(id, title, price);
  @override
  String getDetails() {
    return "$title - $durationHours hours - Narrator: $narrator - \$$price";
  }
}
class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook(
      String id,
      String title,
      double price,
      this.fileSizeMB,
      this.author)
      : super(id, title, price);
  @override
  String getDetails() {
    return "$title - $fileSizeMB MB - Author: $author - \$$price";
  }
}

class ShoppingCart {
  List<MediaItem> _items = [];
  void addItem(MediaItem item) {
    _items.add(item);
  }
  double calculateTotalWithTax({double taxRate = 0.12}) {
    double total = _items.fold(0, (sum, item) {
      return sum + item.price;
    });
    return total + total * taxRate;
  }
  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) {
      return item.price <= maxPrice;
    }).toList();
  }
  void printReceipt() {
    print("----- RECEIPT -----");
    for (MediaItem item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print("-------------------");
    print("Total: \$${calculateTotalWithTax()}");
  }
}
void main() {
  Audiobook book1 = Audiobook(
    "1",
    "Harry Potter",
    10.0,
    8.0,
    "John",
  );
  EBook book2 = EBook(
    "2",
    "Dart Basics",
    15.0,
    5.0,
    "Mike",
  );
  ShoppingCart cart = ShoppingCart();
  cart.addItem(book1);
  cart.addItem(book2);
  cart.printReceipt();
  print("\nBooks under \$12:");
  List<MediaItem> cheapBooks = cart.filterByMaxPrice(12);
  for (MediaItem item in cheapBooks) {
    print(item.getDetails());
  }
}

