Resolution of [Challenge #263 Easy Calculating Shannon Entropy of a String](https://www.reddit.com/r/dailyprogrammer/comments/4fc896/20160418_challenge_263_easy_calculating_shannon/)

Shannon entropy was introduced by Claude E. Shannon in his 1948 paper "A Mathematical Theory of Communication". Somewhat related to the physical and chemical concept entropy, the Shannon entropy measures the uncertainty associated with a random variable, i.e. the expected value of the information in the message (in classical informatics it is measured in bits). This is a key concept in information theory and has consequences for things like compression, cryptography and privacy, and more.

The Shannon entropy H of input sequence X is calculated as -1 times the sum of the frequency of the symbol i times the log base 2 of the frequency

Execute the command:

    cat input.txt | dart entropy.dart