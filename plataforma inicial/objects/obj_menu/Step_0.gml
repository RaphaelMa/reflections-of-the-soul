
var _key_down = keyboard_check(vk_down) or gamepad_button_check(global.porta_conectada, gp_face1);
var _key_up = keyboard_check(vk_up) or gamepad_button_check(global.porta_conectada, gp_face4);
var _key_conf = keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.porta_conectada, gp_start);


if (_key_down && !down_pressed) {  
    down_pressed = true;
    index++;
    if (index > op_max - 1) {
        index = 0;
    }
} else if (!keyboard_check(vk_down) && !gamepad_button_check(global.porta_conectada, gp_face1)) {
    down_pressed = false;
}

if (_key_up && !up_pressed) {  
    up_pressed = true;
    index--;
    if (index < 0) {
        index = op_max - 1;
    }
} else if (!keyboard_check(vk_up) && !gamepad_button_check(global.porta_conectada, gp_face4)) {
    up_pressed = false;
}

if (_key_conf) {
    if (index == 0) { 
        room_goto(rm_level1);
    } else if (index == 1) { 
        game_end();
    }
}