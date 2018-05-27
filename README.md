# SourceryPlayground
_Type safety for generating Sourcery Swift templates_.

[Sourcery](https://github.com/krzysztofzablocki/Sourcery) is a widely-popular code generation library for Swift development. Given a template and Swift input file(s), Sourcery can generate additional code for your project. This repository is meant to assist developers in writing their own Sourcery templates.

## Background

Developers can write templates in Swift via files with the `.swifttemplate` extension. There exists some brief [Sourcery documentation on the format](https://cdn.rawgit.com/krzysztofzablocki/Sourcery/master/docs/writing-templates.html), but in essence, the templates are just Swift files leveraging the [SourceryRuntime source files located here](https://github.com/krzysztofzablocki/Sourcery/tree/4e920792664029203820fba1a63ba4ba925f552e/SourceryRuntime/Sources) with some syntax to distinguish codegen output versus control flow. However, as you’re writing `.swifttemplate` files instead of actual `.swift` files, developers usually can't take advantage of type safety or autocomplete as they’re writing these templates. That is where this playground can help.

## Usage

**TL;DR run the Playground and play with the contained source code.**

```swift
// For an enum with (intValue: Int) as an associated type,
// and a suffix of "LHS", returns "(let intValueLHS)"
func associatedValueList(enumCase: EnumCase, suffix: String) -> String {
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
```

Write your `.swifttemplate` helper functions in `Playground.playground`, which has the `SourceryRuntime` files dropped in. Then, when you're ready to test the output, drop the code into your project.

_You can't yet provide test cases right in the Playground, because there isn't a convenient way to stub the Sourcery models, such as `EnumCase` above._

## Updating Sourcery

### The Automated Part

The `update_sourcery.sh` script clones the Sourcery repository and copies the files in the `SourceryRuntime` directory into the Playground's sources.

### The Manual Part

Xcode Playgrounds can get a [no such module error](https://stackoverflow.com/questions/33144877/playground-import-no-such-module-foo#comment54592475_33144877) if any files in its Sources imports a custom module. As so, after running `update_sourcery.sh` , it may be necessary to manually edit the `SourceryRuntime` source files to get the Playground running. It's also possible that the contents of `SourceryRuntime` change in such a way where it's unviable to make the necessary manual edits, and this playground becomes unsupported.

### Current Version

The source files in this playground are from Sourcery **0.13.1** See the [diffs from any manual source file edits here](https://github.com/nevillco/SourceryPlayground/commit/89c43197d0ccb3e00a3dae442a0d4e6cf1f371d3).
