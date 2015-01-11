##  Recursive XML content crawler (based on SimpleXML) for XML files with specific structure

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/klistofar/laravel-postgresql-simple-xml-crawling?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

- Laravel 4.2.11 
- PostgreSQL 9.1 
- SimpleXML 
- Bootstrap 3.3.0

Recursively crawl XML files content (utf8) from directory and store it in PostgreSQL database, as result the XML files content is listed. It's appropriate for small files ~20-30-40 KB. In front-end interface, there is `search by author` option. The XML file structure is: 

<pre>
<code>&lt;book&gt;
    &lt;author&gt;Author name 1&lt;/author&gt;
    &lt;name&gt;Book name 1&lt;/name&gt;
&lt;/book&gt;
&lt;book&gt;
    &lt;author&gt;Author name 2&lt;/author&gt;
    &lt;name&gt;Book name 2&lt;/name&gt;
&lt;/book&gt;
&lt;book&gt;<br />    .....
&lt;/book&gt;</code>
</pre>

### Contributing To This Example

**All issues and pull requests should be filed on the main repository.**

### License

This example is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)