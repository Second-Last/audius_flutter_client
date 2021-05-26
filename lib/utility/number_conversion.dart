String convertNumber(int input) {
  if (input < 1000) {
    return input.toString();
  } else if (input < 1000000) {
    return (input / 1000).toStringAsPrecision(3) + "K";
  } else if (input < 1000000000) {
    return (input / 1000000000).toStringAsPrecision(3) + "M";
  } else {
    return (input / 1000000000000).toStringAsPrecision(3) + "B";
  }
}