var _key_down = keyboard_check(vk_down) or gamepad_button_check(global.porta_conectada, gp_face4);
var _key_up = keyboard_check(vk_up) or gamepad_button_check(global.porta_conectada, gp_face1);
var _key_conf = keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.porta_conectada, gp_face3);


// Navegação por toque (mobile)
if (device_mouse_check_button_pressed(0, 0)) {
    var touch_x = device_mouse_x_to_gui(0);
    var touch_y = device_mouse_y_to_gui(0);
    
    var _dist = 60;
    var _y1 = display_get_gui_height() / 2;
    
    for (var i = 0; i < op_max; i++) {
        var _option_y = _y1 + (_dist * i);
        
        if (touch_y > _option_y - 20 && touch_y < _option_y + 20) { // Verifica se o toque está na opção
            option_clicked = i;
            break;
        }
    }
}

if (option_clicked != -1) {
    index = option_clicked;
    if (device_mouse_check_button_released(0, 0)) { // Confirma a seleção quando o toque é solto
        if (index == 0) {
            room_goto(rm_level1);
        } else if (index == 1) {
            game_end();
        }
        option_clicked = -1; // Reseta o clique
    }
}

//pc e controle

/*if (_key_down && !down_pressed) {  
    index++;
    if (index > op_max - 1) {
        index = 0;
    }
} else if (!keyboard_check(vk_down) && !gamepad_button_check(global.porta_conectada, gp_face4)) {
    down_pressed = false;
}
*/

if (_key_up && !up_pressed) {  
    up_pressed = true;
    index--;
    if (index < 0) {
        index = op_max - 1;
		
    }
} else if (!keyboard_check(vk_up) && !gamepad_button_check(global.porta_conectada, gp_face1)) {
    up_pressed = false;
}

if (_key_conf) {
    if (index == 0) { 
        room_goto(rm_level1);
    } else if (index == 1) { 
        game_end();
    }
}