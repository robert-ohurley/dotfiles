/*:55,65/home

This is my keymapping for my Sofle V2. Initially the plan was to add home row mods and remove the furthest columns of keys from each half of the keyboard. 
The idea here being to minimize pinky travel. As the only real mod keys I want are shift and ctrl, I've moved them to the thumb cluster.

IMPLEMENT
rearrange the action keys on the left hand to make it better
play around with the tapping time as i keep capitalising insteadOf spacing. Or see if there's a feature i can use. 
maybe swap the quote and double quote positions around as single should be higher priority for typing therefore closer to the home row. 
*/

#include QMK_KEYBOARD_H

// Left-hand mods
#define MOD_BSPC LSFT_T(KC_BSPC)

// Right-hand mods
#define MOD_SPC RSFT_T(KC_SPACE)

enum sofle_layers {
    _QWERTY,
    _SYMBOLS,
    _ACTIONS,
	_ADJUST
};

enum custom_keycodes {
    KC_QWERTY,
    KC_COLEMAK,
    KC_LOWER,
    KC_RAISE,
    KC_ADJUST,
    KC_PRVWD,
    KC_NXTWD,
    KC_LSTRT,
    KC_LEND,
    KC_DLINE
};


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/*
 * QWERTY
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * | XXXX |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  | XXXX |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | XXXX |   Q  |   W  |   E  |   R  |   T  |                    |   Y  |   U  |   I  |   O  |   P  | XXXX |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | XXXX |   A  |   S  |   D  |   F  |   G  |-------.    ,-------|   H  |   J  |   K  |   L  |   ;  | XXXX |
 * |------+------+------+------+------+------|       |    |       |------+------+------+------+------+------|
 * | XXXX |   Z  |   X  |   C  |   V  |   B  |-------|    |-------|   N  |   M  |   ,  |   .  |   /  | XXXX |
 * `-----------------------------------------/        /     \      \-----------------------------------------'
 *            | XXXX | XXXX | CTRL |Symbol| / Shift  /       \ Shift  \  | Action | CTRL | XXXX | XXXX |
 *            |      |      |      |      |/ T(Bsps)/         \ T(Spc) \ | T(Ent) |      |      |      |
 *            `----------------------------------'             '--------''-----------------------------'
 */

[_QWERTY] = LAYOUT( \
XXXXXXX,    KC_1,    KC_2,     KC_3,     KC_4,      KC_5,                         KC_6,     KC_7,     KC_8,     KC_9,     KC_0,       XXXXXXX, \
XXXXXXX,    KC_Q,    KC_W,     KC_E,     KC_R,      KC_T,                         KC_Y,     KC_U,     KC_I,     KC_O,     KC_P,       XXXXXXX, \
XXXXXXX,    KC_A,    KC_S,     KC_D,     KC_F,      KC_G,                         KC_H,     KC_J,     KC_K,     KC_L,     KC_SCLN,    XXXXXXX, \
XXXXXXX,    KC_Z,    KC_X,     KC_C,     KC_V,      KC_B,    KC_MUTE,    XXXXXXX, KC_N,     KC_M,     KC_COMM,  KC_DOT,   KC_SLSH,    XXXXXXX, \
            XXXXXXX, XXXXXXX,  KC_LCTL,  MO(1),     MOD_BSPC,                     MOD_SPC, LT(2, KC_ENT),    KC_RCTL,  XXXXXXX,  XXXXXXX \
),




/* SYMBOLS
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * | XXXX |   !  |   @  |   #  |   $  |   %  |                    |  ^   |  &   |   *  |   ~  | ____ | XXXX |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | XXXX |      |      |      |      |      |                    |      |   `  |   {  |   }  |   |  | XXXX |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | XXXX |   +  |   \  |   [  |   ]  |   _  |-------.    ,-------|   -  |   =  |   (  |   )  |   :  | XXXX |    
 * |------+------+------+------+------+------|  XXXX |    |  XXXX |------+------+------+------+------+------|
 * | XXXX |      |      |      |      |      |-------|    |-------|   '  |   "  |   <  |   >  |   ?  | XXXX |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            | XXXX | XXXX | CTRL | LOWER | / BSPC /       \SPC   \  | ENTER| CTRL | XXXX | XXXX |
 *            |      |      |      |       |/ SHIFT/         \SHIFT \ |      |      |      |      |
 *            `-----------------------------------'           '------''---------------------------'
 */

