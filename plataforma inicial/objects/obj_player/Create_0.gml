#region valores

global.porta_conectada = noone; // Ou o valor padrão que você quer

//inputs

hspd = 0;
vspd = 0;
acel = 0.5;
decel = 0.6;
//speeds
max_hspd = 6;
grav = 0.47;
grav_max = 14;
//jump
groundbuffer = 12;
jumpheight = -20;
jumpbuffer = 12;
jumpheight_min = -3;

#endregion

#region sprites
//sprites
sprite_idle_normal = spr_player;
sprite_walk_normal = spr_playerWalk;
sprite_jump_normal = spr_playerJump;

sprite_idle_invisivel = spr_idlecrow;
sprite_walk_invisivel = spr_Pwalkcrow;
sprite_jump_invisivel = spr_Pjumpcrow;

condi_invi = false; // começa a condição como false
#endregion

#region pad
checar_portas = function(){
	var _num_portas = gamepad_get_device_count();
	var _gamepad = 0;
	for(var i = 0; i < _num_portas; i++){
		global.portas[i] = gamepad_is_connected(i);
		if(global.portas[i]){
			_gamepad = 1;
			global.porta_conectada = i;
		}
	}
	return _gamepad
}

controlar = function(){
	global.gamepad = checar_portas();
	
	if(global.gamepad){
		controlar_controle()
	}else{
		controlar_teclado()
	}
	
	
}
controlar_teclado = function(){
	
}

controlar_controle = function() {
    hspd = gamepad_axis_value(global.porta_conectada, gp_axislh) * max_hspd;
	
	if(jumpbuffer > 0){
	jumpbuffer--;
	if(gamepad_button_check(global.porta_conectada, gp_face1)) && (vspd > 0){
		jumpbuffer =0;
		vspd = jumpheight;
		
	}
}
var _onground = place_meeting(x, y+ groundbuffer, obj_block);

if(_onground) jumpbuffer = 10;

//variable jump height
if(vspd < 0) && (!gamepad_button_check_pressed(global.porta_conectada, gp_face1)){
	vspd = max(vspd, jumpheight);
}

vspd = clamp(vspd, jumpheight, grav_max);
}

#endregion

