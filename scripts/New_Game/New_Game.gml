function New_Game(){
    Items();
	PhoneContacts();
	phone_add_contact("Home");
	
	
    global.Money = 250;
    global.InventoryLength = 8;
    global.Musical_HighScore_SAVED = {};
    global.Inventory = [
        { item_id: "Flower" },
        { item_id: "Candle" },
        { item_id: "Mailman_Pin" }
    ];
    global.game_minutes = 6 * 60 + 30;
    global.time_speed = 0.003;
    global.time_paused = false;    
    global.PlayerX = 230;
    global.PlayerY = 100;
    global.HasShowered = 0;
    global.KnockedDoorMom = false;
    global.Bed_times_slept = 0;
    global.Is_Indoors = true;
    global.Loaded_Game = false;
    global.Platformer_Final_Score = 0;
	global.StoreNumberStory = 0;
	global.DuckStory = 0;
    
    global.WEATHER = [];
    var climas = ["normal", "soleado", "nublado", "tormentoso", "lluvia", "nevada", "vientoso"];
    
    var clima_actual = choose("normal", "soleado", "nublado");
    array_push(global.WEATHER, clima_actual);
    
    while (array_length(global.WEATHER) < 12) {
        var pesos = array_create(7, 10);
        
        // El orden de los índices es: 0=normal, 1=soleado, 2=nublado, 3=tormentoso, 4=lluvia, 5=nevada, 6=vientoso
        switch (clima_actual) {
            case "normal":
                pesos[0] = 50; pesos[1] = 20; pesos[2] = 15; pesos[3] = 0; pesos[4] = 5; pesos[5] = 0; pesos[6] = 10;
                break;
            case "soleado":
                pesos[0] = 30; pesos[1] = 50; pesos[2] = 10; pesos[3] = 0; pesos[4] = 0; pesos[5] = 0; pesos[6] = 10;
                break;
            case "nublado":
                pesos[0] = 15; pesos[1] = 5; pesos[2] = 30; pesos[3] = 15; pesos[4] = 20; pesos[5] = 10; pesos[6] = 5;
                break;
            case "tormentoso":
                pesos[0] = 0; pesos[1] = 0; pesos[2] = 20; pesos[3] = 40; pesos[4] = 40; pesos[5] = 0; pesos[6] = 0;
                break;
            case "lluvia":
                pesos[0] = 10; pesos[1] = 0; pesos[2] = 30; pesos[3] = 20; pesos[4] = 40; pesos[5] = 0; pesos[6] = 0;
                break;
            case "nevada":
                pesos[0] = 10; pesos[1] = 0; pesos[2] = 40; pesos[3] = 0; pesos[4] = 0; pesos[5] = 50; pesos[6] = 0;
                break;
            case "vientoso":
                pesos[0] = 30; pesos[1] = 30; pesos[2] = 10; pesos[3] = 0; pesos[4] = 10; pesos[5] = 0; pesos[6] = 20;
                break;
        }
        
        var suma_total = 0;
        for (var i = 0; i < array_length(pesos); i++) {
            suma_total += pesos[i];
        }
        
        var valor_aleatorio = irandom(suma_total - 1);
        var suma_actual = 0;
        var indice_elegido = 0;
        
        for (var i = 0; i < array_length(pesos); i++) {
            suma_actual += pesos[i];
            if (valor_aleatorio < suma_actual) {
                indice_elegido = i;
                break;
            }
        }
        
        clima_actual = climas[indice_elegido];
        array_push(global.WEATHER, clima_actual);
    }

    if(!instance_exists(oTimeAtmosphere)){
        instance_create_layer(0,0,"Atmosphere",oTimeAtmosphere);
    }
    if(!instance_exists(oTime)){
        instance_create_layer(0,0,"Time",oTime);
    }
    if(!instance_exists(oShadow_Light)){
        instance_create_depth(0,0,-9999,oShadow_Light);
    }
	if(!instance_exists(oWeather)){
		instance_create_depth(0,0,-9999,oWeather);
	}
}