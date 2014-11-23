##  Recursive XML content crawler (based on SimpleXML) for XML files with specific structure

- Laravel 4.2.11 
- PostgreSQL 9.1 
- SimpleXML 
- Bootstrap 3.3.0

Recursively crawl XML files content (utf8) from directory and store it in PostgreSQL database, as result the XML files content is listed. It's appropriate for small files ~20-30-40 KB. There is a `search by author` option. The XML file structure is: 

<book>
    <author>Author name 1</author>
    <name>Book name 1</name>
</book>
<book>
    <author>Author name 2</author>
    <name>Book name 2</name>
</book>
<book>
.....
</book>


### Contributing To This Example

**All issues and pull requests should be filed on the main repository.**

### License

This example is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
