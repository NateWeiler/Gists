Basic module usage
==============================================================================================================

The basic Psycopg usage is common to all the database adapters implementing the [DB API 2.0](https://www.python.org/dev/peps/pep-0249/) protocol. Here is an interactive session showing some of the basic commands:

>>> import psycopg2

# Connect to an existing database
>>> conn = psycopg2.connect("dbname=test user=postgres")

# Open a cursor to perform database operations
>>> cur = conn.cursor()

# Execute a command: this creates a new table
>>> cur.execute("CREATE TABLE test (id serial PRIMARY KEY, num integer, data varchar);")

# Pass data to fill a query placeholders and let Psycopg perform
# the correct conversion (no more SQL injections!)
>>> cur.execute("INSERT INTO test (num, data) VALUES (%s, %s)",
...      (100, "abc'def"))

# Query the database and obtain data as Python objects
>>> cur.execute("SELECT * FROM test;")
>>> cur.fetchone()
(1, 100, "abc'def")

# Make the changes to the database persistent
>>> conn.commit()

# Close communication with the database
>>> cur.close()
>>> conn.close()

The main entry points of Psycopg are:

-   The function [`connect()`](https://www.psycopg.org/docs/module.html#psycopg2.connect "psycopg2.connect") creates a new database session and returns a new [`connection`](https://www.psycopg.org/docs/connection.html#connection "connection") instance.
-   The class [`connection`](https://www.psycopg.org/docs/connection.html#connection "connection") encapsulates a database session. It allows to:
    -   create new [`cursor`](https://www.psycopg.org/docs/cursor.html#cursor "cursor") instances using the [`cursor()`](https://www.psycopg.org/docs/connection.html#connection.cursor "connection.cursor") method to execute database commands and queries,
    -   terminate transactions using the methods [`commit()`](https://www.psycopg.org/docs/connection.html#connection.commit "connection.commit") or [`rollback()`](https://www.psycopg.org/docs/connection.html#connection.rollback "connection.rollback").
-   The class [`cursor`](https://www.psycopg.org/docs/cursor.html#cursor "cursor") allows interaction with the database:
    -   send commands to the database using methods such as [`execute()`](https://www.psycopg.org/docs/cursor.html#cursor.execute "cursor.execute") and [`executemany()`](https://www.psycopg.org/docs/cursor.html#cursor.executemany "cursor.executemany"),
    -   retrieve data from the database [by iteration](https://www.psycopg.org/docs/cursor.html#cursor-iterable) or using methods such as [`fetchone()`](https://www.psycopg.org/docs/cursor.html#cursor.fetchone "cursor.fetchone"), [`fetchmany()`](https://www.psycopg.org/docs/cursor.html#cursor.fetchmany "cursor.fetchmany"), [`fetchall()`](https://www.psycopg.org/docs/cursor.html#cursor.fetchall "cursor.fetchall").

Passing parameters to SQL queries
-------------------------------------------------------------------------------------------------------------------------------------------

Psycopg converts Python variables to SQL values using their types: the Python type determines the function used to convert the object into a string representation suitable for PostgreSQL. Many standard Python types are already [adapted to the correct SQL representation](https://www.psycopg.org/docs/usage.html#python-types-adaptation).

Passing parameters to an SQL statement happens in functions such as [`cursor.execute()`](https://www.psycopg.org/docs/cursor.html#cursor.execute "cursor.execute") by using `%s` placeholders in the SQL statement, and passing a sequence of values as the second argument of the function. For example the Python function call:

>>> cur.execute("""
...     INSERT INTO some_table (an_int, a_date, a_string)
...     VALUES (%s, %s, %s);
...     """,
...     (10, datetime.date(2005, 11, 18), "O'Reilly"))

is converted into a SQL command similar to:

INSERT INTO some_table (an_int, a_date, a_string)
VALUES (10, '2005-11-18', 'O''Reilly');

Named arguments are supported too using `%(*name*)s` placeholders in the query and specifying the values into a mapping. Using named arguments allows to specify the values in any order and to repeat the same value in several places in the query:

>>> cur.execute("""
...     INSERT INTO some_table (an_int, a_date, another_date, a_string)
...     VALUES (%(int)s, %(date)s, %(date)s, %(str)s);
...     """,
...     {'int': 10, 'str': "O'Reilly", 'date': datetime.date(2005, 11, 18)})

Using characters `%`, `(`, `)` in the argument names is not supported.

When parameters are used, in order to include a literal `%` in the query you can use the `%%` string:

>>> cur.execute("SELECT (%s % 2) = 0 AS even", (10,))       # WRONG
>>> cur.execute("SELECT (%s  %% 2) = 0 AS even", (10,))      # correct

While the mechanism resembles regular Python strings manipulation, there are a few subtle differences you should care about when passing parameters to a query.

-   The Python string operator `%` *must not be used*: the [`execute()`](https://www.psycopg.org/docs/cursor.html#cursor.execute "cursor.execute") method accepts a tuple or dictionary of values as second parameter. [**Never** use `%` or `+` to merge values into queries](https://www.psycopg.org/docs/usage.html#sql-injection):

    >>> cur.execute("INSERT INTO numbers VALUES (%s, %s)" % (10, 20)) # WRONG
    >>> cur.execute("INSERT INTO numbers VALUES (%s, %s)", (10, 20))  # correct

-   For positional variables binding, *the second argument must always be a sequence*, even if it contains a single variable (remember that Python requires a comma to create a single element tuple):

    >>> cur.execute("INSERT INTO foo VALUES (%s)", "bar")    # WRONG
    >>> cur.execute("INSERT INTO foo VALUES (%s)", ("bar"))  # WRONG
    >>> cur.execute("INSERT INTO foo VALUES (%s)", ("bar",)) # correct
    >>> cur.execute("INSERT INTO foo VALUES (%s)", ["bar"])  # correct

-   The placeholder *must not be quoted*. Psycopg will add quotes where needed:

    >>> cur.execute("INSERT INTO numbers VALUES ('%s')", (10,)) # WRONG
    >>> cur.execute("INSERT INTO numbers VALUES (%s)", (10,))   # correct

-   The variables placeholder *must always be a* `%s`, even if a different placeholder (such as a `%d` for integers or `%f` for floats) may look more appropriate:

    >>> cur.execute("INSERT INTO numbers VALUES (%d)", (10,))   # WRONG
    >>> cur.execute("INSERT INTO numbers VALUES (%s)", (10,))   # correct

-   Only query values should be bound via this method: it shouldn't be used to merge table or field names to the query (Psycopg will try quoting the table name as a string value, generating invalid SQL). If you need to generate dynamically SQL queries (for instance choosing dynamically a table name) you can use the facilities provided by the [`psycopg2.sql`](https://www.psycopg.org/docs/sql.html#module-psycopg2.sql "psycopg2.sql") module:

    >>> cur.execute("INSERT INTO %s VALUES (%s)", ('numbers', 10))  # WRONG
    >>> cur.execute(                                                # correct
    ...     SQL("INSERT INTO {} VALUES (%s)").format(Identifier('numbers')),
    ...     (10,))

### The problem with the query parameters

The SQL representation of many data types is often different from their Python string representation. The typical example is with single quotes in strings: in SQL single quotes are used as string literal delimiters, so the ones appearing inside the string itself must be escaped, whereas in Python single quotes can be left unescaped if the string is delimited by double quotes.

Because of the difference, sometime subtle, between the data types representations, a naïve approach to query strings composition, such as using Python strings concatenation, is a recipe for *terrible* problems:

>>> SQL = "INSERT INTO authors (name) VALUES ('%s');" # NEVER DO THIS
>>> data = ("O'Reilly", )
>>> cur.execute(SQL % data) # THIS WILL FAIL MISERABLY
ProgrammingError: syntax error at or near "Reilly"
LINE 1: INSERT INTO authors (name) VALUES ('O'Reilly')
 ^

If the variables containing the data to send to the database come from an untrusted source (such as a form published on a web site) an attacker could easily craft a malformed string, either gaining access to unauthorized data or performing destructive operations on the database. This form of attack is called [SQL injection](https://en.wikipedia.org/wiki/SQL_injection) and is known to be one of the most widespread forms of attack to database servers. Before continuing, please print [this page](https://xkcd.com/327/) as a memo and hang it onto your desk.

Psycopg can [automatically convert Python objects to and from SQL literals](https://www.psycopg.org/docs/usage.html#python-types-adaptation): using this feature your code will be more robust and reliable. We must stress this point:

Warning

Never, **never**, **NEVER** use Python string concatenation (`+`) or string parameters interpolation (`%`) to pass variables to a SQL query string. Not even at gunpoint.

The correct way to pass variables in a SQL command is using the second argument of the [`execute()`](https://www.psycopg.org/docs/cursor.html#cursor.execute "cursor.execute") method:

>>> SQL = "INSERT INTO authors (name) VALUES (%s);" # Note: no quotes
>>> data = ("O'Reilly", )
>>> cur.execute(SQL, data) # Note: no % operator

### Values containing backslashes and LIKE

Unlike in Python, the backslash (`\`) is not used as an escape character *except* in patterns used with `LIKE` and `ILIKE` where they are needed to escape the `%` and `_` characters.

This can lead to confusing situations:

>>> path = r'C:\Users\Bobby.Tables'
>>> cur.execute('INSERT INTO mytable(path) VALUES (%s)', (path,))
>>> cur.execute('SELECT * FROM mytable WHERE path LIKE %s', (path,))
>>> cur.fetchall()
[]

The solution is to specify an `ESCAPE` character of `''` (empty string) in your `LIKE` query:

>>> cur.execute("SELECT * FROM mytable WHERE path LIKE %s ESCAPE ''", (path,))

Adaptation of Python values to SQL types
---------------------------------------------------------------------------------------------------------------------------------------------------------

Many standard Python types are adapted into SQL and returned as Python objects when a query is executed.

The following table shows the default mapping between Python and PostgreSQL types:

 Python  PostgreSQL  See also 
 ---  ---  --- 
 `None`  `NULL`  [Constants adaptation](https://www.psycopg.org/docs/usage.html#adapt-consts) 
 `bool`  `bool` 
 `float` 

`real`

`double`

 [Numbers adaptation](https://www.psycopg.org/docs/usage.html#adapt-numbers) 


`int`

`long`

 

`smallint`

`integer`

`bigint`

 
 [`Decimal`](https://docs.python.org/3/library/decimal.html#decimal.Decimal "(in Python v3.8)")  `numeric` 


`str`

`unicode`

 

`varchar`

`text`

  [Strings adaptation](https://www.psycopg.org/docs/usage.html#adapt-string) 


`buffer`

[`memoryview`](https://docs.python.org/3/library/stdtypes.html#memoryview "(in Python v3.8)")

[`bytearray`](https://docs.python.org/3/library/stdtypes.html#bytearray "(in Python v3.8)")

[`bytes`](https://docs.python.org/3/library/stdtypes.html#bytes "(in Python v3.8)")

Buffer protocol

  `bytea`  [Binary adaptation](https://www.psycopg.org/docs/usage.html#adapt-binary) 
 `date`  `date`  [Date/Time objects adaptation](https://www.psycopg.org/docs/usage.html#adapt-date)  `time` 

`time`

`timetz`

 
 `datetime` 

`timestamp`

`timestamptz`

 
 `timedelta`  `interval` 
 `list`  `ARRAY`  [Lists adaptation](https://www.psycopg.org/docs/usage.html#adapt-list) 


`tuple`

`namedtuple`

 

Composite types

`IN` syntax

 

[Tuples adaptation](https://www.psycopg.org/docs/usage.html#adapt-tuple)

[Composite types casting](https://www.psycopg.org/docs/extras.html#adapt-composite)

 
 `dict`  `hstore`  [Hstore data type](https://www.psycopg.org/docs/extras.html#adapt-hstore) 
 Psycopg's `Range`  `range`  [Range data types](https://www.psycopg.org/docs/extras.html#adapt-range) 
 Anything™  `json`  [JSON adaptation](https://www.psycopg.org/docs/extras.html#adapt-json) 
 [`UUID`](https://docs.python.org/3/library/uuid.html#uuid.UUID "(in Python v3.8)")  `uuid`  [UUID data type](https://www.psycopg.org/docs/extras.html#adapt-uuid) 
 [`ipaddress`](https://docs.python.org/3/library/ipaddress.html#module-ipaddress "(in Python v3.8)") objects 

`inet`

`cidr`

  [Networking data types](https://www.psycopg.org/docs/extras.html#adapt-network) 

The mapping is fairly customizable: see [Adapting new Python types to SQL syntax](https://www.psycopg.org/docs/advanced.html#adapting-new-types) and [Type casting of SQL types into Python objects](https://www.psycopg.org/docs/advanced.html#type-casting-from-sql-to-python). You can also find a few other specialized adapters in the [`psycopg2.extras`](https://www.psycopg.org/docs/extras.html#module-psycopg2.extras "psycopg2.extras") module.

### Constants adaptation

Python [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.8)") and boolean values [`True`](https://docs.python.org/3/library/constants.html#True "(in Python v3.8)") and [`False`](https://docs.python.org/3/library/constants.html#False "(in Python v3.8)") are converted into the proper SQL literals:

>>> cur.mogrify("SELECT %s, %s, %s;", (None, True, False))
'SELECT NULL, true, false;'

### Numbers adaptation

Python numeric objects [`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.8)"), `long`, [`float`](https://docs.python.org/3/library/functions.html#float "(in Python v3.8)"), [`Decimal`](https://docs.python.org/3/library/decimal.html#decimal.Decimal "(in Python v3.8)") are converted into a PostgreSQL numerical representation:

>>> cur.mogrify("SELECT %s, %s, %s, %s;", (10, 10L, 10.0, Decimal("10.00")))
'SELECT 10, 10, 10.0, 10.00;'

Reading from the database, integer types are converted into `int`, floating point types are converted into `float`, `numeric`/`decimal` are converted into `Decimal`.

Note

Sometimes you may prefer to receive `numeric` data as `float` instead, for performance reason or ease of manipulation: you can configure an adapter to [cast PostgreSQL numeric to Python float](https://www.psycopg.org/docs/faq.html#faq-float). This of course may imply a loss of precision.

See also

[PostgreSQL numeric types](https://www.postgresql.org/docs/current/static/datatype-numeric.html)

### Strings adaptation

Python [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.8)") and `unicode` are converted into the SQL string syntax. `unicode` objects (`str` in Python 3) are encoded in the connection [`encoding`](https://www.psycopg.org/docs/connection.html#connection.encoding "connection.encoding") before sending to the backend: trying to send a character not supported by the encoding will result in an error. Data is usually received as `str` (*i.e.* it is *decoded* on Python 3, left *encoded* on Python 2). However it is possible to receive `unicode` on Python 2 too: see [Unicode handling](https://www.psycopg.org/docs/usage.html#unicode-handling).

#### Unicode handling

Psycopg can exchange Unicode data with a PostgreSQL database. Python `unicode` objects are automatically *encoded* in the client encoding defined on the database connection (the [PostgreSQL encoding](https://www.postgresql.org/docs/current/static/multibyte.html), available in [`connection.encoding`](https://www.psycopg.org/docs/connection.html#connection.encoding "connection.encoding"), is translated into a [Python encoding](https://docs.python.org/library/codecs.html) using the [`encodings`](https://www.psycopg.org/docs/extensions.html#psycopg2.extensions.encodings "psycopg2.extensions.encodings") mapping):

>>> print u, type(u)
àèìòù€ <type 'unicode'>

>>> cur.execute("INSERT INTO test (num, data) VALUES (%s,%s);", (74, u))

When reading data from the database, in Python 2 the strings returned are usually 8 bit `str` objects encoded in the database client encoding:

>>> print conn.encoding
UTF8

>>> cur.execute("SELECT data FROM test WHERE num = 74")
>>> x = cur.fetchone()[0]
>>> print x, type(x), repr(x)
àèìòù€ <type 'str'> '\xc3\xa0\xc3\xa8\xc3\xac\xc3\xb2\xc3\xb9\xe2\x82\xac'

>>> conn.set_client_encoding('LATIN9')

>>> cur.execute("SELECT data FROM test WHERE num = 74")
>>> x = cur.fetchone()[0]
>>> print type(x), repr(x)
<type 'str'> '\xe0\xe8\xec\xf2\xf9\xa4'

In Python 3 instead the strings are automatically *decoded* in the connection [`encoding`](https://www.psycopg.org/docs/connection.html#connection.encoding "connection.encoding"), as the `str` object can represent Unicode characters. In Python 2 you must register a [typecaster](https://www.psycopg.org/docs/advanced.html#type-casting-from-sql-to-python) in order to receive `unicode` objects:

>>> psycopg2.extensions.register_type(psycopg2.extensions.UNICODE, cur)

>>> cur.execute("SELECT data FROM test WHERE num = 74")
>>> x = cur.fetchone()[0]
>>> print x, type(x), repr(x)
àèìòù€ <type 'unicode'> u'\xe0\xe8\xec\xf2\xf9\u20ac'

In the above example, the [`UNICODE`](https://www.psycopg.org/docs/extensions.html#psycopg2.extensions.UNICODE "psycopg2.extensions.UNICODE") typecaster is registered only on the cursor. It is also possible to register typecasters on the connection or globally: see the function [`register_type()`](https://www.psycopg.org/docs/extensions.html#psycopg2.extensions.register_type "psycopg2.extensions.register_type") and [Type casting of SQL types into Python objects](https://www.psycopg.org/docs/advanced.html#type-casting-from-sql-to-python) for details.

Note

In Python 2, if you want to uniformly receive all your database input in Unicode, you can register the related typecasters globally as soon as Psycopg is imported:

import psycopg2.extensions
psycopg2.extensions.register_type(psycopg2.extensions.UNICODE)
psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY)

and forget about this story.

Note

In some cases, on Python 3, you may want to receive `bytes` instead of `str`, without undergoing to any decoding. This is especially the case if the data in the database is in mixed encoding. The [`BYTES`](https://www.psycopg.org/docs/extensions.html#psycopg2.extensions.BYTES "psycopg2.extensions.BYTES") caster is what you neeed:

import psycopg2.extensions
psycopg2.extensions.register_type(psycopg2.extensions.BYTES, conn)
psycopg2.extensions.register_type(psycopg2.extensions.BYTESARRAY, conn)
cur = conn.cursor()
cur.execute("select %s::text", (u"€",))
cur.fetchone()[0]
b'\xe2\x82\xac'

### Binary adaptation

Python types representing binary objects are converted into PostgreSQL binary string syntax, suitable for `bytea` fields. Such types are `buffer` (only available in Python 2), [`memoryview`](https://docs.python.org/3/library/stdtypes.html#memoryview "(in Python v3.8)"), [`bytearray`](https://docs.python.org/3/library/stdtypes.html#bytearray "(in Python v3.8)"), and [`bytes`](https://docs.python.org/3/library/stdtypes.html#bytes "(in Python v3.8)") (only in Python 3: the name is available in Python 2 but it's only an alias for the type `str`). Any object implementing the [Revised Buffer Protocol](https://www.python.org/dev/peps/pep-3118/) should be usable as binary type. Received data is returned as `buffer` (in Python 2) or `memoryview` (in Python 3).

Changed in version 2.4: only strings were supported before.

Changed in version 2.4.1: can parse the 'hex' format from 9.0 servers without relying on the version of the client library.

Note

In Python 2, if you have binary data in a `str` object, you can pass them to a `bytea` field using the [`psycopg2.Binary`](https://www.psycopg.org/docs/module.html#psycopg2.Binary "psycopg2.Binary") wrapper:

mypic = open('picture.png', 'rb').read()
curs.execute("insert into blobs (file) values (%s)",
    (psycopg2.Binary(mypic),))

Warning

Since version 9.0 PostgreSQL uses by default [a new "hex" format](https://www.postgresql.org/docs/current/static/datatype-binary.html) to emit `bytea` fields. Starting from Psycopg 2.4.1 the format is correctly supported. If you use a previous version you will need some extra care when receiving bytea from PostgreSQL: you must have at least libpq 9.0 installed on the client or alternatively you can set the [bytea_output](https://www.postgresql.org/docs/current/static/runtime-config-client.html#GUC-BYTEA-OUTPUT) configuration parameter to `escape`, either in the server configuration file or in the client session (using a query such as `SET bytea_output TO escape;`) before receiving binary data.

### Date/Time objects adaptation

Python builtin [`datetime`](https://docs.python.org/3/library/datetime.html#datetime.datetime "(in Python v3.8)"), [`date`](https://docs.python.org/3/library/datetime.html#datetime.date "(in Python v3.8)"), [`time`](https://docs.python.org/3/library/datetime.html#datetime.time "(in Python v3.8)"), [`timedelta`](https://docs.python.org/3/library/datetime.html#datetime.timedelta "(in Python v3.8)") are converted into PostgreSQL's `timestamp[tz]`, `date`, `time[tz]`, `interval` data types. Time zones are supported too. The Egenix [mx.DateTime](https://www.egenix.com/products/python/mxBase/mxDateTime/) objects are adapted the same way:

>>> dt = datetime.datetime.now()
>>> dt
datetime.datetime(2010, 2, 8, 1, 40, 27, 425337)

>>> cur.mogrify("SELECT %s, %s, %s;", (dt, dt.date(), dt.time()))
"SELECT '2010-02-08T01:40:27.425337', '2010-02-08', '01:40:27.425337';"

>>> cur.mogrify("SELECT %s;", (dt - datetime.datetime(2010,1,1),))
"SELECT '38 days 6027.425337 seconds';"

See also

[PostgreSQL date/time types](https://www.postgresql.org/docs/current/static/datatype-datetime.html)

#### Time zones handling

The PostgreSQL type `timestamp with time zone` (a.k.a. `timestamptz`) is converted into Python [`datetime`](https://docs.python.org/3/library/datetime.html#datetime.datetime "(in Python v3.8)") objects with a [`tzinfo`](https://docs.python.org/3/library/datetime.html#datetime.datetime.tzinfo "(in Python v3.8)") attribute set to a [`FixedOffsetTimezone`](https://www.psycopg.org/docs/tz.html#psycopg2.tz.FixedOffsetTimezone "psycopg2.tz.FixedOffsetTimezone") instance.

>>> cur.execute("SET TIME ZONE 'Europe/Rome';")  # UTC + 1 hour
>>> cur.execute("SELECT '2010-01-01 10:30:45'::timestamptz;")
>>> cur.fetchone()[0].tzinfo
psycopg2.tz.FixedOffsetTimezone(offset=60, name=None)

Note that only time zones with an integer number of minutes are supported: this is a limitation of the Python [`datetime`](https://docs.python.org/3/library/datetime.html#module-datetime "(in Python v3.8)") module. A few historical time zones had seconds in the UTC offset: these time zones will have the offset rounded to the nearest minute, with an error of up to 30 seconds.

>>> cur.execute("SET TIME ZONE 'Asia/Calcutta';")  # offset was +5:53:20
>>> cur.execute("SELECT '1930-01-01 10:30:45'::timestamptz;")
>>> cur.fetchone()[0].tzinfo
psycopg2.tz.FixedOffsetTimezone(offset=353, name=None)

Changed in version 2.2.2: timezones with seconds are supported (with rounding). Previously such timezones raised an error.

#### Infinite dates handling

PostgreSQL can store the representation of an "infinite" date, timestamp, or interval. Infinite dates are not available to Python, so these objects are mapped to `date.max`, `datetime.max`, `interval.max`. Unfortunately the mapping cannot be bidirectional so these dates will be stored back into the database with their values, such as `9999-12-31`.

It is possible to create an alternative adapter for dates and other objects to map `date.max` to `infinity`, for instance:

class InfDateAdapter:
    def __init__(self, wrapped):
        self.wrapped = wrapped
    def getquoted(self):
        if self.wrapped == datetime.date.max:
            return b"'infinity'::date"
        elif self.wrapped == datetime.date.min:
            return b"'-infinity'::date"
        else:
            return psycopg2.extensions.DateFromPy(self.wrapped).getquoted()

psycopg2.extensions.register_adapter(datetime.date, InfDateAdapter)

Of course it will not be possible to write the value of `date.max` in the database anymore: `infinity` will be stored instead.

#### Time handling

The PostgreSQL `time` and Python [`time`](https://docs.python.org/3/library/datetime.html#datetime.time "(in Python v3.8)") types are not fully bidirectional.

Within PostgreSQL, the `time` type's maximum value of `24:00:00` is treated as 24-hours later than the minimum value of `00:00:00`.

>>> cur.execute("SELECT '24:00:00'::time - '00:00:00'::time")
>>> cur.fetchone()[0]
datetime.timedelta(days=1)

However, Python's `time` only supports times until `23:59:59`. Retrieving a value of `24:00:00` results in a `time` of `00:00:00`.

>>> cur.execute("SELECT '24:00:00'::time, '00:00:00'::time")
>>> cur.fetchone()
(datetime.time(0, 0), datetime.time(0, 0))

### Lists adaptation
Python lists are converted into PostgreSQL `ARRAY`s:

>>> cur.mogrify("SELECT %s;", ([10, 20, 30], ))
'SELECT ARRAY[10,20,30];'

Note

You can use a Python list as the argument of the `IN` operator using [the PostgreSQL ANY operator](https://www.postgresql.org/docs/current/static/functions-subquery.html#FUNCTIONS-SUBQUERY-ANY-SOME).

ids = [10, 20, 30]
cur.execute("SELECT * FROM data WHERE id = ANY(%s);", (ids,))

Furthermore `ANY` can also work with empty lists, whereas `IN ()` is a SQL syntax error.

Note

Reading back from PostgreSQL, arrays are converted to lists of Python objects as expected, but only if the items are of a known type. Arrays of unknown types are returned as represented by the database (e.g. `{a,b,c}`). If you want to convert the items into Python objects you can easily create a typecaster for [array of unknown types](https://www.psycopg.org/docs/extensions.html#cast-array-unknown).

### Tuples adaptation

Python tuples are converted into a syntax suitable for the SQL `IN` operator and to represent a composite type:

>>> cur.mogrify("SELECT %s IN %s;", (10, (10, 20, 30)))
'SELECT 10 IN (10, 20, 30);'

Note

SQL doesn't allow an empty list in the `IN` operator, so your code should guard against empty tuples. Alternatively you can [use a Python list](https://www.psycopg.org/docs/usage.html#adapt-list).

If you want PostgreSQL composite types to be converted into a Python tuple/namedtuple you can use the [`register_composite()`](https://www.psycopg.org/docs/extras.html#psycopg2.extras.register_composite "psycopg2.extras.register_composite") function.

New in version 2.0.6: the tuple `IN` adaptation.

Changed in version 2.0.14: the tuple `IN` adapter is always active. In previous releases it was necessary to import the [`extensions`](https://www.psycopg.org/docs/extensions.html#module-psycopg2.extensions "psycopg2.extensions") module to have it registered.

Changed in version 2.3: [`namedtuple`](https://docs.python.org/3/library/collections.html#collections.namedtuple "(in Python v3.8)") instances are adapted like regular tuples and can thus be used to represent composite types.

Transactions control
-----------------------------------------------------------------------------------------------------------------

In Psycopg transactions are handled by the [`connection`](https://www.psycopg.org/docs/connection.html#connection "connection") class. By default, the first time a command is sent to the database (using one of the [`cursor`](https://www.psycopg.org/docs/cursor.html#cursor "cursor")s created by the connection), a new transaction is created. The following database commands will be executed in the context of the same transaction -- not only the commands issued by the first cursor, but the ones issued by all the cursors created by the same connection. Should any command fail, the transaction will be aborted and no further command will be executed until a call to the [`rollback()`](https://www.psycopg.org/docs/connection.html#connection.rollback "connection.rollback") method.

The connection is responsible for terminating its transaction, calling either the [`commit()`](https://www.psycopg.org/docs/connection.html#connection.commit "connection.commit") or [`rollback()`](https://www.psycopg.org/docs/connection.html#connection.rollback "connection.rollback") method. Committed changes are immediately made persistent into the database. Closing the connection using the [`close()`](https://www.psycopg.org/docs/connection.html#connection.close "connection.close") method or destroying the connection object (using `del` or letting it fall out of scope) will result in an implicit rollback.

It is possible to set the connection in *autocommit* mode: this way all the commands executed will be immediately committed and no rollback is possible. A few commands (e.g. `CREATE DATABASE`, `VACUUM`, `CALL` on [stored procedures](https://www.postgresql.org/docs/current/xproc.html) using transaction control...) require to be run outside any transaction: in order to be able to run these commands from Psycopg, the connection must be in autocommit mode: you can use the [`autocommit`](https://www.psycopg.org/docs/connection.html#connection.autocommit "connection.autocommit") property.

Warning

By default even a simple `SELECT` will start a transaction: in long-running programs, if no further action is taken, the session will remain "idle in transaction", an undesirable condition for several reasons (locks are held by the session, tables bloat...). For long lived scripts, either make sure to terminate a transaction as soon as possible or use an autocommit connection.

A few other transaction properties can be set session-wide by the `connection`: for instance it is possible to have read-only transactions or change the isolation level. See the [`set_session()`](https://www.psycopg.org/docs/connection.html#connection.set_session "connection.set_session") method for all the details.

### `with` statement

Starting from version 2.5, psycopg2's connections and cursors are *context managers* and can be used with the `with` statement:

with psycopg2.connect(DSN) as conn:
    with conn.cursor() as curs:
        curs.execute(SQL)

When a connection exits the `with` block, if no exception has been raised by the block, the transaction is committed. In case of exception the transaction is rolled back.

When a cursor exits the `with` block it is closed, releasing any resource eventually associated with it. The state of the transaction is not affected.

A connection can be used in more than a `with` statement and each `with` block is effectively wrapped in a separate transaction:

conn = psycopg2.connect(DSN)

with conn:
    with conn.cursor() as curs:
        curs.execute(SQL1)

with conn:
    with conn.cursor() as curs:
        curs.execute(SQL2)

conn.close()

Warning

Unlike file objects or other resources, exiting the connection's `with` block **doesn't close the connection**, but only the transaction associated to it. If you want to make sure the connection is closed after a certain point, you should still use a try-catch block:

conn = psycopg2.connect(DSN)
try:
    # connection usage
finally:
    conn.close()

Server side cursors
---------------------------------------------------------------------------------------------------------------

When a database query is executed, the Psycopg [`cursor`](https://www.psycopg.org/docs/cursor.html#cursor "cursor") usually fetches all the records returned by the backend, transferring them to the client process. If the query returned an huge amount of data, a proportionally large amount of memory will be allocated by the client.

If the dataset is too large to be practically handled on the client side, it is possible to create a *server side* cursor. Using this kind of cursor it is possible to transfer to the client only a controlled amount of data, so that a large dataset can be examined without keeping it entirely in memory.

Server side cursor are created in PostgreSQL using the [`DECLARE`](https://www.postgresql.org/docs/current/static/sql-declare.html) command and subsequently handled using `MOVE`, `FETCH` and `CLOSE` commands.

Psycopg wraps the database server side cursor in *named cursors*. A named cursor is created using the [`cursor()`](https://www.psycopg.org/docs/connection.html#connection.cursor "connection.cursor") method specifying the *name* parameter. Such cursor will behave mostly like a regular cursor, allowing the user to move in the dataset using the [`scroll()`](https://www.psycopg.org/docs/cursor.html#cursor.scroll "cursor.scroll") method and to read the data using [`fetchone()`](https://www.psycopg.org/docs/cursor.html#cursor.fetchone "cursor.fetchone") and [`fetchmany()`](https://www.psycopg.org/docs/cursor.html#cursor.fetchmany "cursor.fetchmany") methods. Normally you can only scroll forward in a cursor: if you need to scroll backwards you should declare your cursor [`scrollable`](https://www.psycopg.org/docs/cursor.html#cursor.scrollable "cursor.scrollable").

Named cursors are also [iterable](https://www.psycopg.org/docs/cursor.html#cursor-iterable) like regular cursors. Note however that before Psycopg 2.4 iteration was performed fetching one record at time from the backend, resulting in a large overhead. The attribute [`itersize`](https://www.psycopg.org/docs/cursor.html#cursor.itersize "cursor.itersize") now controls how many records are fetched at time during the iteration: the default value of 2000 allows to fetch about 100KB per roundtrip assuming records of 10-20 columns of mixed number and strings; you may decrease this value if you are dealing with huge records.

Named cursors are usually created `WITHOUT HOLD`, meaning they live only as long as the current transaction. Trying to fetch from a named cursor after a [`commit()`](https://www.psycopg.org/docs/connection.html#connection.commit "connection.commit") or to create a named cursor when the connection is in [`autocommit`](https://www.psycopg.org/docs/connection.html#connection.autocommit "connection.autocommit") mode will result in an exception. It is possible to create a `WITH HOLD` cursor by specifying a `True` value for the `withhold` parameter to [`cursor()`](https://www.psycopg.org/docs/connection.html#connection.cursor "connection.cursor") or by setting the [`withhold`](https://www.psycopg.org/docs/cursor.html#cursor.withhold "cursor.withhold") attribute to `True` before calling [`execute()`](https://www.psycopg.org/docs/cursor.html#cursor.execute "cursor.execute") on the cursor. It is extremely important to always [`close()`](https://www.psycopg.org/docs/cursor.html#cursor.close "cursor.close") such cursors, otherwise they will continue to hold server-side resources until the connection will be eventually closed. Also note that while `WITH HOLD` cursors lifetime extends well after [`commit()`](https://www.psycopg.org/docs/connection.html#connection.commit "connection.commit"), calling [`rollback()`](https://www.psycopg.org/docs/connection.html#connection.rollback "connection.rollback") will automatically close the cursor.

Note

It is also possible to use a named cursor to consume a cursor created in some other way than using the `DECLARE` executed by [`execute()`](https://www.psycopg.org/docs/cursor.html#cursor.execute "cursor.execute"). For example, you may have a PL/pgSQL function returning a cursor:

CREATE FUNCTION reffunc(refcursor) RETURNS refcursor AS $$
BEGIN
    OPEN $1 FOR SELECT col FROM test;
    RETURN $1;
END;
$$ LANGUAGE plpgsql;

You can read the cursor content by calling the function with a regular, non-named, Psycopg cursor:

cur1 = conn.cursor()
cur1.callproc('reffunc', ['curname'])

and then use a named cursor in the same transaction to "steal the cursor":

cur2 = conn.cursor('curname')
for record in cur2:     # or cur2.fetchone, fetchmany...
    # do something with record
    pass

Thread and process safety
---------------------------------------------------------------------------------------------------------------------------

The Psycopg module and the [`connection`](https://www.psycopg.org/docs/connection.html#connection "connection") objects are *thread-safe*: many threads can access the same database either using separate sessions and creating a `connection` per thread or using the same connection and creating separate [`cursor`](https://www.psycopg.org/docs/cursor.html#cursor "cursor")s. In [DB API 2.0](https://www.python.org/dev/peps/pep-0249/) parlance, Psycopg is *level 2 thread safe*.

The difference between the above two approaches is that, using different connections, the commands will be executed in different sessions and will be served by different server processes. On the other hand, using many cursors on the same connection, all the commands will be executed in the same session (and in the same transaction if the connection is not in [autocommit](https://www.psycopg.org/docs/usage.html#transactions-control) mode), but they will be serialized.

The above observations are only valid for regular threads: they don't apply to forked processes nor to green threads. `libpq` connections [shouldn't be used by a forked processes](https://www.postgresql.org/docs/current/static/libpq-connect.html#LIBPQ-CONNECT), so when using a module such as [`multiprocessing`](https://docs.python.org/3/library/multiprocessing.html#module-multiprocessing "(in Python v3.8)") or a forking web deploy method such as FastCGI make sure to create the connections *after* the fork.

Connections shouldn't be shared either by different green threads: see [Support for coroutine libraries](https://www.psycopg.org/docs/advanced.html#green-support) for further details.

Using COPY TO and COPY FROM
-------------------------------------------------------------------------------------------------------------------------------

Psycopg [`cursor`](https://www.psycopg.org/docs/cursor.html#cursor "cursor") objects provide an interface to the efficient PostgreSQL [`COPY`](https://www.psycopg.org/docs/usage.html#copy) command to move data from files to tables and back.

Currently no adaptation is provided between Python and PostgreSQL types on `COPY`: the file can be any Python file-like object but its format must be in the format accepted by [PostgreSQL COPY command](https://www.postgresql.org/docs/current/static/sql-copy.html) (data format, escaped characters, etc).

The methods exposed are:

[`copy_from()`](https://www.psycopg.org/docs/cursor.html#cursor.copy_from "cursor.copy_from")

Reads data *from* a file-like object appending them to a database table (`COPY table FROM file` syntax). The source file must provide both `read()` and `readline()` method.

[`copy_to()`](https://www.psycopg.org/docs/cursor.html#cursor.copy_to "cursor.copy_to")

Writes the content of a table *to* a file-like object (`COPY table TO file` syntax). The target file must have a `write()` method.

[`copy_expert()`](https://www.psycopg.org/docs/cursor.html#cursor.copy_expert "cursor.copy_expert")

Allows to handle more specific cases and to use all the `COPY` features available in PostgreSQL.

Please refer to the documentation of the single methods for details and examples.

Access to PostgreSQL large objects
---------------------------------------------------------------------------------------------------------------------------------------------

PostgreSQL offers support for [large objects](https://www.postgresql.org/docs/current/static/largeobjects.html), which provide stream-style access to user data that is stored in a special large-object structure. They are useful with data values too large to be manipulated conveniently as a whole.

Psycopg allows access to the large object using the [`lobject`](https://www.psycopg.org/docs/extensions.html#psycopg2.extensions.lobject "psycopg2.extensions.lobject") class. Objects are generated using the [`connection.lobject()`](https://www.psycopg.org/docs/connection.html#connection.lobject "connection.lobject") factory method. Data can be retrieved either as bytes or as Unicode strings.

Psycopg large object support efficient import/export with file system files using the [`lo_import()`](https://www.postgresql.org/docs/current/static/lo-interfaces.html#LO-IMPORT) and [`lo_export()`](https://www.postgresql.org/docs/current/static/lo-interfaces.html#LO-EXPORT) libpq functions.

Changed in version 2.6: added support for large objects greater than 2GB. Note that the support is enabled only if all the following conditions are verified:

-   the Python build is 64 bits;
-   the extension was built against at least libpq 9.3;
-   the server version is at least PostgreSQL 9.3 ([`server_version`](https://www.psycopg.org/docs/connection.html#connection.server_version "connection.server_version") must be >= `90300`).

If Psycopg was built with 64 bits large objects support (i.e. the first two contidions above are verified), the `psycopg2.__version__` constant will contain the `lo64` flag. If any of the contition is not met several `lobject` methods will fail if the arguments exceed 2GB.

Two-Phase Commit protocol support
-------------------------------------------------------------------------------------------------------------------------------------------

New in version 2.3.

Psycopg exposes the two-phase commit features available since PostgreSQL 8.1 implementing the *two-phase commit extensions* proposed by the DB API 2.0.

The DB API 2.0 model of two-phase commit is inspired by the [XA specification](https://publications.opengroup.org/c193), according to which transaction IDs are formed from three components:

-   a format ID (non-negative 32 bit integer)
-   a global transaction ID (string not longer than 64 bytes)
-   a branch qualifier (string not longer than 64 bytes)

For a particular global transaction, the first two components will be the same for all the resources. Every resource will be assigned a different branch qualifier.

According to the DB API 2.0 specification, a transaction ID is created using the [`connection.xid()`](https://www.psycopg.org/docs/connection.html#connection.xid "connection.xid") method. Once you have a transaction id, a distributed transaction can be started with [`connection.tpc_begin()`](https://www.psycopg.org/docs/connection.html#connection.tpc_begin "connection.tpc_begin"), prepared using [`tpc_prepare()`](https://www.psycopg.org/docs/connection.html#connection.tpc_prepare "connection.tpc_prepare") and completed using [`tpc_commit()`](https://www.psycopg.org/docs/connection.html#connection.tpc_commit "connection.tpc_commit") or [`tpc_rollback()`](https://www.psycopg.org/docs/connection.html#connection.tpc_rollback "connection.tpc_rollback"). Transaction IDs can also be retrieved from the database using [`tpc_recover()`](https://www.psycopg.org/docs/connection.html#connection.tpc_recover "connection.tpc_recover") and completed using the above `tpc_commit()` and `tpc_rollback()`.

PostgreSQL doesn't follow the XA standard though, and the ID for a PostgreSQL prepared transaction can be any string up to 200 characters long. Psycopg's [`Xid`](https://www.psycopg.org/docs/extensions.html#psycopg2.extensions.Xid "psycopg2.extensions.Xid") objects can represent both XA-style transactions IDs (such as the ones created by the `xid()` method) and PostgreSQL transaction IDs identified by an unparsed string.

The format in which the Xids are converted into strings passed to the database is the same employed by the [PostgreSQL JDBC driver](https://jdbc.postgresql.org/): this should allow interoperation between tools written in Python and in Java. For example a recovery tool written in Python would be able to recognize the components of transactions produced by a Java program.