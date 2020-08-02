
const SUN_DIAMETER = 75;

const SNOWFLAKE_MOVEMENT_X = -1;
const SNOWFLAKE_MOVEMENT_Y = 4;
const SNOWFLAKE_CREATION_RATE = 5;
PShape gizzard_croc = loadShape("TestImage.svg");

// Global variables
let frame = 0;
let sun_x = 0;
let sun_y = 57;
let sun_click = 0;
let sun_color = {
    r: 247,
    g: 255,
    b: 0
}
let dark_sun = false;

size(MAX_WIDTH, MAX_HEIGHT);
frameRate(60);


void ground() {
    // ground
    noStroke();
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


void rotated_face(x, y, r) {
    // Switch to red outlines
    stroke(255, 0, 0);
    fill(255, 0, 0);

    let rotated = rotateAroundCenter(-10, -10, r);
    ellipse(x + rotated.x, y + rotated.y, 5, 5);
    rotated = rotateAroundCenter(10, -10, r);
    ellipse(x + rotated.x, y + rotated.y, 5, 5);
    stroke(0, 0, 0);
    fill(0, 0, 0);
    rotated = rotateAroundCenter(0, 10, r);
    ellipse(x + rotated.x, y + rotated.y, 5, 5);
}

void rotated_buttons(x, y, r) {
    stroke(0, 0, 0);
    fill(0, 0, 0);

    let rotated = rotateAroundCenter(0, -20, r);
    ellipse(x + rotated.x, y + rotated.y, 5, 5);
    rotated = rotateAroundCenter(0, 0, r);
    ellipse(x + rotated.x, y + rotated.y, 5, 5);
    rotated = rotateAroundCenter(0, 20, r);
    ellipse(x + rotated.x, y + rotated.y, 5, 5);
}

void hat(x_center, y_bottom, brim_width, crown_width, crown_height) {
    strokeWeight(3);
    fill(0, 0, 0);
    line(x_center - brim_width / 2, y_bottom, 
        x_center + brim_width / 2, y_bottom);
    rect(x_center - crown_width / 2, y_bottom - crown_height, crown_width, crown_height);
}

void snowman() {
/*
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
*/
}

void drawSnowball(obj) {
//    console.log(obj.position.y);
    fill(obj.color.fill.r, obj.color.fill.g, obj.color.fill.b);
    stroke(obj.color.stroke.r, obj.color.stroke.g, obj.color.stroke.b);
    strokeWeight(1);
    ellipse(obj.position.x, obj.position.y, obj.circleRadius * 2, obj.circleRadius * 2);
    if(obj.label === 'snowball_face') {
        rotated_face(obj.position.x, obj.position.y, obj.angle);
    }
    if(obj.label === 'snowball_buttons') {
        rotated_buttons(obj.position.x, obj.position.y, obj.angle);
    }
}

void drawQuadrilateral(obj) {
    fill(obj.color.fill.r, obj.color.fill.g, obj.color.fill.b);
    stroke(obj.color.stroke.r, obj.color.stroke.g, obj.color.stroke.b);
    strokeWeight(1);
    quad(obj.vertices[0].x, obj.vertices[0].y,
        obj.vertices[1].x, obj.vertices[1].y, 
        obj.vertices[2].x,  obj.vertices[2].y,
        obj.vertices[3].x,  obj.vertices[3].y);
}

void drawHat(obj) {
    let bodies = obj.bodies;
    for(int i = 0; i < bodies.length; i++) {
        drawQuadrilateral(bodies[i]);
    }
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

const GROUND_THICKNESS = 20;
let engineObjects = [
    {type:"snowball", x: 200, r: 30, options: {label: "snowball_face"}},
    {type:"snowball", x: 200, r: 40, options: {label: "snowball_buttons"}},
    {type:"snowball", x: 200, r: 60},
    {
        type: "rectangle", 
            x: MAX_WIDTH / 2, y: MAX_HEIGHT - GROUND_THICKNESS / 2, 
            width: MAX_WIDTH, height: GROUND_THICKNESS, 
            options: {
                label: "ground",
                isStatic: false,
                color: {
                    fill: {r: 255, g: 0, b: 0},
                    stroke: {r: 255, g: 0, b: 0}
                }
            }
    },
/*
    {
        type: "rectangle",
            width: 50, height: 50, options: {label: "ground", color: {fill: {r: 0, g: 255, b: 0}, stroke: {r: 0, g: 255, b: 0}}}
    }
    {type: "hat", x: 200, brimwidth: 100, crownwidth: 60, crownheight: 40}
*/
];

void engineObjCreate() {

    let groundThickness = 20;
    createRectangle(MAX_WIDTH / 2, MAX_HEIGHT - groundThickness / 2, 
                        MAX_WIDTH, groundThickness, {
                            label: "ground", 
                            color: {
                                fill: {r: 255, g:255, b:255},
                                stroke: {r: 255, g: 255, b: 255}
                            }
                        });
    createSnowball(200, 320, 60);
    createSnowball(200, 230, 40, {label: "snowball_buttons"});
    createSnowball(200, 165, 30, {label: "snowball_face"});
    createHat(200, 145, 100, 60, 40);
    createRectangle(270, 190, 80, 5, {
        label: "arm",
        isSleeping: true,
        density: 1.0,
        friction: 0.9,
        angle: -0.7,
        color: {
            fill: {r: 0, g: 0, b: 0},
            stroke: {r: 0, g: 0, b: 0}
        }
    });
    createRectangle(130, 190, -80, 5, {
        label: "arm",
        isSleeping: true,
        friction: 0.9,
        density: 1.0,
        angle: 0.7,
        color: {
            fill: {r: 0, g: 0, b: 0},
            stroke: {r: 0, g: 0, b: 0}
        }
    });
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

    // First frame - create objects that are in the physics engine
    if(frame == 2) {
        engineObjCreate();
    }

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
        shape(gizzard_croc, sun_x - SUN_DIAMETER / 2 + 2, sun_y - SUN_DIAMETER / 7, 70, 25);

    snowman();

    if(typeof(draw_objects) !== 'undefined') {
        for (int i = 0; i < draw_objects.length; i++) {
            switch(draw_objects[i].label) {
            case "snowball":
            case "snowball_face":
            case "snowball_buttons":
                drawSnowball(draw_objects[i]);
                break;
            case "ground":
            case "arm":
                drawQuadrilateral(draw_objects[i]);
                break;
            case "hat":
                drawHat(draw_objects[i]);
                break;
            }
        }
    }
}

void mousePressed() {
//    console.log("Clicked");
//    console.log(dist(mouseX, mouseY, sun_x, sun_y) / 2);
    if ((dist(mouseX, mouseY, sun_x, sun_y)) <= SUN_DIAMETER / 2) {
        ++sun_click;

        // Toggle dark sun mode
        dark_sun = !dark_sun;
        sun_color.g = dark_sun ? 0 : 255;   // If the sun is dark, set the Green component of the color to zero

        fallApart(world);
    }
}

