enum FieldType { Name, Username }

extension FieldTypeData on FieldType {


  String get label {
    switch (this) {
      case FieldType.Name:
        return 'Name';
      case FieldType.Username:
        return 'Username';
    }
  }
}
