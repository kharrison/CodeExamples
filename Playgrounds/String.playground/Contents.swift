/*:
# Swift String Cheat Sheet

A quick guide to using Strings with Swift.

 By Keith Harrison - [useyourloaf.com](https://useyourloaf.com)

 Last Update: **23 September 2017 for Swift 4 (Xcode 9)**

 See Also: [Swift String Cheat Sheet](https://useyourloaf.com/blog/swift-string-cheat-sheet/)
*/

//: ## Setup
//: Import Foundation if you want to bridge to NSString
import Foundation

//: ## Initializing a String
var emptyString = ""        // Empty String
var stillEmpty = String()   // Another empty String
let helloWorld = "Hello World!" // String inferred

let a = String(true)        // from boolean: "true"
let b: Character = "A"      // Explicit type required to create a Character
let c = String(b)           // from character "A"
let d = String(3.14)        // from Double "3.14"
let e = String(1000)        // from Int "1000"
let f = "Result = \(d)"     // Interpolation "Result = 3.14"
let g = "\u{2126}"          // Unicode Ohm sign Ω

//: ### Creating a String by repeating values
let h = String(repeating:"01", count:3) // 010101

//: ### Creating a String from a file (in the Resources folder)
if let txtPath = Bundle.main.path(forResource: "lorem", ofType: "txt") {
  do {
    let lorem = try String(contentsOfFile: txtPath, encoding: .utf8)
    print(lorem)
  } catch {
    print("Something went wrong")
  }
}

/*:
 ### Multi-line string literals (Swift 4)
  Swift now allows you to create a multi-line String literals. You wrap the strings in triple double quotes (`"""String"""`). You do not need to escape newlines and quotes within the string:
 */
let verse = """
    To be, or not to be - that is the question;
    Whether 'tis nobler in the mind to suffer
    The slings and arrows of outrageous fortune,
    Or to take arms against a sea of troubles,
    """
/*:
You can control the leading white space with the indentation of the text relative to the closing `"""`. In the last example there is no leading whitespace in the final string literal. In this next example we indent the text by two spaces:
 */
let indentedText = """
    Hello, this text is indented by
    two spaces from the closing quotes
  """
/*:
 Source code with overly long string literals can be hard to read. To split long lines in the source use a \ to escape the new line.
 */
let singleLongLine = """
    This is a much longer line split \
    over two lines by escaping the newline.
    """

/*:
 ## Strings are Value Types
 Strings are value types that are copied when assigned
 or passed to a function. The copy is performed lazily
 on mutation.
 */
var aString = "Hello"
var bString = aString
bString += " World!"
print("\(aString)")   // "Hello\n"

//: ### Testing For Empty
let name = ""
name.isEmpty   // true

let title = String()
title.isEmpty  // true

/*:
 ### Testing for equality

 Swift is Unicode correct so the equality operator
 (“==”) checks for Unicode canonical equivalence.
 This means that two Strings that are composed from
 different Unicode scalars will be considered equal
 if they have the same linguistic meaning and appearance:
 */
let spain = "España"
let tilde = "\u{303}"
let country = "Espan" + "\(tilde)" + "a"
if country == spain {
  print("Matched!")       // "Matched!\n"
}

//: ### Order
if "aaa" < "bbb" {
  print("aaa is less than bbb")
}

//: ### Testing for suffix/prefix
let line = "0001 Some test data here %%%%"
line.hasPrefix("0001")    // true
line.hasSuffix("%%%%")    // true

//: ### Converting to upper/lower case
let mixedCase = "AbcDef"
let upper = mixedCase.uppercased() // "ABCDEF"
let lower = mixedCase.lowercased() // "abcdef"

/*:
 ## Views

 In Swift 4 Strings are back to being collections of
 characters. You can access different representations
 of the string through the appropriate collection view.
 */
country.characters       // characters
country.unicodeScalars   // Unicode scalar 21-bit codes
country.utf16            // UTF-16 encoding
country.utf8             // UTF-8 encoding

/*:
 ### Strings Are Collections Of Characters (Swift 4)

 The `CharacterView` is now the default when you are
 working with a `String`. The following two loops
 are equivalent in Swift 4
 */

// Swift 4
for character in country {
    print(character)
}

// Swift 3 (still works in Swift 4)
for character in country.characters {
    print(character)
}

