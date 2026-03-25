class Security {
  static bool isValidAmount(double amount) {
    if (amount < 25) return false;
    if (amount % 25 != 0) return false;
    return true;
  }

  static double calculateMonths(double amount) {
    return amount / 25;
  }
}
