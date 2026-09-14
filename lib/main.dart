void processOrder({
  required String orderId,
  required double itemprice,
  String? promocode,
  double? deliveryFee,
}){
  double price = itemprice;
  if(promocode == "SAVE10"){
    price = price * 0.9;
  }
  double delivery = deliveryFee ?? 500.0;
  double finalTotal = price + delivery;


  print('OrderId: $orderId');
  print('ItemPrice: $itemprice');
  print('Promocode: $promocode');
  print('Delivery: $delivery ');
  print('FinalTotal: $finalTotal');
}





void main() {

  void total = processOrder(
      orderId: 'Order001',
      itemprice: 10000.0,
      promocode: 'SAVE10',
  );

  // String name = "Bekzat";
  // int age = 25;
  // double gpa = 3.4;
  // bool isStudent = false;
  //
  // print("name : $name\nage: $age y.o.\ngpa: $gpa\nis Teacher: ${!isStudent}");
  //
  // String text1 = "Hello";
  // // String nullText = null; not works
  // String? text2 = null;
  // print('text1: $text1');
  // print('text2: $text2');
  //
  // int length1 = text1.length;
  // int length2 = text2?.length ?? 0;
  // print(length1);
  // print(length2);
  //
  // String confirmedText = text2 ?? "default";
  // print("confirmed $confirmedText length: ${confirmedText.length}");
  //
  // int digit = 3;
  // print("MULTIPLICATION TABLE for digit $digit");
  // for (int i = 1; i <= 10; i++) {
  //   print("$digit * $i = ${i * digit}");
  // }
  //
  // for (int i = 10; i > 0; i--) {
  //   if (i % 2 == 0) {
  //     print("$i");
  //   } else {
  //     print("${i * 2}");
  //   }
  // }


// TASK 1
// OUTPUT MULTIPLICATION TABLE  1-10
//   for (int i = 1; i <= 10; i++) {
//     for (int j = 1; j <= 10; j++) {
//       print("$i*$j=${i * j}");
//     }}
// TASK 2
// next day : examples:
// 05.09.2026 -> 06.09.2026
// 28.02.2024 -> 29.02.2024
// 28.02.2026 -> 01.03.2026
// 29.02.2026 -> invalid date
// 28.02.2100 -> 01.03.2100
// 28.02.2100 -> 29.02.2000
// 31.12.2025 -> 01.01.2026
// 2000,2400 leap year
// 2100,2200,2300 isn`t leap year

  // int day = 32;
  // int month = 12;
  // int year = 2025;
  // int maxDay;
  // if (month == 2) { if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) { maxDay = 29; }
  // else {maxDay = 28; } }
  // else if (month == 4 || month == 6 || month == 9 || month == 11) { maxDay = 30; }
  // else { maxDay = 31; } // Date is invalid
  //  if(day > maxDay) { print("invalid date"); }
  //  else { day++; if (day > maxDay) {day = 1;month++; if (month > 12) {month = 1;year++; } }
  // print("$day.$month.$year"); }



// TASK3
// Vowel Counter in a String -> "flutter mobile development" -> 8
//     String text = "flutter mobile development";
//
//     int countt = 0;
//     String vowels = "aeiou";
//
//     for (int i = 0; i < text.length; i++) {
//       if (vowels.contains(text[i])) {
//         countt++;
//       }
//     }
//
//     print(countt);



// TASK4
// Manual min & max finder
//       List<int> numbers22 = [14, 88, 3, 42, 99, 12, 67]; //-> max: 99, min: 3
//       List<int> numbers11 = [234, 34, 123, 44, 949, 112, 67]; //-> max: 949, min: 34
//       var list = numbers22;
//       int first = numbers22[0];
//       int last = numbers11[numbers11.length - 1];
//
//       int max =0;
//       int min = list[0];
//       for(int i =0;i<list.length;i++){
//         if( max < list[i]){
//           max = list[i];
//         }
//         if( min > list[i]){
//           min = list[i];
//         };
//       }
//       print(max);
//       print(min);

// TASK 5
// Prime Number Checker
// 3 -> prime number
// 6 -> not prime number
//Task 5
//
//   int num = 11;
//   int count = 0;
//   for(int i=1;i<=num;i++){
//     if(num%i == 0){count++;
//     }}
//   if(count == 2) {  print('$num ->prime number');}else{  print('$num -> notprime number');}


      }


