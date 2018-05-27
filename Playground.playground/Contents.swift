import UIKit

func valueList(for enumCase: EnumCase, suffix: String) -> String {
    let list = enumCase.associatedValues
        .map({ value in
            guard let name = value.localName else {
                fatalError("AutoEquatable enums should have associated types with labels")
            }
            return "\(name)\(suffix)"
        })
        .joined(separator: ", ")
    return enumCase.associatedValues.isEmpty ? "" : "(\(list))"
}

func caseDeclaration(for enumCase: EnumCase) -> String {
    let caseName = enumCase.name
    let lhsList = valueList(for: enumCase, suffix: "LHS")
    let rhsList = valueList(for: enumCase, suffix: "RHS")
    let optionalLet = enumCase.associatedValues.isEmpty ? "" : "let"
    return "case \(optionalLet) (.\(caseName)\(lhsList), .\(caseName)\(rhsList)):"
}
