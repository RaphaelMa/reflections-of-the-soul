mobile = 1;

if (os_type == os_android)
{
   mobile = 0;
    show_debug_message("ta on")
}
else
{
    // Código a ser executado em outras plataformas
    mobile = 1;
	show_debug_message("ta off")
}