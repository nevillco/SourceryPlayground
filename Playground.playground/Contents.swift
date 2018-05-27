import UIKit

// For an enum with (intValue: Int) as an associated type,
// and a suffix of "LHS", returns "(let intValueLHS)"
func associatedValueList(enumCase: EnumCase, suffix: String) -> String {
    let list = enumCase.associatedValues
        .map({ value in
            guard let name = value.localName else {
                fatalError("AutoEquatable enums should have associated types with labels")
            }
            return "let \(name)\(suffix)"
        })
        .joined(separator: ", ")
    return enumCase.associatedValues.isEmpty ? "" : "(\(list))"
}
