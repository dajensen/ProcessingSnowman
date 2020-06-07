const MAX_WIDTH = 400;
const MAX_HEIGHT = 400;

size(MAX_WIDTH, MAX_HEIGHT);

function ground() {
    // ground
    fill(255, 255, 255);
    rect(0, 350, 400, 50); 
}

function sun(x, y) {
    //sun
    fill(247, 255, 0);
    strokeWeight(1);
    ellipse (x, y, 75, 75);
}

function face() {

}

function snowman() {
    // bottom
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

    // left arm
    strokeWeight(5);
    line(160, 200, 100, 150);

    // left arm
    strokeWeight(5);
    line(240, 200, 300, 150);
}

let prev_time = 0;
let sunpos = 0;

draw = function() {
    let curr_time = millis();
    if(curr_time - prev_time > 10) {
        prev_time = curr_time;
        sunpos++;
        if(sunpos > MAX_WIDTH)
            sunpos = 0;
    }

    background(78, 23, 230);
    ground();
    snowman();
    sun(sunpos, 57);
}
