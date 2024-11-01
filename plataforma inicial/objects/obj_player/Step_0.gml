controlar()

#region current stats

var _onground = place_meeting(x, y+ groundbuffer, obj_block);

#endregion

#region variáveis de toque

// Variáveis de estado para cada botão
var _touch_left = false;
var _touch_right = false;
var _touch_jump = false;

// Converte a posição de toque para coordenadas da GUI
for (var touch = 0; touch < 12; touch += 1) {
    //coordenadas do toque atual
    var touch_x = device_mouse_x_to_gui(touch);
    var touch_y = device_mouse_y_to_gui(touch);
    
    // Verifica se o toque está ativo para o índice atual
    if (device_mouse_check_button(touch, mb_left)) {
        // Botão para mover à esquerda
        if (touch_x >= 20 && touch_x <= 100 + 100 + 20 && touch_y >= room_height - 150 - 20 && touch_y <= room_height - 150 + 50 + 20) {
            _touch_left = true;
        }

        // Botão para mover à direita
        if (touch_x >= 280 && touch_x <= 350 + 150 + 20 && touch_y >= room_height - 150 - 20 && touch_y <= room_height - 150 + 50 + 20) {
            _touch_right = true;
        }

        // Botão de pulo
        if (touch_x >= 1150 - 20 && touch_x <= 1150 + 150 + 20 && touch_y >= room_height - 160 - 20 && touch_y <= room_height - 220 + 50 + 20) {
            _touch_jump = true;
        }
    }
}
#endregion

#region inputs
var _key_left = keyboard_check(vk_left) || _touch_left or gamepad_button_check(global.porta_conectada, gp_shoulderlb);
var _key_right = keyboard_check(vk_right) || _touch_right or gamepad_button_check(global.porta_conectada, gp_shoulderrb)
var _key_jump = keyboard_check_pressed(vk_up) || _touch_jump || gamepad_button_check_pressed(global.porta_conectada, gp_face1);
var _key_jump_held = keyboard_check(vk_up) || _touch_jump || gamepad_button_check(global.porta_conectada, gp_face1);

#endregion

var _key_down = keyboard_check(vk_down);


#region move


//direction
var _dir = _key_right - _key_left;

//horizontal spd
hspd += _dir*acel;

//slow when no key pressed
if(_dir == 0){
	if(hspd < 0){
		hspd = min(hspd + decel, 0);
	}else{
		hspd = max(hspd - decel, 0);
	}
}

hspd = clamp(hspd, -max_hspd, max_hspd);

//gravity
vspd += grav; 

//ground jump
if(jumpbuffer > 0){
	jumpbuffer--;
	if(_key_jump) && (vspd > 0){
		jumpbuffer =0;
		vspd = jumpheight;
		
	}
}
if(_onground) jumpbuffer = 10;

//variable jump height
if(vspd < 0) && (!_key_jump_held){
	vspd = max(vspd, jumpheight_min);
}

vspd = clamp(vspd, jumpheight, grav_max);

#endregion

#region collision

//horizontal collision
if(place_meeting(x+hspd, y, obj_block)){
	var _x = round(x);
	var _pixel = sign(hspd);
	while(!place_meeting(_x+_pixel, y, obj_block)) _x += _pixel;
	x = _x;
	hspd = 0;
}

//vertical collision
if(place_meeting(x, y+vspd, obj_block)){
	var _y = round(y);
	var _pixel = sign(vspd);
	while(!place_meeting(x, y+vspd, obj_block)) _y += _pixel;
	y = _y;
	vspd = 0;
}
#endregion

 #region animation
image_speed = 1;
if(hspd != 0) image_xscale = sign(hspd);


if (condi_invi) {
    if (!_onground) {
        sprite_index = spr_Pjumpcrow; 
    } else {
        if (hspd != 0) {
            sprite_index = spr_Pwalkcrow; 
        } else {
            sprite_index = spr_idlecrow; 
        }
    }
} else {
 if (!_onground) {
    sprite_index = spr_playerJump;
} else {
    if (hspd != 0) {
        if (abs(hspd) <= 4) {
            sprite_index = spr_playerWalk;
        }
        else if (abs(hspd) >= 5) {
            sprite_index = spr_playerRun;
        }
    } else {
        sprite_index = spr_player;
    }
}

#endregion
 
 #region item
if place_meeting(x, y, obj_crow) {
    instance_destroy(obj_crow);
    
    condi_invi = true;
    
    image_alpha = 0.5;
}
 #endregion
 
 #region tira item
 if place_meeting(x, y, obj_remove) {
    condi_invi = false; 
    image_alpha = 1;
}
 #endregion

//move
x += hspd;
y += vspd;


#region deletar

//test (deletar)
if(keyboard_check_pressed(vk_enter)){
	game_restart();
}
}
#endregion