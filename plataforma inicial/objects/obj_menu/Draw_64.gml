draw_set_font(ft_menu);
draw_set_color(c_white);
var _dist = 60;
var _gui_largura = display_get_gui_width();
var _gui_altura = display_get_gui_height();
var _x1 = _gui_largura/2;
var _y1 = _gui_altura/2;


for(var i = 0;i < op_max; i++){
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	if(index == i){
		draw_set_color(c_yellow);
	}else{
		draw_set_color(c_white);
	}
	
	draw_text(_x1, _y1 + (_dist* i), opcoes[i]);
}
draw_set_font(-1);