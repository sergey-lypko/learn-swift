// *   *   *   Get access to enum case via raw value  *   *   * 

enum AssociatedNumbers: Int {
  case first = 10
  case second = 20
}

guard let lookingValue = AssociatedNumbers(rawValue: 10) else {
  return
}

print(lookingValue) // first 
