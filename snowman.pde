// This is your own web page, so you can make this BIG if you want to.
// But if you increase this, you'll probably want to change the position
// and size of the other objects.
const MAX_WIDTH = 400;
const MAX_HEIGHT = 400;

var frame = 0;

size(MAX_WIDTH, MAX_HEIGHT);

frameRate(60);

function ground() {
    // ground
    strokeWeight(1);
    stroke(255, 255, 255);
    fill(255, 255, 255);
    rect(0, 350, 400, 50); 
}

function sun(x, y) {
    //sun
    stroke(247, 255, 0);
    fill(247, 255, 0);
    strokeWeight(1);
    ellipse (x, y, 75, 75);
}

function face(x, y) {
    // Switch to red outlines
    stroke(255, 0, 0);
    fill(255, 0, 0);
    ellipse(x - 10, y - 10, 5, 5);
    ellipse(x + 10, y - 10, 5, 5);
    stroke(0, 0, 0);
    fill(0, 0, 0);
    ellipse(x, y + 10, 5, 5);
}

function hat(x_center, y_bottom, brim_width, crown_width, crown_height) {
    strokeWeight(3);
    fill(0, 0, 0);
    line(x_center - brim_width / 2, y_bottom, 
        x_center + brim_width / 2, y_bottom);
    rect(x_center - crown_width / 2, y_bottom - crown_height, crown_width, crown_height);
}

function snowman() {
    // bottom
    fill(255, 255, 255);
    stroke(0, 0, 0);
    ellipse(200, 300, 150, 150); 

    // middle
    ellipse(200, 200, 100, 100); 
    fill(0, 0, 0);
    ellipse(200, 180, 7, 7);
    ellipse(200, 200, 7, 7);
    ellipse(200, 220, 7, 7);

    // top
    fill(255, 255, 255);
    ellipse(200, 120, 75, 75);
    face(200, 120);
    hat(200, 100, 100, 60, 40);

    // left arm
    strokeWeight(5);
    line(160, 200, 100, 150);

    // left arm
    strokeWeight(5);
    line(240, 200, 300, 150);
}

// This is the timer that calculates where the sun should be, based on how long the program has been running.
function calculate_sun_position() {
    // Now just shift the sun one pixel to the right.
    // Store the "sun position" in a global variable (not inside a function)
    // so it will still be there next time you come back.
    sunpos++;

    // And if the sun runs off the right side of the scene, move it back to the left side.
    if(sunpos > MAX_WIDTH)
        sunpos = 0;
}

// Global variables
let prev_time = 0;
let sunpos = 0;

// *************************************************************
// This is the entry point
// *************************************************************
// This function gets called all the time, as fast as possible.
// So if you want to animate something, just do this:
//     1. Calculate the new positions here, based on how long the program has been running 
//     2. Then draw the background over everything, to erase what was there before
//     3. And then draw the scene again with things in their new positions.
draw = function() {
    frame = frame + 1;

    calculate_sun_position();

    // Filling the background erases what was there before.
    // The ground and background combine to fill the entire picture.
    background(78, 23, 230);
    ground();

    // I wanted the sun to go behind the snowman, not in front.
    // So if we draw it first, then draw the snowman, the snowman
    // will cover up the sun, so it looks like the sun is behind the snowman.
    sun(sunpos, 57);
    snowman();
}
