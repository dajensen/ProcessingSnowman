# ProcessingSnowman
A sample started by Brek!

This is just a fun way to trade some ideas about the snowman.

The file has to run from a web server, but that web server can be your own computer.  There are lots of ways to set up a test server on your own computer, but the easiest is
to use the python SimpleHTTPServer.  If you have python installed (and if you don't, this is a good time to install it!), then just open a command prompt, go to the directory where these files exist, and type this:

python -m SimpleHTTPServer 8000

It probably won't say anything, it will just sit there and act busy, not asking you for input.  That's good.

Then open your web browser and type this in your address bar:

http://localhost:8000/snowman.html

You should see the snowman.  Change the file called "snowman.pde" and hit the "Refresh" button in your browser to see your changes.

## Another web server
For anyone using a Chromebook, just run the "Web Server for Chrome" app.  You'll need to tell it which directory contains the files, and you'll need to use this URL instead:

http://localhost:8887/snowman.html