/*:
 ### Counting

 Count is implemented for each of the collection views
 as it is dependent on the representation. The `count`
 property of a String is the character count.
 */

// spain = "España"
spain.count                              // Same as spain.characters.count
print("\(spain.characters.count)")      // 6
print("\(spain.unicodeScalars.count)")  // 6
print("\(spain.utf16.count)")           // 6
print("\(spain.utf8.count)")            // 7


/*:
 ## Using Index to traverse a collection

 Each of the collection views has an Index
 that you use to traverse the collection.
 This is maybe one of the big causes of pain
 when getting to grips with String. You cannot
 randomly access an element in a string using
 a subscript (e.g. string[5]).

 Each collection has two instance properties you
 can use as subscripts to index into the collection:

 +  `startIndex`: the position of the first element if
               non-empty, else identical to endIndex.
 +  `endIndex`: the position just “past the end” of the string.
 */
let hello = "hello"
let helloStartIndex = hello.characters.startIndex // 0

//: If you do not specify a view you get the characters view
//: which most of the time saves typing
let startIndex = hello.startIndex // 0
let endIndex = hello.endIndex     // 5
/*:
 **Note the choice for endIndex means you cannot use it directly as a subscript as it is out of range.**
 */
hello[startIndex] // "h"

/*:
 Use index(after:) and index(before:) to move forward or backward from an index
 */
hello[hello.index(after: startIndex)] // "e"
hello[hello.index(before: endIndex)]  // "o"

//: Use index(_:offsetBy:) to move in arbitrary steps
hello[hello.index(startIndex, offsetBy: 1)]  // "e"
hello[hello.index(endIndex, offsetBy: -4)]   // "e"

//: To avoid overrunning the end of the string
if let someIndex = hello.index(startIndex, offsetBy: 4, limitedBy: endIndex) {
    hello[someIndex] // "o"
}

/*:
 To get the index of first matching element (but note that the
 return value is an optional
 */
let matchedIndex = hello.index(of: "l") // 2
let nomatchIndex = hello.index(of: "A") // nil

//: Using the utf16 view
let cafe = "café"
let view = cafe.utf16
let utf16StartIndex = view.startIndex
let utf16EndIndex = view.endIndex

view[utf16StartIndex]                          // 99 - "c"
view[view.index(utf16StartIndex, offsetBy: 1)] // 97 - "a"
view[view.index(before: utf16EndIndex)]        // 233 - "é"

/*:
 The indices property returns a range for all elements
 in a String that can be useful for iterating through
 the collection:
 */
for index in cafe.indices {
  print(cafe[index])
}

/*:
 You cannot use an index from one String to access a
 different string. You can convert an index to an integer
 value with the distanceTo method:
 */
let word1 = "ABCDEF"
let word2 = "012345"
if let indexC = word1.index(of: "C") {
  let distance = word1.distance(from: word1.startIndex, to: indexC) // 2
  let digit = word2[word2.index(startIndex, offsetBy: distance)]    // "2"
    print(digit)
}

/*:
 ## Using a range

 To identify a range of elements in a String collection
 use a range. A range is just a start and end index:
 */
let fqdn = "useyourloaf.com"
let tldEndIndex = fqdn.endIndex
let tldStartIndex = fqdn.index(tldEndIndex, offsetBy: -3)
let range = Range(uncheckedBounds: (lower: tldStartIndex, upper: tldEndIndex))
fqdn[range]

//: ### Alternate creation of range (... or ..< syntax)
let endOfDomain = fqdn.index(fqdn.endIndex, offsetBy: -4)
let rangeOfDomain = fqdn.startIndex ..< endOfDomain
fqdn[rangeOfDomain] // useyourloaf

//: ### Returning a range of matching substring
if let rangeOfTLD = fqdn.range(of: "com") {
    let tld = fqdn[rangeOfTLD] // "com"
    print(tld)
}


/*:
 ## Substrings

 When you slice a string in Swift 4 you do not get back a `String` you get a `Substring`. A `Substring` has most of the same methods as a `String` (it conforms to `StringProtocol`) which makes life easy.

 A `Substring` shares the storage of the original string. For this reason you should treat it a temporary object. From The Swift Programming Language (Swift 4):

 > substrings aren't suitable for long-term storage -- because they reuse the storage of the original string the entire original string must be kept in memory as long as any of its substrings are being used.

 If you want to store it or pass it around convert it back to a `String`.
 */

