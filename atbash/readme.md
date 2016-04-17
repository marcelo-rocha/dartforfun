Resolution of [Challenge #254 (Easy) Atbash Cipher](https://www.reddit.com/r/dailyprogrammer/comments/45w6ad/20160216_challenge_254_easy_atbash_cipher/).

Atbash is a simple substitution cipher originally for the Hebrew alphabet, but possible with any known alphabet. It emerged around 500-600 BCE. It works by substituting the first letter of an alphabet for the last letter, the second letter for the second to last and so on, effectively reversing the alphabet

For this challenge you'll be asked to implement the Atbash cipher and encode (or decode) some English language words. If the character is NOT part of the English alphabet (a-z), you can keep the symbol intact.

Execute the command: 

    cat input.txt | dart atbash.dart