[_SYMBOLS] = LAYOUT( \
    XXXXXXX,   KC_EXLM,  KC_AT,    KC_HASH,  KC_DLR,   KC_PERC,                             KC_CIRC,  KC_AMPR, KC_ASTR,        LSFT(KC_GRV),  XXXXXXX,        XXXXXXX, \
    XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,                             XXXXXXX,  KC_GRV,  KC_LCBR,        KC_RCBR,       KC_PIPE,        XXXXXXX, \
    XXXXXXX,   KC_PLUS,  KC_BSLS,  KC_LCBR,  KC_RCBR,  LSFT(KC_MINS),                       KC_MINS,  KC_EQL,  KC_LPRN,        KC_RPRN,       KC_0,           XXXXXXX, \
    XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,       XXXXXXX,    XXXXXXX,  KC_QUOT,  KC_BSLS, LSFT(KC_COMMA), LSFT(KC_DOT),  LSFT(KC_SLASH), XXXXXXX, 
			   XXXXXXX,  XXXXXXX,  _______,  _______,  _______,                             _______,  KC_ENT,  _______,        XXXXXXX,       XXXXXXX\
),




/* ACTIONS
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * | XXXX |  F1  |  F2  |  F3  |  F4  |  F5  |                    |  F6  |  F7  |  F8  |  F9  | F10  | XXXX |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | XXXX | Tab  | Pscr | Esc  | Alt  | Del  |                    | ____ | PWrd |  Up  | NWrd | DLine| XXXX |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | XXXX | Caps | ____ | ____ | LGui | ____ |-------.    ,-------| ____ | Left | Down | Right| ____ | XXXX |
 * |------+------+------+------+------+------|       |    |       |------+------+------+------+------+------|
 * | XXXX | Undo |  Cut | Copy | Paste| ____ |-------|    |-------| ____ | LStr | ____ | LEnd | ____ | XXXX |
 * `-----------------------------------------/       /     \      \-----------------------------------------' 
 *            | XXXX | XXXX | LCTR |LOWER | /Bspc   /       \Space \  |RAISE | RCTR | XXXX | XXXX |
 *            |      |      |      |      |/ Shift /         \Shift \ |      |      |      |      |
 *             `----------------------------------'           '------''---------------------------'
 */
[_ACTIONS] = LAYOUT( \
  XXXXXXX, KC_F1,   KC_F2,   KC_F3,   KC_F4,    KC_F5,                             KC_F6,   KC_F7,    KC_F8,   KC_F9,    KC_F10,   XXXXXXX,
  XXXXXXX, KC_TAB,  KC_PSCR, KC_ESC,  KC_LALT,  KC_DEL,                            KC_PGUP, KC_PRVWD, KC_UP,   KC_NXTWD, KC_DLINE, XXXXXXX, \
  XXXXXXX, KC_CAPS, XXXXXXX, XXXXXXX, KC_LGUI,  XXXXXXX,                           KC_PGDN, KC_LEFT,  KC_DOWN, KC_RGHT,  KC_DEL,   XXXXXXX, \
  XXXXXXX, KC_UNDO, KC_CUT,  KC_COPY, KC_PASTE, XXXXXXX,  _______,       _______,  XXXXXXX, KC_LSTRT, XXXXXXX, KC_LEND,  XXXXXXX,  XXXXXXX, \
           XXXXXXX, XXXXXXX, _______, _______,  _______,                           _______, _______,  _______, XXXXXXX,  XXXXXXX \
),


			


