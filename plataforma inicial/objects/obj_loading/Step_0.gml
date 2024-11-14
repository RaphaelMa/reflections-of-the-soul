if(instance_exists(obj_loading)){
time++;
if(loaded==false){
if(time>=160){ 
time = 0;
loaded = true;
}
}
if(loaded==true){
with(obj_loading){
instance_destroy();
}
}
}
