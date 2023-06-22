# ZitecUtils

## Coordinator 

- **CoordinatorBinding** : Router used for sending navigation actions notifications that will be binded in the coordinator. 
- **FlowCoordinator**: Protocol that defines the behaviour of a coordinator such as its starting point and how it should be shown. 
- **NavigationFlowCoordinator**: Base implementation for *FlowCoordinator* that initialises an *UINavigationController* and its root based on the provided parent and transition. 

## Extensions 

### Bundle extensions 

- `releaseVersionNumber`: The current version for the build (e.g 1.0.0)
- `buildVersionNumber`: The current build number for the current version (e.g 1)

### Collection extensions 

- `subscript (safe index: Index) -> Element?`: Returns the element at a provided index or nil if the index is out of bounds. 
- `init(repeating: [Element], count: Int)` : Returns a new array repeating the provided sub-array for `count` times. 
- `func chunked(into size: Int) -> [[Element]]`: Array of current elements split in subarrays of given size.
- `func repeated(count: Int) -> [Element]`: Returns the same array repeated for `count` times. 

### String extensions 

**Properties**

- `base64Encoded`: Current string transformed into utf8 data representation and encoded with base64 
- `notEmpty`: Checks if the current string is empty and without newlines or whitespaces. 
- `withoutWhitespaces`: Returns a new string without additional whitespaces. Keeps only one if more exist.
- `removingAllWhitespaces`: Returns a new string without additional whitespaces. Keeps none. 
- `withoutNewlines`: Returns a new string without additional new lines. Keeps only one if more exist.

**Methods**

- `mutating func condenseWhitespaces()`: Removes additional whitespaces from the current string. Keeps only one if more exist.
- `mutating func condenseNewlines()`: Removes additional new lines from the current string. Keeps only one if more exist.
- `mutating func condenseWhitespacesAndNewlines()`: Removes additional whitespaces / new lines from the current string. Keeps only one if more exist.
- `func substring(from: Int, to: Int) -> String`: Returns a substring from the given string with given start and end positions. 
- `func substring(range: NSRange) -> String`: Returns a substring from a given *NSRange*

### UInt64 extensions 

- `static func toNanoseconds(from seconds: Double) -> UInt64`: Converts seconds to nanoseconds 
- `func toSeconds() -> Double`: Converts the current value to seconds

### URLSession extensions 

- `func asyncData(from request: URLRequest) async throws -> (Data, URLResponse)`:  Replacing method for Swift's async await that is available from iOS 15+
- `func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T]`: async await for mapping elements in array

### UIKit extensions 

- `func container<Content: View>(with swiftUI: Content) -> UIView`:  extension on both *UIView* and *UIViewController* that converts a SwiftUI view to an UIView using *UIHostingController*

### TextStyle 

- Structure that allows SwiftUI view customisation with *Font* and *Color*
- Used in `.styleText(with textStyle: TextStyle` view modifier
```swift
struct TextStyle {
    let font: Font
    let color: Color
}
```
Example usage: 
```swift
Text("Hello world")
    .styleText(with: TextStyle(font: .bold, color: .black)
```

## Utils 

### Console Logging 

Console logging for network layer based on [CocoaLumberjack framework](https://github.com/CocoaLumberjack/CocoaLumberjack)

**Methods**

- `func log(_ request: URLRequest)`: Logs to the console the URL of the request, the headers and the HTTP body if given. 
- `func log(_ response: URLResponse, _ data: Data)`: Logs to the console the URL of the request, the code of the response and the JSON data received from the API. 
- `func log(_ error: Error)` : Logs to the console the *URLError*
