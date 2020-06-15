// This is your own web page, so you can make this BIG if you want to.
// But if you increase this, you'll probably want to change the position
// and size of the other objects.
const MAX_WIDTH = 400;
const MAX_HEIGHT = 400;

const SUN_DIAMETER = 75;

const SNOWFLAKE_MOVEMENT_X = -1;
const SNOWFLAKE_MOVEMENT_Y = 4;
const SNOWFLAKE_CREATION_RATE = 10;
PShape gizzard_croc;

// Global variables
let frame = 0;
let sun_x = 0;
let sun_y = 57;
let sun_click = 0;
let snowflakes = [];
let sun_color = {
    r: 247,
    g: 255,
    b: 0
}
let dark_sun = false;

size(MAX_WIDTH, MAX_HEIGHT);
frameRate(60);
gizzard_croc= loadShape("TestImage.svg");

void ground() {
    // ground
    fill(255, 255, 255);
    rect(0, 350, 400, 50); 
}

void sun(x, y) {
    //if (sun_click % 2) {
    //    dancer_sun(x, y);
    //} else {
        //sun
        noStroke();
        fill(sun_color.r, sun_color.g, sun_color.b);
        strokeWeight(1);
        ellipse (x, y, SUN_DIAMETER, SUN_DIAMETER);
    //}
}

void face(x, y) {
    // Switch to red outlines
    stroke(255, 0, 0);
    fill(255, 0, 0);
    ellipse(x - 10, y - 10, 5, 5);
    ellipse(x + 10, y - 10, 5, 5);
    stroke(0, 0, 0);
    fill(0, 0, 0);
    ellipse(x, y + 10, 5, 5);
}

void hat(x_center, y_bottom, brim_width, crown_width, crown_height) {
    strokeWeight(3);
    fill(0, 0, 0);
    line(x_center - brim_width / 2, y_bottom, 
        x_center + brim_width / 2, y_bottom);
    rect(x_center - crown_width / 2, y_bottom - crown_height, crown_width, crown_height);
}

void snowman() {
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

void drawSnowflake(snowflake) {
    // This function gets called once for each snowflake,
    // And the location of the ellipse is *dynamic* based on the position
    // of each snowflake.
    fill(255, 255, 255);
    strokeWeight(1);
    ellipse(snowflake.x, snowflake.y, 10, 10);
}

// This is the timer that calculates where the sun should be, based on how long the program has been running.
void calculate_sun_position() {
    // Now just shift the sun one pixel to the right.
    // Store the "sun position" in a global variable (not inside a function)
    // so it will still be there next time you come back.
    sun_x++;

    // And if the sun runs off the right side of the scene, move it back to the left side.
    if(sun_x > MAX_WIDTH)
        sun_x = 0;
}

void animateSnowflakes() {
    // Move every snowflake just a little during this frame
    for (let i = 0; i < snowflakes.length; i++) {
        const snowflake = snowflakes[i];
        snowflake.x = snowflake.x + SNOWFLAKE_MOVEMENT_X;
        snowflake.y = snowflake.y + SNOWFLAKE_MOVEMENT_Y;
    }
}

void deleteHiddenSnowflakes() {
    const visibleSnowflakes = [];

    for (let i = 0; i < snowflakes.length; i++) {
        const currentSnowflake = snowflakes[i];
        if (currentSnowflake.y >= 0) {
            // Only keep a snowflake if it is visible!
            visibleSnowflakes.push(currentSnowflake);
        }
    }

    // Swap out the global `snowflakes` variable with our new array
    snowflakes = visibleSnowflakes;
}

void createSnowflake() {
    const newSnowflake = {
        // Choose a random position from left to right
        x: Math.random() * 450,

        // Start at the top
        y: 0
    };

    snowflakes.push(newSnowflake);
}

// *************************************************************
// This is the entry point
// *************************************************************
// This function gets called all the time, at a rate defined by the frameRate(60) function call at the top of this file.
// So if you want to animate something, just do this:
//     1. Calculate the new positions here, based on how long the program has been running 
//     2. Then draw the background over everything, to erase what was there before
//     3. And then draw the scene again with things in their new positions.
// Because we set the frame rate to 60, this function is executed every 1/60 second.
void draw() {
    frame = frame + 1;

    // This is the `modulo` operator, which means the remainder of a long divison.
    // So this part basically means:
    // "if the frame is a multiple of 10, create a snowflake"
    if (frame % SNOWFLAKE_CREATION_RATE === 0) {
        createSnowflake();
    }

    animateSnowflakes();

    deleteHiddenSnowflakes();

    calculate_sun_position();

    // Filling the background erases what was there before.
    // The ground and background combine to fill the entire picture.
    background(78, 23, 230);
    ground();

    // I wanted the sun to go behind the snowman, not in front.
    // So if we draw it first, then draw the snowman, the snowman
    // will cover up the sun, so it looks like the sun is behind the snowman.
    sun(sun_x, sun_y);
    if(dark_sun)
        shape(gizzard_croc, sun_x - SUN_DIAMETER / 2, sun_y - SUN_DIAMETER / 2, 80, 80);

    snowman();

    // Draw each of the snowflakes
    for (var i = 0; i < snowflakes.length; i++) {
        drawSnowflake(snowflakes[i]);
    }

}

void mousePressed() {
    console.log("Clicked");
    console.log(dist(mouseX, mouseY, sun_x, sun_y) / 2);
    if ((dist(mouseX, mouseY, sun_x, sun_y)) <= SUN_DIAMETER / 2) {
        ++sun_click;

        // Toggle dark sun mode
        dark_sun = !dark_sun;
        sun_color.g = dark_sun ? 0 : 255;   // If the sun is dark, set the Green component of the color to zero
    }
}

