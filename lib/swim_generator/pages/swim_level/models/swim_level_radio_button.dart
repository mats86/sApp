class SwimLevelRadioButton {
  final String name;
  final bool isChecked;

  SwimLevelRadioButton({
    required this.name,
    required this.isChecked,
  });

  factory SwimLevelRadioButton.fromJson(Map<String, dynamic> json) {
    return SwimLevelRadioButton(
      name: json['name'],
      isChecked:
      json['isChecked'] ?? false, // Default-Wert hinzugefügt für Sicherheit
    );
  }

  const SwimLevelRadioButton.empty()
      : name = '',
        isChecked = false;

  bool get isEmpty => name.isEmpty;

  SwimLevelRadioButton copyWith({
    String? name,
    bool? isChecked,
  }) {
    return SwimLevelRadioButton(
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