/* ADJUST
 * ,------------------------------------------.                    ,-----------------------------------------.
 * |      |      |      |       |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+-------+------+------|                    |------+------+------+------+------+------|
 * | RESET|      |QWERTY| CLMAK |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+-------+------+------|                    |------+------+------+------+------+------|
 * |      |      |MACWIN|       |      |      |-------.    ,-------|      | VOLDO| MUTE | VOLUP|      |      |
 * |------+------+------+-------+------+------|  MUTE |    |       |------+------+------+------+------+------|
 * |      |      |      |       |      |      |-------|    |-------|      | PREV | PLAY | NEXT |      |      |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            | LGUI | LAlt | LCTR |LOWER | /Enter  /       \Space \  |RAISE | RCTR | RAlt | RGUI |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
  [_ADJUST] = LAYOUT( \
  XXXXXXX, XXXXXXX,  XXXXXXX,   XXXXXXX,    XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, \
  RESET,   XXXXXXX,  KC_QWERTY, KC_COLEMAK, CG_TOGG, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, \
  XXXXXXX, XXXXXXX,  CG_TOGG,   XXXXXXX,    XXXXXXX, XXXXXXX,                       XXXXXXX, KC_VOLD, KC_MUTE, KC_VOLU, XXXXXXX, XXXXXXX, \
  XXXXXXX, XXXXXXX,  XXXXXXX,   XXXXXXX,    XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, KC_MPRV, KC_MPLY, KC_MNXT, XXXXXXX, XXXXXXX, \
                   _______, _______, _______, _______, _______,     _______, _______, _______, _______, _______ \
  )
};

#ifdef OLED_DRIVER_ENABLE

static void render_logo(void) {
    static const char PROGMEM qmk_logo[] = {
        0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8a,0x8b,0x8c,0x8d,0x8e,0x8f,0x90,0x91,0x92,0x93,0x94,
        0xa0,0xa1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7,0xa8,0xa9,0xaa,0xab,0xac,0xad,0xae,0xaf,0xb0,0xb1,0xb2,0xb3,0xb4,
        0xc0,0xc1,0xc2,0xc3,0xc4,0xc5,0xc6,0xc7,0xc8,0xc9,0xca,0xcb,0xcc,0xcd,0xce,0xcf,0xd0,0xd1,0xd2,0xd3,0xd4,0
    };

    oled_write_P(qmk_logo, false);
}






static void print_status_narrow(void) {
    // Print current mode
    oled_write_P(PSTR("\n\n"), false);
    oled_write_ln_P(PSTR("rojet"), false);
    oled_write_ln_P(PSTR(""), false);

    oled_write_P(PSTR("\n\n"), false);
    // Print current layer
    oled_write_ln_P(PSTR("LAYER"), false);
    switch (get_highest_layer(layer_state)) {
        case _QWERTY:
            oled_write_P(PSTR("Base\n"), false);
            break;
        case _SYMBOLS:
            oled_write_P(PSTR("Sym\n"), false);
            break;
        case _ACTIONS:
            oled_write_P(PSTR("Move\n"), false);
            break;
        default:
            oled_write_ln_P(PSTR("Undef"), false);
    }
    oled_write_P(PSTR("\n\n"), false);
}

oled_rotation_t oled_init_user(oled_rotation_t rotation) {
    if (is_keyboard_master()) {
        return OLED_ROTATION_270;
    }
    return rotation;
}

void oled_task_user(void) {
    if (is_keyboard_master()) {
        print_status_narrow();
    } else {
        render_logo();
    }
}

#endif


#ifdef ENCODER_ENABLE

void encoder_update_user(uint8_t index, bool clockwise) {
    if (index == 0) {
        if (clockwise) {
            tap_code(KC_PGDOWN);
        } else {
            tap_code(KC_PGUP);
        }
    } else if (index == 1) {
        if (clockwise) {
            tap_code(KC_VOLU);
        } else {
            tap_code(KC_VOLD);
        }
    }
}

#endif
