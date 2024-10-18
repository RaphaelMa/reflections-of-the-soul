controlar()

#region current stats

var _onground = place_meeting(x, y+ groundbuffer, obj_block);

#endregion

#region inputs
var _key_left = keyboard_check(vk_left);
var _key_right = keyboard_check(vk_right);
var _key_jump = keyboard_check_pressed(vk_up) or gamepad_button_check_pressed(global.porta_conectada, gp_face1);
var _key_jump_held = keyboard_check(vk_up) or gamepad_button_check(global.porta_conectada, gp_face1);


var _key_down = keyboard_check(vk_down);

#endregion

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

if(!_onground){
	sprite_index = spr_playerJump;
} else{
	if(hspd != 0){
		sprite_index = spr_playerWalk;
	}else {
		image_index = spr_player;
	}
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
#endregion