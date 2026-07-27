timer++;

alpha = 1 - (timer / fade_time);

if (timer >= fade_time) {
	SaveGame();
    instance_destroy();
}