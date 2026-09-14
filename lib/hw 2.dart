void checkBalance({
  required String name,
  required double balance,
}) =>
    print("$name, your current available balance is: \$${balance.toStringAsFixed(2)}");


// 2
double deposit({
  required double currentBalance,
  double? amount,
}) {
  double depositAmount = amount ?? 0.0;

  if (depositAmount <= 0) {
    print("Deposit failed: Invalid deposit amount.");
    return currentBalance;
  }

  double updatedBalance = currentBalance + depositAmount;

  print("Deposit successful!");
  print("Deposited: \$${depositAmount.toStringAsFixed(2)}");
  print("New balance: \$${updatedBalance.toStringAsFixed(2)}");

  return updatedBalance;
}

// 3
double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  const int correctPin = 1234;

  int enteredPin = pinCode ?? 0000;

  if (enteredPin != correctPin) {
    print("Transaction declined for $name.");
    print("Error: Incorrect PIN.");
    return currentBalance;
  }

  double withdrawAmount = amount ?? 0.0;

  if (withdrawAmount <= 0) {
    print("Transaction declined.");
    print("Error: Invalid withdrawal amount.");
    return currentBalance;
  }

  if (withdrawAmount > currentBalance) {
    print("Transaction declined for $name.");
    print("Error: Insufficient funds.");
    return currentBalance;
  }

  double updatedBalance = currentBalance - withdrawAmount;

  print("Withdrawal successful!");
  print("Withdrawn: \$${withdrawAmount.toStringAsFixed(2)}");
  print("Remaining balance: \$${updatedBalance.toStringAsFixed(2)}");

  return updatedBalance;
}

void main() {
  String name = "Nurali";
  double balance = 1000.0;

  checkBalance(
    name: name,
    balance: balance,
  );

  print("\n--- Deposit ---");

  balance = deposit(
    currentBalance: balance,
    amount: 500.0,
  );

  print("\n--- Withdrawal ---");

  balance = withdraw(
    name: name,
    currentBalance: balance,
    amount: 300.0,
    pinCode: 1234,
  );

  print("\n--- Final Balance ---");

  checkBalance(
    name: name,
    balance: balance,
  );
}