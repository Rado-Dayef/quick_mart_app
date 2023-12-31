class AppFormats {
  static String myFormatter(text, replaced) {
    List<String> symbolsToReplace = ["(", ")", "[", "]", "{", "}", ",", "/", "_", "-", "!", "@", "#", "%", "^", "&", "*", "."];
    for (String symbol in symbolsToReplace) {
      text = text.replaceAll(symbol, replaced);
    }
    return text.replaceAll("  ", ", ");
  }

  static String formatPhoneNumber(phoneNumber) {
    String formattedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (formattedPhoneNumber.length == 11) {
      return "+2${formattedPhoneNumber.substring(0, 1)} ${formattedPhoneNumber.substring(1, 4)} ${formattedPhoneNumber.substring(4, 7)} ${formattedPhoneNumber.substring(7)}";
    } else {
      return formattedPhoneNumber;
    }
  }
}