/*:
 In Swift 4 you slice a string into a substring using subscripting. The
 use of substring(from:), substring(to:) and substring(with:) are all
 deprecated.

 To get a substring from an index up to the end of the string:
 */
let template = "<<<Hello>>>"
let indexStartOfText = template.index(template.startIndex, offsetBy: 3) // 3
let indexEndOfText = template.index(template.endIndex, offsetBy: -3)    // 8

// Swift 4
let substring1 = template[indexStartOfText...]  // "Hello>>>"

// Swift 3 deprecated
// let substring1 = template.substring(from: indexStartOfText)

/*:
 To get a substring from the start of the string up to an index:
 */
// Swift 4
let substring2 = template[..<indexEndOfText]    // "<<<Hello"

// Swift 3 deprecated
// let substring2 = template.substring(to: indexEndOfText)

/*:
 To get a range within the String
 */
// Swift 4
let substring3 = template[indexStartOfText..<indexEndOfText]                       // "Hello"
// Swift 3 deprecated
// let substring3 = template.substring(with: indexStartOfText..<indexEndOfText)

if let range3 = template.range(of: "Hello") {
    template[range3] // "Hello"
}

/*:
 ### Converting a Substring back to a String

 Use the String() initializer to convert back to a String.
 */
let string1 = String(substring1)

/*:
 ### Getting a Prefix or Suffix

 If you just need to drop/retrieve elements at the beginning
 or end of a String:
 */
let digits = "0123456789"
let tail = String(digits.dropFirst()) // "123456789"
let less = String(digits.dropFirst(3)) // "3456789"
let head = String(digits.dropLast(3)) // "0123456"
let prefix = String(digits.prefix(2)) // "01"
let suffix = String(digits.suffix(2)) // "89"

/*:
 Prefer to use subscripting over the verbose prefix and suffix methods.
 */

let index4 = digits.index(digits.startIndex, offsetBy: 4)

digits[...index4]               // "01234"
digits.prefix(through: index4)

digits[..<index4]               // "0123"
digits.prefix(upTo: index4)

digits[index4...]               // "456789"
digits.suffix(from: index4)

//: ### Insert a character at index
var stars = "******"
stars.insert("X", at: stars.index(stars.startIndex, offsetBy: 3)) // "***X***"

//: ### Insert a string at index (converting to characters)
stars.insert(contentsOf: "YZ".characters, at: stars.index(stars.endIndex, offsetBy: -3)) // "***XYZ***"

//: ### Replace with Range
if let xyzRange = stars.range(of: "XYZ") {
    stars.replaceSubrange(xyzRange, with: "ABC") // "***ABC***"
}

//: ### Append
var message = "Welcome"
message += " Tim" // "Welcome Tim"
message.append("!!!")

/*:
 ### Remove and return element at index

 This invalidates any indices you may have on the string
 */
var grades = "ABCDEF"
let ch = grades.remove(at: grades.startIndex) // "A"
print(grades)                                 // "BCDEF"

/*:
 ### Remove Range

 Invalidates all indices
 */
var sequences = "ABA BBA ABC"
let lowBound = sequences.index(sequences.startIndex, offsetBy: 4)
let hiBound = sequences.index(sequences.endIndex, offsetBy: -4)
let midRange = lowBound ..< hiBound
sequences.removeSubrange(midRange) // "ABA ABC"

/*:
 ## Bridging to NSString (import Foundation)

 String is bridged to Objective-C as NSString.
 If the Swift Standard Library does not have what
 you need import the Foundation framework to get
 access to methods defined by NSString.
  
 Be aware that this is not a toll-free bridge so
 stick to the Swift Standard Library where possible.

 **Don't forget to import Foundation**
 */

let welcome = "hello world!"
welcome.capitalized // "Hello World!

/*:
 ### Searching for a substring

 An example of using NSString methods to perform a
 search for a substring:
 */
let text = "123045780984"
// Find last occurance of 0
if let rangeOfZero = text.range(of: "0", options: .backwards) {
  // Get the characters after the last 0
  let suffix = text[rangeOfZero.upperBound...] // "984"
  print(suffix)
}
