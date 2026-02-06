class RetryPolicy {
  static Duration nextDelay(int attempt) {
    return Duration(milliseconds: 200 * attempt * attempt);
  }

  static bool shouldRetry(int attempt) => attempt < 5;
}
