//: Playground - noun: a place where people can play

import Foundation

// ICU: http://site.icu-project.org

let aString = "  a b c "
aString.applyingTransform(StringTransform("[:^:] Remove"), reverse: false)
aString.replacingOccurrences(of: " ", with: "")

let shanghai = "上海"
let latin = shanghai.applyingTransform(.toLatin, reverse: false)!
latin.applyingTransform(.latinToKatakana, reverse: false)
// Convert non-ASCII characters to ASCII,
// convert to lowercase, delete spaces
"Café au lait".applyingTransform(
    StringTransform(rawValue: "Latin-ASCII; Lower; [:Separator:] Remove;"), reverse: false)
// Convert to lowercase.
"HELLO WORLD".applyingTransform(
    StringTransform(rawValue: "Lower"), reverse: false)
// Convert only vowels to lowercase.
"HELLO WORLD".applyingTransform(
    StringTransform(rawValue: "[AEIOU] Lower"), reverse: false)
// Convert to Latin, then to ASCII, then to lowercase.
"กรุงเทพมหานคร".applyingTransform(
    StringTransform(rawValue: "Any-Latin; Latin-ASCII; Lower"), reverse: false)
// Delete punctuation.
"“Make it so,” said Picard.".applyingTransform(
    StringTransform(rawValue: "[:Punctuation:] Remove"), reverse: false)
// Delete everything that is not a letter.
"5 plus 6 equals 11 👍!".applyingTransform(
    StringTransform(rawValue: "[:^Letter:] Remove"), reverse: false)
// Convert to hex representation. 
"😃!".applyingTransform(
    StringTransform(rawValue: "Hex/Unicode"), reverse: false)
// Normalize to different normalization forms.
"2⁸".applyingTransform(
    StringTransform(rawValue: "NFKC"), reverse: false)



