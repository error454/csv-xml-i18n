csv-xml-i18n
============

Reads a CSV file containing translations, generates XML files for each file and language code.

For instance a CSV file containing english and spanish translations for File1 and File2 would produce:

* File1-en.xml
* File1-es.xml
* File2-en.xml
* File2-es.xml

For more details on the architecture and usage, refer to the [announcement article](http://www.error454.com/2014/04/11/shiva-localization/).

Sample Input File
-----

The [sample spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0AoGqxtUhFBJDdFRMU3c5RTNQSExiTnhYZFkxRUloU0E&usp=sharing) that was used to generate test.csv.

Running the parser
-----

Pass in the name of the file as the first and only argument:

lua csvToXml.lua test.csv

Engine Specific Implementation
-----

A helper AI for the ShiVa game engine is included in the shiva folder. It simplifies reading in the xml files based on platform OS language.