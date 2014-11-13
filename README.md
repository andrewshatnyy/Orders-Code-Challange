[![Build Status](https://travis-ci.org/andrewshatnyy/Orders-Code-Challange.svg?branch=master)](https://travis-ci.org/andrewshatnyy/Orders-Code-Challange)


#Orders Code Challange

*This is my take on recent code challenge, utilizing basic data structures in ruby.*

Lets assume that every order can be represented by a tuple `(orderId, companyName, customerAdress, orderedItem)`.

    001, SuperTrader, Steindamm 80, Macbook
    002, Cheapskates, Reeperbahn 153, Macbook
    003, MegaCorp, Steindamm 80, Book "Guide to Hamburg"
    004, SuperTrader, Sternstrasse  125, Book "Cooking  101"
    005, SuperTrader, Ottenser Hauptstrasse 24, Inline Skates
    006, MegaCorp, Reeperbahn 153, Playstation
    007, Cheapskates, Lagerstrasse  11, Flux compensator
    008, SuperTrader, Reeperbahn 153, Inline Skates

In the language of your choice, please implement a working solution to read the data from an input file, store them in a data structure in memory, and then perform the following kind of operations on the data:

1. show all orders from a particular company
2. show all orders to a particular address
3. delete a particular order given an OrderId
4. display how often each item has been ordered, in descending order (ie in the above example, 2x for Macbook and Inline skates, 1x for the rest)

Please optimize your code and do not convolute it with handling exceptions/edge cases – we are more interested in readability for this solution.

[![Analytics](https://ga-beacon.appspot.com/UA-56621624-1/Orders-Code-Challange)](https://github.com/igrigorik/ga-beacon)
