enum CharityType { zakat, sadaqa, interest, notAssigned }

extension CharityTypeExtension on CharityType {
  String rawValue() {
    switch (this) {
      case CharityType.zakat:
        return "Zakat";

      case CharityType.sadaqa:
        return "Sadaqa";

      case CharityType.interest:
        return "Interest";

      case CharityType.notAssigned:
        return "Not Assigned";
    }
  }
}
