global.PlayerX = x;
global.PlayerY = y;
if (layer_exists("Traffic"))
{
	if (!instance_exists(oContinueBusController)) {instance_create_layer(0, 0, "Traffic", oContinueBusController);}
}
else
{
	if (!instance_exists(oContinueBusController)) {instance_create_depth(0, 0, 300, oContinueBusController);}
}