# ProcessingSnowman

This project got ridiculously out of hand, in a good way!

It started out as a Khan Academy challenge.  My nephew, Brek, took the challenge and did a great job of building a snowman using Processing.js on the Khan Academy site.  

That was interesting, but once it was done, it just felt like a completed homework assignment, not something to share with friends. More importantly, it was just a static picture that didn't change.  He started asking how he could build something more complex, like a game, and how could he make it be his own thing?

The snowman challenge is a great way to introduce children to the idea of programming, and it teaches programming concepts through increasingly complex steps.  However, Brek didn't just want to do educational challenges.  He wanted to know how to use the tools he was being introduced to, so he immediately started asking questions like, "What good are variables?"  That's a great question that deserves a clear answer.

In response, some of us in Brek's family worked up a series of stages that answer questions like "What good are variables" and "What are functions and why do you want them?"  They build in complexity until eventually they could conceivably become a simple game.

That's the purpose of this project.  It's true to the original challenge's concept of building skills by adding complexity step-by-step, but it focuses on the things that we, as professional coders, find most useful.  And we definitely did let it get out of control.  The original challenge definitely didn't include a physics engine...

## What's here
There's a simple web server that will let you look at the examples and read the information about the concept each example is trying to illustrate.

While the examples are fun to look at, and the writeups will hopefully be educational, the point is to look at the code!  And modify the code.  The difference between this activity and a web-based school challenge is that you'll be using the tools that professional programmers really use, and in the end you'll have something that is clearly your own.

## Prerequisites
To write software that you can share with others, you need some tools.  Here's a set of tools that will work well for this project. Professional coders use a wide variety of tools, and they're always looking for something new.  Start with this set, and feel free to experiment with additional tools!

1. Install **node.js** from https://nodejs.org/en/download/.  As you progress through these samples, you'll learn an increasing amount of Javascript, which is the language of Node.js.  Node also provides the web server that will display the examples. Many companies use Node.js as the software for their production web servers.
2. Install **Visual Studio Code** from https://code.visualstudio.com/download and set it up by following the instructions here: https://code.visualstudio.com/docs/setup/setup-overview.  Visual Studio Code is an excellent source code editor that many professional coders use daily.
3. Install **Source Tree** from https://www.sourcetreeapp.com/.  It will probably require you to create a free Atlassian account.  This visual source control tool will store the changes you make, which means that you'll be able to make big changes, knowing that you can always go back to a previous version if stuff got messed up too badly.  It will also show exactly what changes you've made since the last time you committed code, which will highlight the places where you might have made mistakes.
4. Get a **github** account and "fork" this repository. Then you'll have your own copy of this project under your own github account.  Then go to Source Tree and clone your github repository. Once you've done that, you'll be able to use Source Tree to commit your changes to github, where you can share them.  If you want to submit changes to the original repository, you can submit a "pull request".

Of course this seems like overkill when compared to a simple web interface on an educational site.  That's true.  But none of this is difficult, and when you're done, you're running a set of industrial-grade tools that can take you much further than a simple snowman.

## Installation
After you have installed the tools and pulled down the source, go to the directory containing this file and download the modules required by the node.js web server by running

    npm install
    
Then start the web server by running 

    npm start

Now go to your web browser, open a new tab, and type

    http://localhost:3000


You should see the project!  From there, you can browse between versions of the project.  Each step is contained in a separate directory, so you can use Visual Studio Code to edit the source in those directories and watch how it changes in your own web browser.

## A note about chromebooks
A previous version of this project worked on Chromebooks.  This version won't do that.  But it would run really well on a Raspberry Pi.  That would be educational too.
