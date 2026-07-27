using_piano = false;

current_note = 0;
sharp_mode = false;
current_octave = 4;

hold_exit = 0;

current_sound = -1;


piano_flash = -1;
piano_flash_timer = 0;

piano_anim_timer = 0;

piano_cam_offset = 0;

cooldown_interact = 0;


piano_notes = [

    sfx_piano_C4,
    sfx_piano_Cs4,
    sfx_piano_D4,
    sfx_piano_Ds4,
    sfx_piano_E4,
    sfx_piano_F4,
    sfx_piano_Fs4,
    sfx_piano_G4,
    sfx_piano_Gs4,
    sfx_piano_A4,
    sfx_piano_As4,
    sfx_piano_B4,

    sfx_piano_C5,
    sfx_piano_Cs5,
    sfx_piano_D5,
    sfx_piano_Ds5,
    sfx_piano_E5,
    sfx_piano_F5,
    sfx_piano_Fs5,
    sfx_piano_G5,
    sfx_piano_Gs5,
    sfx_piano_A5,
    sfx_piano_As5,
    sfx_piano_B5,

    sfx_piano_C6,
    sfx_piano_Cs6
];

//RECONOCER CANCIONES//
played_notes = [];

note_names = [
	"C4","Cs4","D4","Ds4","E4","F4",
	"Fs4","G4","Gs4","A4","As4","B4",
	"C5","Cs5","D5","Ds5","E5","F5",
	"Fs5","G5","Gs5","A5","As5","B5",
	"C6","Cs6"
];


melodies = [
    {
        name: "Danny",
        notes: [
            "G4",
            "A4",
            "B4",
            "C5",
            "G4",
            "A4",
            "B4",
            "D5",
            "C5",
            "B4",
            "C5",
			"D5",
            "G4"
        ]
    },
	{
		name: "Don't Forget",
		notes: [
			"Ds5",
			"E5",
			"Fs5",
			"Fs5",
			"Fs5",
			"Fs5",
			"Fs5",
			"B4",
			"Ds5",
			"Cs5",
			"Cs5",
			"Cs5",
			"Cs5",
			"Cs5",
			"Ds5",
			"Cs5",
			"B4",
			"B4",
			"B4",
			"B4",
			"B4",
		]
	}
];