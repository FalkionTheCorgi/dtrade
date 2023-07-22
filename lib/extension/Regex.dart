class RegexData {
  static const email = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  static const password =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,20}$";
  static const battletag = r"#\d{4}";
  static const nameItem = r"^[^\d]*$";
  static const onlyUperLetter = r'\b[A-Z\s]+\b';
  static const identifyItemPower = r"^\d+\s+Item\s+Power$";
  static const identifyTypeItem =
      r'\b(?:Ancestral|Sacred)?\s+(?:Common|Magic|Rare|Legendary|Unique)\s+(?:Axe|Bow|Dagger|Two-Handed Axe|Two-Handed Mace|Staff|Two-Handed Staff|Sword|Two-Handed Sword|Scythe|Two-Handed Scythe|Wand|Mace|Crossbow|Helm|Glove|Pants|Boots|Armor)\b';
  static const identifyLevelItem = r"Requires Level \d+";
  static const onlyNumber = r"^[0-9]+$";
}
