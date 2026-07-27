function key_to_string(_key){
    switch (_key){
        case vk_up:     return "Up";
        case vk_down:   return "Down";
        case vk_left:   return "Left";
        case vk_right:  return "Right";
        case vk_space:  return "Space";
        case vk_enter:  return "Enter";
        case vk_shift:  return "Shift";
        case vk_escape: return "Esc";
        default:
            if (_key >= 32 && _key <= 126) return chr(_key);
            else return string(_key);
    }
}