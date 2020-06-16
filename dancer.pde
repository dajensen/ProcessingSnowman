"use strict";

// Global constants related to Dancer features.
const SPARKLE_CREATION_RATE = 2;
const SPARKLE_MOVEMENT_X = 1.3;

// Global variables related to Dancer features.
let sunSparkles = [];

function _createSparkle(numSparkleLines) {
    let displacements = _getDancerSunLineDisplacements(numSparkleLines);
    // Choose a random line to have a sparkle
    let line_i = Math.round(Math.random() * (displacements.length - 1));
    // Safety net in case we accidentally round to an unreachable index.
    if (line_i >= displacements.length) {
        line_i = displacements.length - 1;
    } else if (line_i < 0) {
        line_i = 0;
    }
    const newSparkle = {
        // Start at the left
        x_displacement: displacements[line_i][0],
        y_displacement: displacements[line_i][1],
        max_x_displacement: -1 * displacements[line_i][0]
    };

    sunSparkles.push(newSparkle);
}

function _deleteHiddenSparkles() {
    sunSparkles = sunSparkles.filter(
        sparkle => sparkle.x_displacement > sparkle.max_x_displacement
    );
}

function _animateSparkles() {
    // Move every sparkle just a little during this frame
    sunSparkles.map(sparkle=>sparkle.x_displacement -= SPARKLE_MOVEMENT_X);
}

/**
 * This star code is taken from the example
 * located at https://processing.org/examples/star.html
 */
function star(x, y, radius1, radius2, npoints) {
    let angle = TWO_PI / npoints;
    let halfAngle = angle/2.0;
    beginShape();
    for (let a = 0; a < TWO_PI; a += angle) {
      let sx = x + cos(a) * radius2;
      let sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }

function _drawSparkle(sparkle, sun_x, sun_y) {
    // This function gets called once for each sparkle,
    // And the location of the ellipse is *dynamic* based on the position
    // of each sparkle.
    fill(255, 255, 255);
    strokeWeight(1);
    let npoints = 9;
    let innerRadius = 1;
    let outerRadius = 4;
    star(sun_x - sparkle.x_displacement, sun_y - sparkle.y_displacement, outerRadius, innerRadius, npoints);
}

/** Gets x and y displacements for the start of lines along a circle.
 * Returns an array of tuples which are
 * displacements for each line on the disco ball.
 * @param numLines number of lines for which to retrieve displacements
 */
function _getDancerSunLineDisplacements(numLines) {
    let displacements = [];
    
    // Start at 1 because there is no line at the top tip of the circle.
    // Include i = numLines because numLines+1 represents the bottom tip of the circle.
    for (let i = 1; i < numLines+1; ++i) {
        // Finds the vertical displacement of the line from the center of the circle.
        // This is a linear increase in y-value from top to bottom of the circle
        let line_y_displacement = (i * SUN_DIAMETER / (numLines + 1)) - (SUN_DIAMETER / 2);
        // Finds the horizontal displacement of each end of the lines from the center of the circle.
        // Uses the Pythagorean theorem (side1**2 + side2**2 = hypotenuse**2)
        let line_x_displacement = sqrt(sq(SUN_DIAMETER / 2) - sq(line_y_displacement));
        displacements.push([line_x_displacement, line_y_displacement]);
    }
    
    return displacements
}

/** Draws lines on the disco ball sun.
 * 
 * @param x x-position of sun center
 * @param y y-position of sun center
 * @param numLines number of lines to draw on the disco ball sun
 */
function _drawDancerSunLines(x, y, numLines) {
    let displacements = _getDancerSunLineDisplacements(numLines);

    for (let i = 0; i < displacements.length; ++i) {
        let line_x_displacement = displacements[i][0];
        let line_y_displacement = displacements[i][1];
        stroke(170, 160, 195);
        strokeWeight(1);
        line(
            x - line_x_displacement,
            y - line_y_displacement,
            x + line_x_displacement,
            y - line_y_displacement
        );
    }
}

/** Draws the sun as a disco ball, and handles its animation.
 * 
 * @param x x-position of sun center
 * @param y y-position of sun center
 */
function dancerSun(x, y) {
    // disco ball sun
    stroke(170, 160, 195);
    fill(130, 120, 155);
    strokeWeight(1);
    ellipse(x, y, SUN_DIAMETER, SUN_DIAMETER);
    let numLines = 10;
    let numSparkleLines = numLines + 1;
    // Draw lines on the disco sun
    _drawDancerSunLines(x, y, numLines);
    // Make new sparkles at a regular rate
    if (frame % SPARKLE_CREATION_RATE === 0) {
        _createSparkle(numSparkleLines);
    }
    // Move the sparkles
    _animateSparkles();
    // Remove sparkles that have rounded the disco ball
    _deleteHiddenSparkles();
    // Draw each sparkle
    sunSparkles.map(sparkle=>_drawSparkle(sparkle, x, y));
}
