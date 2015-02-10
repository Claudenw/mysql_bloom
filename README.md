# mysql_bloom
Mysql UDF extension to handle bloom filter checking in the database

This code implements 2 functions to be added to MySQL via the UDF framework.  

License: Apache

Bloomfilters are assumed to be arrays of bytes in little-endian order.  

Requires
--------

Mysql client and server headers are required to compile this code.

Installation
------------

Please do the following in the root of the source directory tree: 

    aclocal 
    autoconf 
    autoheader 
    automake --add-missing

    ./configure
    make
    sudo make install
    sudo make installdb


To remove the library from your system:

    make uninstalldb
    make uninstall


Functions
---------

    bloommatch( blob a, blob b )
performs a byte by bytes check of  (a & b == a).  if true then "a" may be found in "b", if false then "a" is not in "b".
example:

    Connection con = ... // get the db connection
    InputStream is = ... // input stream containing a the bloom filter to locate in the table
    PreparedStatement stmt = con.prepareStatement( "SELECT * FROM bloomTable WHERE bloommatch( ?, bloomTable.filter );" );
    stmt.setBlob( 1, is );
    ResultSet rs = stmt.executeQuery();
    // rs now contains all the matching bloom filters from the table.
    
  
    bloomupdate( blob a, blob b )
performs a byte by byte construct of a new filter where (a | b). 
example:

    Connection con = ... // get the db connection
    InputStream is = ... // input stream containing a the bloom filter to locate in the table
    PreparedStatement stmt = con.prepareStatement( "UPDATE bloomTable SET filter=bloomupdate( ?, bloomTable.filter ) WHERE id=?;" );
    stmt.setBlob( 1, is );
    stmt.setint( 2, 5 );
    stmt.executeUpdate();
    // bloom filters on rows with id of 5 have been updated to include values from the blob.

