//: Playground - noun: a place where people can play

import Foundation

// ICU: http://site.icu-project.org

let shanghai = "上海"
let latin = shanghai.stringByApplyingTransform(NSStringTransformToLatin, reverse: false)!
latin.stringByApplyingTransform(NSStringTransformLatinToKatakana, reverse: false)
// Convert non-ASCII characters to ASCII,
// convert to lowercase, delete spaces
"Café au lait".stringByApplyingTransform(
    "Latin-ASCII; Lower; [:Separator:] Remove;", reverse: false)
// Convert to lowercase.
"HELLO WORLD".stringByApplyingTransform(
    "Lower", reverse: false)
// Convert only vowels to lowercase.
"HELLO WORLD".stringByApplyingTransform(
    "[AEIOU] Lower", reverse: false)
// Convert to Latin, then to ASCII, then to lowercase.
"กรุงเทพมหานคร".stringByApplyingTransform(
    "Any-Latin; Latin-ASCII; Lower", reverse: false)
// Delete punctuation.
"“Make it so,” said Picard.".stringByApplyingTransform(
    "[:Punctuation:] Remove", reverse: false)
// Delete everything that is not a letter.
"5 plus 6 equals 11 👍!".stringByApplyingTransform(
    "[:^Letter:] Remove", reverse: false)
// Convert to hex representation. 
"😃!".stringByApplyingTransform(
    "Hex/Unicode", reverse: false)
// Normalize to different normalization forms.
"2⁸".stringByApplyingTransform(
    "NFKC", reverse: false)



