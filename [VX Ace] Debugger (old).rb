##---------------------------------------------------------------------------
##---------------------------------------------------------------------------
##RPG Maker VX Ace's Concole commands
## author: ZEkA10000
##---------------------------------------------------------------------------  
##---------------------------------------------------------------------------
## 
## Как пользоваться
## 
## @> Запусти игру в режиме тестирования
## @> Нажми "Ё"
## @> Вводи команды
##  
## Подсказка: Введи >help, чтобы увидеть список доступных команд
## Подсказка: Введи >help <команда>, чтобы узнать как пользоваться командой.
##
## TAB   - Переключение между языками
## 
## 
## Внимание:
## Данный скрипт может создать конфликтные ситуации у установленных ранее скриптов
## Устанавливайте этот скрипт на свой страх и риск.
## 
##---------------------------------------------------------------------------
##---------------------------------------------------------------------------

$extended_debug_options = true        #Расширенное меню в Scene Debug
$keys = Win32API.new("user32", 'GetAsyncKeyState', 'p','i')   
FindWindow    = Win32API.new('user32'         , 'FindWindow'   , 'pp'      ,'i')
ShowWindow    = Win32API.new('user32'         , 'ShowWindow'   , 'pp'      ,'i')
SetWindowPos  = Win32API.new('user32'         , 'SetWindowPos' , 'iiiiiii' ,'i')
HWND = FindWindow.call('RGSS Player', 0)

#check Khas' Awesome Light Effects
$timer = [0, 50]
class Text_Encoding
  CP866  = "\u0000\u0001\u0002\u0003\u0004\u0005\u0006\a\b\t\n\v\f\r\u000E\u000F\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001A\e\u001C\u001D\u001E\u001F !\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\u007FАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмноп---¦+¦¦¬¬¦¦¬---¬L+T+-+¦¦Lг¦T¦=+¦¦TTLL-г++----¦¦-рстуфхцчшщъыьэюяЁёЄєЇїЎў°•·v№¤¦ "
  CP1251 = [nil, 
            nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #1-10
            nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #11-20
            nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #21-30
            nil, ' ', '!', '"', '#', '$', '%', '&', "'", '(', #31-40
            ')', '*', '+', ',', '-', '.', '/', '0', "1", '2', #41-50
            '3', '4', '5', '6', '7', '8', '9', ':', ";", '<', #51-60
            '=', '>', '?', '@', 'A', 'B', 'C', 'D', "E", 'F', #61-70
            'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', "O", 'P', #71-80
            'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', "Y", 'Z', #81-90
            '[', nil, ']', '^', '_', '`', 'a', 'b', "c", 'd', #91-100
            'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', "m", 'n', #101-110
            'o', 'p', 'q', 'r', 's', 't', 'u', 'v', "w", 'x', #111-120
            'y', 'z', '{', '|', '}', '~', nil, 'Ђ', "Ѓ", '‚', #121-130
            'ѓ', '„', '…', '†', '‡', '€', '‰', 'Љ', "‹", 'Њ', #131-140
            'Ќ', 'Ћ', 'Џ', 'ђ', 'ђ', '’', '“', '”', "•", '–', #141-150
            '—', nil, '™', 'љ', '›', 'њ', 'ќ', 'ћ', "џ", ' ', #151-160
            'Ў', 'ў', 'Ј', '¤', 'Ґ', '¦', '§', 'Ё', "©", 'Є', #161-170
            '«', '¬', '-', '®', 'Ї', '°', '±', 'І', "і", 'ґ', #171-180
            'µ', '¶', '·', 'ё', '№', 'є', '»', 'ј', "Ѕ", 'ѕ', #181-190
            'ї', 'А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ж', "З", 'И', #191-200
            'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', "С", 'Т', #201-210
            'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', "Ь", #211-220
            'Э', 'Ю', 'Я', 'а', 'б', 'в', 'г', 'д', 'е', "ж", #221-230
            'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', "р", #231-240
            'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', "ъ", #241-250
            'ы', 'ь', 'э', 'ю', 'я']                          #251-255
end

class Game_CharacterBase
  attr_accessor   :move_speed               # movement speed
end
$bgm_files = Array.new(1)
file_index = 0
Dir.foreach("Audio/BGM/") do |x|                  
  index = 0
  y = x.bytes.to_a
  while index < x.size
    y[index] = Text_Encoding::CP1251[y[index]] 
    index += 1
  end
  file_index += 1
  x = y.join
  $bgm_files[file_index] = x
end
$bgm_files.delete(".")
$bgm_files.delete("..")
$bgm_files.delete(nil)

##---------------------------------------------------------------------------
## Array of files from BGS folder
##---------------------------------------------------------------------------
$bgs_files = Array.new(1)
file_index = 0
Dir.foreach("Audio/BGS/") do |x|                  
  index = 0
  y = x.bytes.to_a
  while index < x.size
    y[index] = Text_Encoding::CP1251[y[index]] 
    index += 1
  end
  file_index += 1
  x = y.join
  $bgs_files[file_index] = x
end
$bgs_files.delete(".")
$bgs_files.delete("..")
$bgs_files.delete(nil)

##---------------------------------------------------------------------------
## Array of files from ME folder
##---------------------------------------------------------------------------
$me_files = Array.new(1)
file_index = 0
Dir.foreach("Audio/ME/") do |x|                  
  index = 0
  y = x.bytes.to_a
  while index < x.size
    y[index] = Text_Encoding::CP1251[y[index]] 
    index += 1
  end
  file_index += 1
  x = y.join
  $me_files[file_index] = x
end
$me_files.delete(".")
$me_files.delete("..")
$me_files.delete(nil)
##---------------------------------------------------------------------------
## Array of files from SE folder
##---------------------------------------------------------------------------
$se_files = Array.new(1)
file_index = 0
Dir.foreach("Audio/SE/") do |x|                  
  index = 0
  y = x.bytes.to_a
  while index < x.size
    y[index] = Text_Encoding::CP1251[y[index]] 
    index += 1
  end
  file_index += 1
  x = y.join
  $se_files[file_index] = x
end
$se_files.delete(".")
$se_files.delete("..")
$se_files.delete(nil)

 ##---------------------------------------------------------------------------
 ## Array of files from RTP BGM folder
 ##---------------------------------------------------------------------------
 $rtpbgm_files = ["Airship",  "Battle1",  "Battle2",  "Battle3",  "Battle4", 
 	               "Battle5",  "Battle6",  "Battle7",  "Battle8",  "Battle9", 
                  "Dungeon1", "Dungeon2", "Dungeon3", "Dungeon4", "Dungeon5", 
                  "Dungeon6", "Dungeon7", "Dungeon8", "Dungeon9", "Field1", 
                  "Field2",   "Field3",   "Field4",   "Scene1",   "Scene2", 
                  "Scene3",   "Scene4",   "Scene5",   "Scene6",   "Theme1",   
                  "Theme2",   "Theme3",   "Theme4",   "Theme5",   "Town1",    
                  "Town2",    "Town3",    "Town4",    "Town5",    "Town6", 
                  "Town7"]
 ##---------------------------------------------------------------------------
 ## Array of files from RTP BGS folder
 ##---------------------------------------------------------------------------
 $rtpbgs_files = ["Clock", "Darkness", "Drips", "Fire", "Quake", "Rain", 
                  "River", "Rain",     "River", "Sea",  "Storm", "Wind"]
 ##---------------------------------------------------------------------------
 ## Array of files from RTP ME folder
 ##---------------------------------------------------------------------------
 $rtpme_files  = ["Fanfare1",  "Fanfare2", "Fanfare3", "Gag",     "Gameover1", 
                  "Gameover2", "Inn",      "Item",     "Mystery", "Organ", 
                  "Shock",     "Victory1", "Victory2"]
 ##---------------------------------------------------------------------------
 ## Array of files from RTP SE folder
 ##---------------------------------------------------------------------------
 $rtpse_files  = ["Absorb1",    "Absorb2",     "Applause1", "Applause2", 
                  "Attack1",    "Attack2",     "Attack3",   "Autodor", 
                  "Barrier",    "Battle1",     "Battle2",   "Battle3", 
                  "Bell1",      "Bell2",       "Bell3",     "Bite", 
                  "Blind",      "Blow1",       "Blow2",     "Blow3", 
                  "Blow4",      "Blow5",       "Blow6",     "Blow7", 
                  "Blow8",      "Book1",       "Book2",     "Bow1", 
                  "Bow2",       "Bow3",        "Bow4",      "Chicken", 
                  "Chime1",     "Chime2",      "Close1",    "Close2", 
                  "Close3",     "Coin",        "Collapse1", "Collapse2",  
                  "Collapse3",  "Collapse4",   "Confuse",   "Cow", 
                  "Crash",      "Crossbow",    "Crow",      "Cry1", 
                  "Cry2",       "Cursor1",     "Cursor2",   "Damage1", 
                  "Damage2",    "Damage3",     "Damage4",   "Damage5",  
                  "Darkness1",  "Darkness2",   "Darkness3", "Darkness4", 
                  "Darkness5",  "Darkness6",   "Darkness7", "Darkness8",  
                  "Decision1",  "Decision2",   "Decision3", "Devil1",    
                  "Devil2",     "Devil3",      "Disappointment", "Dive", 
                  "Dog",        "Down1",       "Down2",     "Down3", 
                  "Down4",      "Earth1",      "Earth2",    "Earth3", 
                  "Earth4",     "Earth5",      "Earth6",    "Earth7", 
                  "Earth8",     "Earth9",      "Equip1",    "Equip2", 
                  "Equip3",     "Evasion1",    "Evasion2",  "Explosion1",
                  "Explosion2", "Explosion3",  "Explosion4", "Explosion5", 
                  "Explosion6", "Explosion7",  "Fall",      "Fire1", 
                  "Fire2",      "Fire3",       "Fire4",     "Fire5", 
                  "Fire6",      "Fire7",       "Fire8",     "Fire9", 
                  "Flash1",     "Flash2",      "Flash3",    "Fog1", 
                  "Fog2",       "Frog",        "Gun1",      "Gun2", 
                  "Hammer",     "Heal1",       "Heal2",     "Heal3", 
                  "Heal4",      "Heal5",       "Heal6",     "Heal7", 
                  "Horse",      "Ice1",        "Ice2",      "Ice3", 
                  "Ice4",       "Ice5",        "Ice6",      "Ice7", 
                  "Ice8",       "Ice9",        "Ice10",     "Ice11", 
                  "Item1",      "Item2",       "Item3",     "Jump1", 
                  "Jump2",      "Key",         "Knock",     "Laser", 
                  "Load",       "Machine",     "Magic1",    "Magic2", 
                  "Magic3",     "Magic4",      "Magic5",    "Magic6", 
                  "Magic7",     "Miss",        "Monster1",  "Monster2", 
                  "Monster3",   "Monster4",    "Monster5",  "Monster6", 
                  "Monster7",   "Move",        "Noise",     "Open1", 
                  "Open2",      "Open3",       "Open4",     "Open5", 
                  "Paralyze1",  "Paralyze2",   "Paralyze3", "Parry", 
                  "Phone",      "Poison",      "Pollen",    "Powerup", 
                  "Push",       "Raise1",      "Raise2",    "Raise3", 
                  "Recovery",   "Reflection",  "Resonance", "Run", 
                  "Saint",      "Saint2",      "Saint3",    "Saint4", 
                  "Saint5",     "Saint6",      "Saint7",    "Saint8", 
                  "Saint9",     "Sand",        "Save",      "Scream", 
                  "Sheep",      "Shop",        "Shot1",     "Shot2", 
                  "Shot3",      "Silence",     "Skill1",    "Skill2", 
                  "Skill3",     "Slash1",      "Slash2",    "Slash3",
                  "Slash4",     "Slash5",      "Slash6",    "Slash7", 
                  "Slash8",     "Slash9",      "Slash10",   "Slash11", 
                  "Slash12",    "Sleep",       "Sound1",    "Sound2", 
                  "Sound3",     "Stare",       "Starlight", "Switch1", 
                  "Switch2",    "Switch3",     "Sword1",    "Sword2", 
                  "Sword3",     "Sword4",      "Sword5",    "Teleport", 
                  "Thunder1",   "Thunder2",    "Thunder3",  "Thunder4", 
                  "Thunder5",   "Thunder6",    "Thunder7",  "Thunder8", 
                  "Thunder9",   "Thunder10",   "Thunder11", "Thunder12", 
                  "Twine",      "Up1",         "Up2",       "Up3",
                  "Up4",        "Water1",      "Water2",    "Water3", 
                  "Water4",     "Water5",      "Water6",    "Wind1", 
                  "Wind2",      "Wind3",       "Wind4",     "Wind5", 
                  "Wind6",      "Wind7",       "Wind8",     "Wind9", 
                  "Wind10",     "Wind11",      "Wolf"]


$all_bgm = $bgm_files + $rtpbgm_files
$all_bgs = $bgs_files + $rtpbgs_files
$all_se  = $se_files + $rtpse_files
$all_me  = $me_files + $rtpme_files
##---------------------------------------------------------------------------
## Auto launch
##---------------------------------------------------------------------------
class Game_Event < Game_Character
  def start
    if $cin != true
      return if empty?
      @starting = true
      lock if trigger_in?([0,1,2])
    end
  end
end

class Game_Picture 
  def rotation(rotate)
    @angle = rotate
  end
end
  
class Sprite_Timer < Sprite
  def update_position
    self.x = (Graphics.width - self.bitmap.width) / 2
    self.y = 0
    self.z = 200
  end
end
class Scene_Debug < Scene_MenuBase
  def help_text
    if $extended_debug_options == true
      if @left_window.mode == :switch
        "C (Enter) : ВКЛ / ВЫКЛ"
      else
        "< : -1  | Shift + < : -5\n" +
        "> : +1  | Shift + > : +5\n" +
        "L  : -10 | Shift + L  : -50\n" +
        "R  : +10 | Shift + R  : +50\n" +
        "F5 : ввод данных через консоль"
      end
    else
      if @left_window.mode == :switch
        "C (Enter) : ВКЛ / ВЫКЛ"
      else
        "< (Влево)    :  -1\n" +
        "> (Вправо)   :  +1\n" +
        "L (Pageup)   : -10\n" +
        "R (Pagedown) : +10"
      end
    end
  end
end

class Game_Player < Game_Character  
  def move_by_input
    return if !movable?
      if $keys.call(0xC0) < 0 
        if $TEST == true
          $game_system.menu_disabled = true
          $cin = true
        end
      end
      Console_Commands.other_scripts       if $scripts != true
      Console_Commands.reset               if $reseted_switches != true
      Console_Commands.input_debug_command if $cin == true
      Console_Commands.coord_find          if $TEST == true 
      if Input.press?(:F6) == true
        $coord = false
        Graphics.wait(10)
        Console_Commands.coord_find
      end
      unless $debug == true
        return if $game_map.interpreter.running?
        case Input.dir8
          when 2,4,6,8; move_straight(Input.dir4)
          when 1 ;  move_diagonal_straight(4, 2)
          when 3 ;  move_diagonal_straight(6, 2)
          when 7 ;  move_diagonal_straight(4, 8)
          when 9 ;  move_diagonal_straight(6, 8)
        end
      end
    end
    def move_diagonal_straight(x,y)
      move_diagonal(x, y)
      return if moving?
      move_straight(x, false) ; move_straight(y, false)
  end
end

class Scene_Map < Scene_Base
  def update
    super
    $game_map.update(true)
    $game_player.update
    $game_timer.update
    @spriteset.update
    update_scene if scene_change_ok?
    
  end
end

class Game_Actor < Game_Battler
  def param_max(param_id)
    return 9999  if param_id == 0  # MHP
    return 9999  if param_id == 1  # MMP
    return 999   if param_id == 2  # ATK
    return 999   if param_id == 3  # DEF
    return 999   if param_id == 4  # MAT
    return 999   if param_id == 5  # MDF
    return 999   if param_id == 6  # LUK
    return 999   if param_id == 7  # AGI
    return super
  end
end




class Console_Commands  
  def self.other_scripts
    if $game_map.methods.include?(:lantern) != false
      $khas_effect = true
      en = "Enabled"
    else
      $khas_effect = false
      en = "Disabled"
    end
    puts "Use Khas' Awesome Light Effects => #{en}" 
    $scripts = true
  end
  def self.reset
    $saved = false
    $scripts == false
    $game_system.menu_disabled = false if $game_system != nil
    $coord = false
    $debug = false
    $text_nulrd = false
    $input_RUS = false
    $cin = false
    $inrput_no_command = false
    $capslock = false
    $reseted_switches = true
  end
  def self.output
    output_array_min = 0
    output_array_max = $output.size
    
    while output_array_min <= output_array_max
      Debug_Text.draw_word($output[output_array_min], 2, 2 + (20 * output_array_min)) if $output[output_array_min] != nil
      output_array_min += 1
    end
  end
  def self.coord_find
    unless $coord == true 
      $coordinate_player = Sprite.new
      $coordinate_player.bitmap = Bitmap.new(140, 100)
      $coord = true
    end
    if $coordinate_player.bitmap.disposed?
      $coordinate_player = Sprite.new
      $coordinate_player.bitmap = Bitmap.new(140, 100)
    end
    my_color = Color.new(200, 200, 200) 
    $coordinate_player.bitmap.fill_rect(0, 0, 120, 20, my_color) 
    ox = $game_player.x.to_s
    oy = $game_player.y.to_s
    $coordinate_player.bitmap.font = Font.new("VL Gothic", 16)
    coor_info = "X#{ox} Y#{oy} | Map:#{$game_map.map_id}"
    $coordinate_player.bitmap.draw_text(0, 0, 120, 20, coor_info, 1)
  end
  
  def self.error
    commands_list = ['>MOVE' , '>MOVE2', '>ITEMS', '>WEAPONS', '>ARMORS', '>SKILLS', '>ACTOR',
         '>ENEMY', '>GOLD',  '>MENU', '>EXIT', '>TONE', '>SCREEN', '>CLEAR', '>HELP', ">MAP",
         ">SW", ">SWITCH", ">VAR", ">VARIABLE"]       
    if commands_list.include?($error) == true
      if $error == ">HELP"
        error_str = ">HELP" 
      else
        error_str = ">HELP #{$error.delete('>')}"
      end
    end
    $output[0] = "Не правильна введена команда." 
    $output[1] = "Введите #{error_str}, " 
    $output[2] = "        чтобы узнать подробности" 
    Console_Commands.output
  end
  def self.plus_symbol
    $input_text_index += 1 if $input_text_index < 40
  end
  def self.nul_text
    $input_text = ">                                       "
    $input_text_index = 1
    $text_nulrd = true
  end
  def self.input_debug_command
    unless $debug == true
      $actor_params = [$game_actors[1].param_max(0), $game_actors[1].param_max(1),
                       $game_actors[1].param_max(2), $game_actors[1].param_max(3),
                       $game_actors[1].param_max(4), $game_actors[1].param_max(5),
                       $game_actors[1].param_max(6), $game_actors[1].param_max(7)]
      color = Color.new(1, 1, 1)
      $color_input = Color.new(0, 0, 0)
      $color_console = Color.new(20, 20, 20)
      $debug_zone = Sprite.new
      if $data_system.title1_name == ""
        $debug_zone.bitmap = Bitmap.new(640, 480)
        $debug_zone.bitmap.fill_rect(0, 0, 640, Graphics.height - 20, $color_console) 
      else
        $debug_zone.bitmap = Bitmap.new("Graphics/Titles1/#{$data_system.title1_name}")
        w = 0
        h = 0
        while h < 500
          while w < 700
            $debug_zone.bitmap.set_pixel(w,h,$color_input)
            w += 2
          end
          w % 2 == 0 ? w = 1 : w = 0
          h += 1
        end
      end
      $debug = true
      Console_Commands.nul_text if $text_nulrd != true
      vert = 0
      horz = 1
      text_x = 0
      size_x = Graphics.width
      text_y = Graphics.height - 22
      size_y = 30
      $debug_zone.bitmap.fill_rect(0, Graphics.height - 20, 640, 100, $color_input) 
      $map_event_priority_type = Array.new
      a = 0
    end
    letter = ""
    if $keys.call(0x41) < 0 
      $input_RUS == true ? letter = "Ф" : letter = "A"
    elsif $keys.call(0x42) < 0 #b
      $input_RUS == true ? letter = "И" : letter = "B"  
    elsif $keys.call(0x43) < 0 #c
      $input_RUS == true ? letter = "С" : letter = "C"
    elsif $keys.call(0x44) < 0 #d
      $input_RUS == true ? letter = "В" : letter = "D"  
    elsif $keys.call(0x45) < 0 #e
      $input_RUS == true ? letter = "У" : letter = "E"
    elsif $keys.call(0x46) < 0 #f
      $input_RUS == true ? letter = "А" : letter = "F"
    elsif $keys.call(0x47) < 0 #g
      $input_RUS == true ? letter = "П" : letter = "G"    
    elsif $keys.call(0x48) < 0 #h
      $input_RUS == true ? letter = "Р" : letter = "H"    
    elsif $keys.call(0x49) < 0 #i
      $input_RUS == true ? letter = "Ш" : letter = "I"
    elsif $keys.call(0x4a) < 0 #j
      $input_RUS == true ? letter = "О" : letter = "J"
    elsif $keys.call(0x4b) < 0 #k
      $input_RUS == true ? letter = "Л" : letter = "K"
    elsif $keys.call(0x4c) < 0 #l
      $input_RUS == true ? letter = "Д" : letter = "L"  
    elsif $keys.call(0x4d) < 0 #m
      $input_RUS == true ? letter = "Ь" : letter = "M"
    elsif $keys.call(0x4e) < 0 #n
      $input_RUS == true ? letter = "Т" : letter = "N"  
    elsif $keys.call(0x4f) < 0 #o
      $input_RUS == true ? letter = "Щ" : letter = "O"
    elsif $keys.call(0x50) < 0 #p
      $input_RUS == true ? letter = "З" : letter = "P"  
    elsif $keys.call(0x51) < 0 #q
      $input_RUS == true ? letter = "Й" : letter = "Q"  
    elsif $keys.call(0x52) < 0 #r
      $input_RUS == true ? letter = "К" : letter = "R"  
    elsif $keys.call(0x53) < 0 #s
      $input_RUS == true ? letter = "Ы" : letter = "S"
    elsif $keys.call(0x54) < 0 #t
      $input_RUS == true ? letter = "Е" : letter = "T"  
    elsif $keys.call(0x55) < 0 #u
      $input_RUS == true ? letter = "Г" : letter = "U"  
    elsif $keys.call(0x56) < 0 #v
      $input_RUS == true ? letter = "М" : letter = "V"
    elsif $keys.call(0x57) < 0 #w
      $input_RUS == true ? letter = "Ц" : letter = "W"
    elsif $keys.call(0x58) < 0 #x
      $input_RUS == true ? letter = "Ч" : letter = "X"
    elsif $keys.call(0x59) < 0 #y
      $input_RUS == true ? letter = "Н" : letter = "Y"      
    elsif $keys.call(0x5a) < 0 #z
      $input_RUS == true ? letter = "Я" : letter = "Z"
    elsif $keys.call(0xDB) < 0 #RUS x
      letter = "Х" if $input_RUS == true 
    elsif $keys.call(0xDD) < 0 #RUS ъ
      letter = "Ъ" if $input_RUS == true 
    elsif $keys.call(0xBA) < 0 #RUS ж
      letter = "Ж" if $input_RUS == true 
    elsif $keys.call(0xC0) < 0 #RUS ё
      letter = "Ё" if $input_RUS == true 
    elsif $keys.call(0xDE) < 0 #RUS э
      letter = "Э" if $input_RUS == true 
    elsif $keys.call(0xBC) < 0 #RUS б
      letter = "Б" if $input_RUS == true 
    elsif $keys.call(0xBE) < 0 #RUS ю
      letter = "Ю" if $input_RUS == true 
    elsif $keys.call(0xBD) < 0 #- _
      Input.press?(:A) ? letter = "_" : letter = "-"
    elsif $keys.call(0x60) < 0 or $keys.call(0x30) < 0 #0
      Input.press?(:A) ? letter = ")" : letter = "0" 
    elsif $keys.call(0x61) < 0 or $keys.call(0x31) < 0 #1
      Input.press?(:A) ? letter = "!" : letter = "1" 
    elsif $keys.call(0x62) < 0 or $keys.call(0x32) < 0 #2
      letter = "2"
    elsif $keys.call(0x63) < 0 or $keys.call(0x33) < 0 #3
      letter = "3"
    elsif $keys.call(0x64) < 0 or $keys.call(0x34) < 0 #4
      letter = "4"
    elsif $keys.call(0x65) < 0 or $keys.call(0x35) < 0 #5
      letter = "5"
    elsif $keys.call(0x66) < 0 or $keys.call(0x36) < 0 #6
      letter = "6"
    elsif $keys.call(0x67) < 0 or $keys.call(0x37) < 0 #7
      letter = "7"
    elsif $keys.call(0x68) < 0 or $keys.call(0x38) < 0 #8
      letter = "8"
    elsif $keys.call(0x69) < 0 or $keys.call(0x39) < 0 #9
      letter = "9"
    elsif $keys.call(0x20) < 0 #Пробел
      letter = " "
    elsif $keys.call(0x1B) < 0 #ESC
      Console_Commands.nul_text
      $debug_zone.bitmap.clear if $debug_zone.bitmap.disposed? == false
      Debug_Text.clear_bitmap
      $reseted_switches = false
    elsif $keys.call(0x09) < 0 #TAB
      $input_RUS == true ? $input_RUS = false : $input_RUS = true
    elsif $keys.call(0x0D) < 0 #Готово
      if $inrput_no_command == false
        if $data_system.title1_name == ""
          $debug_zone.bitmap.fill_rect(0, 0, 640, 386, $color_console) 
        else
          $debug_zone.bitmap = Bitmap.new("Graphics/Titles1/#{$data_system.title1_name}")
          w = 0
          h = 0
          while h < 500
            while w < 700
              $debug_zone.bitmap.set_pixel(w,h,$color_input)
              w += 2
            end
            w % 2 == 0 ? w = 1 : w = 0
            h += 1
          end
        end
        $copy_input = $input_text
        $debug_zone.bitmap.fill_rect(0, Graphics.height - 20, 640, 100, $color_input) 
        Debug_Text.clear_bitmap
        $input_text[$input_text_index] = " " if $input_text[$input_text_index] == "|" 
        if $enemy != nil
          $enemy.dispose if $enemy.disposed? == false
        end
        Console_Commands.input_command
        
      else
        Console_Commands.input_command
        Console_Commands.nul_text 
        $debug_zone.bitmap.clear_rect(0, Graphics.height - 20, 640, 100) 
        $debug_zone.bitmap.fill_rect(0, Graphics.height - 20, 640, 100, $color_input) 
      end
    elsif $keys.call(0x08) < 0 #backspace
      $input_text[$input_text_index] = " "
      $input_text_index -= 1 if $input_text_index > 1
    end
    
    if $reseted_switches == true
      Debug_Text.clear_text
      Debug_Text.draw_word($input_text, 2, Graphics.height - 16)
      Debug_Text.draw_word("RUS", Graphics.width - 48, Graphics.height - 36) if $input_RUS == true
      Debug_Text.draw_word("eng", Graphics.width - 48, Graphics.height - 36) if $input_RUS != true
    end
    $input_text[$input_text_index] = "|" if $timer[0] < $timer[1] / 2
    $input_text[$input_text_index] = " " if $timer[0] > $timer[1] / 2
    $timer[0] = 0 if $timer[0] > $timer[1]
    $timer[0] += 1
    
    
    if letter != ""
        $input_text[$input_text_index] = letter if $input_text_index <= 40
        Console_Commands.plus_symbol
        loop do 
        if ($keys.call(0x41) < 0 or $keys.call(0x42) < 0 or $keys.call(0x43) < 0 or 
            $keys.call(0x44) < 0 or $keys.call(0x45) < 0 or $keys.call(0x46) < 0 or
            $keys.call(0x47) < 0 or $keys.call(0x48) < 0 or $keys.call(0x49) < 0 or 
            $keys.call(0x4a) < 0 or $keys.call(0x4b) < 0 or $keys.call(0x4c) < 0 or
            $keys.call(0x4d) < 0 or $keys.call(0x4e) < 0 or $keys.call(0x4f) < 0 or 
            $keys.call(0x50) < 0 or $keys.call(0x51) < 0 or $keys.call(0x52) < 0 or
            $keys.call(0x53) < 0 or $keys.call(0x54) < 0 or $keys.call(0x55) < 0 or 
            $keys.call(0x56) < 0 or $keys.call(0x57) < 0 or $keys.call(0x58) < 0 or
            $keys.call(0x59) < 0 or $keys.call(0x5a) < 0 or $keys.call(0xDB) < 0 or
            $keys.call(0xDD) < 0 or $keys.call(0xBA) < 0 or $keys.call(0xC0) < 0 or 
            $keys.call(0xDE) < 0 or $keys.call(0xBC) < 0 or $keys.call(0xBE) < 0 or 
            $keys.call(0xBD) < 0 or $keys.call(0x60) < 0 or $keys.call(0x30) < 0 or 
            $keys.call(0x61) < 0 or $keys.call(0x31) < 0 or $keys.call(0x62) < 0 or 
            $keys.call(0x32) < 0 or $keys.call(0x63) < 0 or $keys.call(0x33) < 0 or
            $keys.call(0x64) < 0 or $keys.call(0x34) < 0 or $keys.call(0x65) < 0 or 
            $keys.call(0x35) < 0 or $keys.call(0x66) < 0 or $keys.call(0x36) < 0 or 
            $keys.call(0x67) < 0 or $keys.call(0x37) < 0 or $keys.call(0x68) < 0 or 
            $keys.call(0x38) < 0 or $keys.call(0x69) < 0 or $keys.call(0x39) < 0 or 
            $keys.call(0x20) < 0 or $keys.call(0x1B) < 0 or $keys.call(0x09) < 0 or 
            $keys.call(0x0D) < 0 )
          Graphics.wait(1)
          Graphics.update
        else
          break
        end
      end
    end
    
  end
  def self.input_command
    command = $copy_input.split(" ")
    $output = Array.new(1)
    #---------------------------------------------------------------------------
    #command >help
    #---------------------------------------------------------------------------
    p command[0] 
    if command[0] == ">HELP"
      $error = command[0]
      if command[1] == "MOVE"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Переход на другую локацию: "
        $output[4] = ' >move <id> <x> <y> <dir>'
        $output[5] = ''
        $output[6] = ' id - номер карты'
        $output[7] = ' x, y - координаты'      
        $output[8] = ' Начало отсчета координат идет с'      
        $output[9] = ' левого верхнего угла карты' 
        $output[10] = ''
        $output[11] = 'dir - направление игрока'
        $output[12] = '2 - вниз, 4 - влево'
        $output[13] = '6 - вправо, 8 - вверх'
        $output[14] = " -------------------------------- "
        $output[15] = " -------===== ПОМОЩЬ =====------- "
        $output[16] = " -------------------------------- "
      elsif command[1] == "MOVE2"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Смотри >help move"
        $output[4] = " -------------------------------- "
        $output[5] = " -------===== ПОМОЩЬ =====------- "
        $output[6] = " -------------------------------- "
      elsif command[1] == "KHAS"
        if $khas_effect == true
          $output[0] = " -------------------------------- "
          $output[1] = " -------===== ПОМОЩЬ =====------- "
          $output[2] = " -------------------------------- "
          $output[3] = " Изменение освещения со скриптом  "
          $output[4] = ' Khas Awesome Lights Effects      '
          $output[5] = ' '
          $output[6] = " Применение:"
          $output[7] = ' >khas lights <t> <r> <g> <b> <o>'
          $output[8] = ' t - время в кадрах'
          $output[9] = ' r g b - цвет по схеме RGB'
          $output[10] = ' o - прозрачность освещения'
          $output[11] = " -------------------------------- "
          $output[12] = " -------===== ПОМОЩЬ =====------- "
          $output[13] = " -------------------------------- "
        else
          $output[0] = "Khas Awesome Light Effects"
          $output[1] = "<не установлен>"
        end
      elsif command[1] == "ITEMS"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция вещами"
        $output[4] = " -Показать список предметов"
        $output[5] = "  >items list <ID 1> <ID 2>"
        $output[6] = " -Получить предмет   "
        $output[7] = "  >items give <ID> <Count> "
        $output[8] = ' -"Потерять" предмет '
        $output[9] = '  >items lose <ID> <Count> '
        $output[10] = ' '
        $output[11] = ' id - номер предмета в базе данных '
        $output[12] = ' Count - количество'
        $output[13] = ' '
        $output[14] = " -------------------------------- "
        $output[15] = " -------===== ПОМОЩЬ =====------- "
        $output[16] = " -------------------------------- "
      elsif command[1] == "WEAPONS"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция оружием"
        $output[4] = " -Показать список оружия "
        $output[5] = "  >weapons list <ID 1> <ID 2> "
        $output[6] = " -Получить оружие  "
        $output[7] = "  >weapons give <ID> <Count>"
        $output[8] = ' -"Потерять" оружие'
        $output[9] = '  >weapons lose <ID>   <Count> '
        $output[10] = ' '
        $output[11] = ' id - номер оружия в базе данных '
        $output[12] = ' Count - количество'
        $output[13] = ' '
        $output[14] = " -------------------------------- "
        $output[15] = " -------===== ПОМОЩЬ =====------- "
        $output[16] = " -------------------------------- "
      elsif command[1] == "ARMORS"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция бронёй"
        $output[4] = " -Показать список брони "
        $output[5] = "  >armors list <ID 1> <ID 2> "
        $output[6] = " -Получить броню  "
        $output[7] = "  >armors give <ID> <Count>"
        $output[8] = ' -"Потерять" броню'
        $output[9] = '  >armors lose <ID>   <Count> '
        $output[10] = ' '
        $output[11] = ' id - номер оружия в базе данных '
        $output[12] = ' Count - количество'
        $output[13] = ' '
        $output[14] = " -------------------------------- "
        $output[15] = " -------===== ПОМОЩЬ =====------- "
        $output[16] = " -------------------------------- "
      elsif command[1] == "SKILLS"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция навыками"
        $output[4] = " -Изучить навык"
        $output[5] = "  >skills learn actor <aID> <sID> "
        $output[6] = " -Забыть навык"
        $output[7] = "  >skills forget actor <aID> <sID>"
        $output[8] = " -Список навыков        " 
        $output[9] = "  >skills list <ID 1> <ID 2>      " 
        $output[10] = ' '
        $output[11] = ' actor <aID> может быть заменен на'
        $output[12] = ' all. в этом случае будут навык '
        $output[13] = ' изучать все герои в команде'
        $output[14] = ' '
        $output[15] = " -------------------------------- "
        $output[16] = " -------===== ПОМОЩЬ =====------- "
        $output[17] = " -------------------------------- "
      elsif command[1] == "ACTOR"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция героями"
        $output[4] = " -Показать список героев  "
        $output[5] = "  >actor list <ID 1> <ID 2> "
        $output[6] = " -Добавить героя в команду           "
        $output[7] = "  >actor add <ID> "
        $output[8] = ' -Убрать героя из команды         '
        $output[9] = '  >actor remove <ID> '
        $output[10] = ' -Переименовать героя       '
        $output[11] = '  >actor rename <ID> <Имя>'
        $output[12] = ' -Изменить характеристику героя     '
        $output[13] = '  >actor edit <ID> '
        $output[14] = ' '
        $output[15] = " -------------------------------- "
        $output[16] = " -------===== ПОМОЩЬ =====------- "
        $output[17] = " -------------------------------- "
      elsif command[1] == "TONE"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = "Изменить оттенок экрана"
        $output[4] = " -Мгновенно изменить оттнеок."
        $output[5] = "  >tone set <r> <g> <b> <c>"
        $output[6] = " -Плавно изменить оттнеок."
        $output[7] = ">tone change <r> <g> <b> <c> <w>"
        $output[8] = " "
        $output[9] = ' r g b - цвет по схеме RGB'
        $output[10] = ' c - контраст (0 - 255)'
        $output[11] = ' w - ожидание в кадрах'
        $output[12] = ' '
        $output[13] = " -------------------------------- "
        $output[14] = " -------===== ПОМОЩЬ =====------- "
        $output[15] = " -------------------------------- "
      elsif command[1] == "ENEMY"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция врагами"
        $output[4] = " -Показать список врагов   "
        $output[5] = "  >enemy list <ID 1> <ID 2>"
        $output[6] = ' -Переименовать врага       '
        $output[7] = '  >enemy rename <ID> <Имя> '
        $output[8] = ' -Вызвать битву. '
        $output[9] = '  >enemy <summon_battle|sb> <tID> '
        $output[10] = '                     <esc> <cont> '
        $output[11] = ' tID => номер группы врагов'
        $output[12] = " ESC => Шанс побега (1 или 0 )     "
        $output[13] = " CONT => играть после поражения "
        $output[14] = "                    (1 или 0 )"
        $output[15] = ' '
        $output[16] = " -Полностью изменить врага"
        $output[17] = "  >enemy edit <ID>  "
      elsif command[1] == "GOLD"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция деньгами"
        $output[4] = " -Получить деньги"
        $output[5] = "  >gold give <Количество> "
        $output[6] = " -Потерять деньги"
        $output[7] = "  >gold lost <Количество>"
        $output[8] = ' '
        $output[9] = " -------------------------------- "
        $output[10] = " -------===== ПОМОЩЬ =====------- "
        $output[11] = " -------------------------------- "
      elsif command[1] == "BGM"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Действия с фоновой музыкой"
        $output[4] = " -Воспроизвести мелодию" 
        $output[5] = "  >bgm play <номер из списка>"
        $output[6] = " -Остановить мелодию   " 
        $output[7] = "  >bgm <off|stop> *msec* " 
        $output[8] = " -Показать список vtkjlbq" 
        $output[9] = "  >bgm list <ID1> <ID2>" 
        $output[10] = " -------------------------------- "
        $output[11] = " -------===== ПОМОЩЬ =====------- "
        $output[12] = " -------------------------------- "
      elsif command[1] == "CLEAR"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Очистить консоль"
        $output[4] = " >clear" 
        $output[5] = " -------------------------------- "
        $output[6] = " -------===== ПОМОЩЬ =====------- "
        $output[7] = " -------------------------------- "
      elsif command[1] == "MENU"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Выход в меню"
        $output[4] = " >menu" 
        $output[5] = " -------------------------------- "
        $output[6] = " -------===== ПОМОЩЬ =====------- "
        $output[7] = " -------------------------------- "
      elsif command[1] == "EXIT "
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Закрыть игру"
        $output[4] = " >exit" 
        $output[5] = " -------------------------------- "
        $output[6] = " -------===== ПОМОЩЬ =====------- "
        $output[7] = " -------------------------------- "
      elsif command[1] == "TIMER"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Управление таймером"
        $output[4] = " -Запустить таймер" 
        $output[5] = "  >timer start <sec>" 
        $output[6] = ' -Остановить таймер'
        $output[7] = '  >timer stop'
        $output[8] = ' -Добавить времени к таймеру'
        $output[9] = '  >timer add <sec>'
        $output[10] = " -------------------------------- "
        $output[11] = " -------===== ПОМОЩЬ =====------- "
        $output[12] = " -------------------------------- "        
      elsif command[1] == "SCREEN"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = ">screen show | Просветление экрана"
        $output[4] = ">screen hide | Затемление экрана"
        $output[5] = " -------------------------------- "
        $output[6] = " -------===== ПОМОЩЬ =====------- "
        $output[7] = " -------------------------------- "
      elsif command[1] == "COMMONEVENT"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Вызвать общее событие 1 раз"
        $output[4] = "  >commonevent <ID>"
        $output[5] = " -------------------------------- "
        $output[6] = " -------===== ПОМОЩЬ =====------- "
        $output[7] = " -------------------------------- "
      elsif command[1] == "WINDOW"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Манипуляция окном"
        $output[4] = " -скрыть окно"
        $output[5] = "  >window hide"
        $output[6] = " Оно будет активно, но его не "
        $output[7] = " будет на панели задач  "
        $output[8] = " -изменить размер (растянуть)"
        $output[9] = "  >window resize <x> <y> <sx> <sy>"
        $output[10] = " x, y - местоположение окна"
        $output[11] = " sx, sy - размер экрана в пикселях"
        $output[12] = " -изменить размер игры"
        $output[13] = "  >window resize_game <sx> <sy>"
        $output[14] = ' '
        $output[15] = " -------------------------------- "
        $output[16] = " -------===== ПОМОЩЬ =====------- "
        $output[17] = " -------------------------------- "        
      elsif command[1] == "HEAL"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Восстановление партии"
        $output[4] = " >heal <actor|party> <hp|mp|tp> "
        $output[5] = "                       <ID1> <ID2>"
        $output[6] = " "
        $output[7] = " -------------------------------- "
        $output[8] = " -------===== ПОМОЩЬ =====------- "
        $output[9] = " -------------------------------- " 
      elsif command[1] == "SWITCH"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Действия с переключателями"
        $output[4] = " >switch <ID> <положение>"
        $output[5] = " "
        $output[6] = '>switch имеет синоним >sw'
        $output[7] = '>switch принимает true|ON|false|OFF'
        $output[8] = " -------------------------------- "
        $output[9] = " -------===== ПОМОЩЬ =====------- "
        $output[10] = " -------------------------------- " 
      elsif command[1] == "SW"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = "Смотри >help switch"
        $output[4] = " -------------------------------- "
        $output[5] = " -------===== ПОМОЩЬ =====------- "
        $output[6] = " -------------------------------- " 
      elsif command[1] == "VARIABLE"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Действия с переменными"
        $output[4] = " >variable <ID> <число>"
        $output[5] = '>variable имеет синоним >var'
        $output[6] = '>variable принимает только числа'
        $output[7] = " -------------------------------- "
        $output[8] = " -------===== ПОМОЩЬ =====------- "
        $output[9] = " -------------------------------- " 
      elsif command[1] == "VAR"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = " Смотри >help variable"
        $output[4] = " -------------------------------- "
        $output[5] = " -------===== ПОМОЩЬ =====------- "
        $output[6] = " -------------------------------- "
      elsif command[1] == "HELP"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = "Зачем ты ввел эту команду?"
        $output[4] = 'Смотри >help'
        $output[5] = " -------------------------------- "
        $output[6] = " -------===== ПОМОЩЬ =====------- "
        $output[7] = " -------------------------------- "
      elsif command[1] == "MAP"
        $output[0] = " -------------------------------- "
        $output[1] = " -------===== ПОМОЩЬ =====------- "
        $output[2] = " -------------------------------- "
        $output[3] = "Информация про ваше местоположение"
        $output[4] = " -Показать список локаций    "
        $output[5] = "  >map list <ID 1> <ID 2>"
        $output[6] = ' - Показать координаты события'
        $output[7] = '  >map event <ID> '
        $output[8] = ' -Показать скрытые события '
        $output[9] = '  (заменяет текстуру событиям без'
        $output[10] = '                          графики)'
        $output[11] = '  >map events show'
        $output[12] = ' -Перейти к событию '
        $output[13] = '  >map events <id> tp|teleport'
        $output[14] = ' -Подробная информация о карте'
        $output[15] = '  >map info'
        $output[16] = ' -Вывести список случайных столкновений'
        $output[17] = '  >map troop show'
      elsif command[1] == nil
        $output[0] = " -------------------------------- "
        $output[1] = " ----==== Список команд =====---- "
        $output[2] = " -------------------------------- "
        $output[3] = '>move    / >move2  / >items  / '
        $output[4] = '>weapons / >armors / >skills / '
        $output[5] = '>actor   / >enemy  / >gold   / ' 
        $output[6] = '>bgm     / >map    / >menu   / '
        $output[7] = '>exit    / >tone   / >screen / '
        $output[8] = '>window  / >commonevent / >heal / '
        $output[9] = '>switch  / >sw     / >help   /'
        $output[10] = '>timer   / >variable / >var  /'
        $output[11] = '>khas /'
        $output[12] = ''
        $output[13] = 'Чтобы узнать больше подробностей,'
        $output[14] = 'введите ">help <команда>"'
        $output[15] = " -------------------------------- "
        $output[16] = " ----==== Список команд =====---- "
        $output[17] = " -------------------------------- "
      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >menu
    #---------------------------------------------------------------------------      
    elsif command[0] == ">MENU" 
      $error = command[0]
      SceneManager.goto(Scene_Title)
    #---------------------------------------------------------------------------
    #command >exit
    #---------------------------------------------------------------------------      
    elsif command[0] == ">EXIT" 
      $error = command[0]
      SceneManager.exit
    #---------------------------------------------------------------------------
    #command >move2
    #---------------------------------------------------------------------------      
    elsif command[0] == ">MOVE2"
      $error = command[0]
      if command.size < 5 
        Console_Commands.error
      else
        map_file = "Map00#{command[1]}.rvdata2" if command[1].to_i < 10 
        map_file = "Map0#{command[1]}.rvdata2"  if command[1].to_i >= 10 and command[1].to_i < 100 
        map_file = "Map#{command[1]}.rvdata2"   if command[1].to_i >= 100 
        if File.exist?("Data/#{map_file}") == false
          $output[0] = "Данной локации не существует." 
          $output[1] = ' '
        else
          $game_temp.fade_type = 0
          $game_player.reserve_transfer(command[1].to_i, command[2].to_f - 0.5, command[3].to_f - 0.5, command[4].to_i)
          $output[0] =  "Перемещение на карту #{command[1]} " 
          $output[1] =  "по координатам Х:#{command[2].to_f - 0.5} Y:#{command[3].to_f - 0.5}."
          Console_Commands.output
          Graphics.wait(60)
          Console_Commands.nul_text
          $reseted_switches = false
          $debug_zone.bitmap.clear
          Debug_Text.clear_bitmap
        end
      end
      Console_Commands.output if $reseted_switches != false
    #---------------------------------------------------------------------------
    #command >move
    #---------------------------------------------------------------------------      
    elsif command[0] == ">MOVE"
      $error = command[0]
      if command.size < 5 
        Console_Commands.error
      else
        map_file = "Map00#{command[1]}.rvdata2" if command[1].to_i < 10 
        map_file = "Map0#{command[1]}.rvdata2"  if command[1].to_i >= 10 and command[1].to_i < 100 
        map_file = "Map#{command[1]}.rvdata2"   if command[1].to_i >= 100 
        if File.exist?("Data/#{map_file}") == false
          $output[0] = "Данной локации не существует." 
          $output[1] = ' '
        else
          $game_temp.fade_type = 0
          $game_player.reserve_transfer(command[1].to_i, command[2].to_i, command[3].to_i, command[4].to_i)
          $output[0] = "Перемещение на карту #{command[1]}"
          $output[1] = "по координатам Х:#{command[2]} Y:#{command[3]}." 
          Console_Commands.output
          Graphics.wait(60)
          Console_Commands.nul_text
          $reseted_switches = false
          $debug_zone.bitmap.clear
          Debug_Text.clear_bitmap
        end
      end
      Console_Commands.output if $reseted_switches != false
    #---------------------------------------------------------------------------
    #command >items
    #---------------------------------------------------------------------------      
    elsif command[0] == ">ITEMS"
      $error = command[0]
      if command[1] == "GIVE"
        if command[2] != nil and command[3] != nil
          $game_party.gain_item($data_items[command[2].to_i], command[3].to_i) 
          $output[0] = "Команда получает "
          $output[1] = $data_items[command[2].to_i].name.to_s 
          $output[2] = "в количестве " + command[3].to_s + " шт. "
          
        else
          Console_Commands.error
        end
      elsif command[1] == "LOSE"
        if command[2] != nil and command[3] != nil
          $game_party.lose_item($data_items[command[2].to_i], command[3].to_i) 
          $output[0] = "Команда теряет "
          $output[1] = $data_items[command[2].to_i].name.to_s
          $output[2] = "в количестве " + command[3].to_s + " шт. "
        else
          Console_Commands.error
        end
      elsif command[1] == "LIST"
        command[2] == nil ? i = 1 : i = command[2].to_i
        command[3] == nil ? j = i + 16 : j = command[3].to_i
        index = 0
        $output[0] = "--==Список предметов с #{i} по #{j}==--" 
        while i <= j
          if $data_items[i] == nil
            item = "<none>"  if $data_items[i] == nil
            index += 1
          else
            index += 1
            item = $data_items[i].name
            item = " n/a " if $data_items[i].name == "" 
            space = "   " if i < 10
            space = "  "  if i >= 10 &&  i < 100
            space = " "   if i >= 100
          end
          $output[i] = "#{i}#{space}#{item}"
          i += 1 
        end
        Console_Commands.output
      else
        Console_Commands.error
      end
      Console_Commands.output if command[1] != "LIST"
    #---------------------------------------------------------------------------
    #command >weapons 
    #---------------------------------------------------------------------------      
    elsif command[0] == ">WEAPONS"
      $error = command[0]
      if command[1] == "GIVE"
        if command[2] != nil and command[3] != nil
          $game_party.gain_item($data_weapons[command[2].to_i], command[3].to_i) 
          $output[0] = "Команда получает "
          $output[1] = $data_weapons[command[2].to_i].name.to_s
          $output[2] = "в количестве " + command[3].to_s + " шт. "
          
        else
          Console_Commands.error
        end
      elsif command[1] == "LOSE"
        if command[2] != nil and command[3] != nil
          $game_party.lose_item($data_weapons[command[2].to_i], command[3].to_i) 
          $output[0] = "Команда теряет "
          $output[1] = $data_weapons[command[2].to_i].name.to_s
          $output[2] = "в количестве " + command[3].to_s + " шт. "
          
        else
          Console_Commands.error
        end
      elsif command[1] == "LIST"
        command[2] == nil ? i = 1 : i = command[2].to_i
        command[3] == nil ? j = i + 16 : j = command[3].to_i
        index = 0
        $output[0] = "Список оружия с #{i} по #{j}" 
        while i <= j
          if $data_items[i] == nil
            item = "<none>"  if $data_weapons[i] == nil
            index += 1
          else
            index += 1
            item = $data_weapons[i].name
            item = " n/a " if $data_weapons[i].name == "" 
            space = "   " if i < 10
            space = "  "  if i >= 10 &&  i < 100
            space = " "   if i >= 100
          end
          $output[i] = "#{i}#{space}#{item}"
          i += 1 
        end
        Console_Commands.output
      else
        Console_Commands.error
      end
      Console_Commands.output if command[1] != "LIST"
    #---------------------------------------------------------------------------
    #command >switch
    #---------------------------------------------------------------------------      
    elsif command[0] == ">SWITCH" or command[0] == ">SW"
      $error = command[0]
      if command[1] != nil
        if    command[2] == "TRUE"  or command[2] == "ON"
          $game_switches[command[1].to_i] = true
          $output[0] = "Переключатель №#{command[1].to_i} включен."
        elsif command[2] == "FALSE" or command[2] == "OFF"
          $game_switches[command[1].to_i] = false
          $output[0] = "Переключатель №#{command[1].to_i} выключен."
        else
          $output[0] = "Переключатель №#{command[1].to_i} => #{$game_switches[command[1].to_i]}"
        end
      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >timer
    #---------------------------------------------------------------------------      
    elsif command[0] == ">TIMER" 
      $error = command[0]
      if    command[1] == "START"
        if command[2] != nil
          $output[0] = "Таймер запущен"
          Console_Commands.output
          Graphics.wait(60)
          $game_timer.start(command[2].to_i * Graphics.frame_rate)
          Console_Commands.nul_text
          $debug_zone.bitmap.clear
          Debug_Text.clear_bitmap
          $reseted_switches = false
        else 
          Console_Commands.error
        end
      elsif  command[1] == "ADD"
        if command[2] != nil
          a = $game_timer.sec
          $game_timer.stop
          sec = $game_timer.sec + command[2].to_i 
          $output[0] = "Добавлено #{command[2]} секунд"
          Console_Commands.output
          Graphics.wait(60)
          $game_timer.start(sec * Graphics.frame_rate)
          Console_Commands.nul_text
          $debug_zone.bitmap.clear
          Debug_Text.clear_bitmap
          $reseted_switches = false
        else 
          Console_Commands.error
        end
      elsif command[1] == "STOP"
        $output[0] = "Таймер остановлен"
        Console_Commands.output
        $game_timer.stop
      else
        Console_Commands.error
      end
    #---------------------------------------------------------------------------
    #command >variable
    #---------------------------------------------------------------------------      
    elsif command[0] == ">VARIABLE" or command[0] == ">VAR"
      $error = command[0]
      if command[1] != nil
        if    command[2] != nil
          $game_variables[command[1].to_i] = command[2].to_i
          $output[0] = "Переменная №#{command[1].to_i} теперь равна #{$game_variables[command[1].to_i]}"
        else
          $output[0] = "Переменная №#{command[1].to_i} равна #{$game_variables[command[1].to_i]}"
        end
      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >armors
    #---------------------------------------------------------------------------      
    elsif command[0] == ">ARMORS"
      $error = command[0]
      if command[1] == "GIVE" and command[2] != nil and command[3] != nil
        $game_party.gain_item($data_armors[command[2].to_i], command[3].to_i) 
        $output[0] = "Команда получает "
        $output[1] = $data_armors[command[2].to_i].name.to_s 
        $output[2] = "в количестве " + command[3].to_s + " шт. "
      elsif command[1] == "LOSE" and command[2] != nil and command[3] != nil
        $game_party.lose_item($data_armors[command[2].to_i], command[3].to_i)
        $output[0] = "Команда теряет "
        $output[1] = $data_armors[command[2].to_i].name.to_s
        $output[2] = "в количестве " + command[3].to_s + " шт. "
      elsif command[1] == "LIST"
        command[2] == nil ? i = 1 : i = command[2].to_i
        command[3] == nil ? j = i + 16 : j = command[3].to_i
        index = 0
        $output[0] = "Список оружия с #{i} по #{j}" 
        while i <= j
          if $data_items[i] == nil
            item = "<none>"  if $data_armors[i] == nil
            index += 1
          else
            index += 1
            item = $data_armors[i].name
            item = " n/a " if $data_armors[i].name == "" 
            space = "   " if i < 10
            space = "  "  if i >= 10 &&  i < 100
            space = " "   if i >= 100
          end
          $output[i] = "#{i}#{space}#{item}"
          i += 1 
        end
        Console_Commands.output
      else
        Console_Commands.error
      end
      Console_Commands.output if command[1] != "LIST"
    #---------------------------------------------------------------------------
    #command >skills
    #---------------------------------------------------------------------------      
    elsif command[0] == ">SKILLS"
      $error = command[0]
      if command[1] == "LEARN" 
        if command[2] == "ACTOR" and  command[3] != nil and command[4] != nil
          $game_actors[command[3].to_i].learn_skill(command[4].to_i)
          $output[0] = $game_actors[command[3].to_i].name.to_s + " изучает навык " + $data_skills[command[4].to_i].name.to_s
          $output[1] = ' '
        elsif command[2] == "ALL" and command[3] != nil
          $game_party.members.each { |actor| actor.learn_skill(command[3].to_i) }
          $output[0] = "Все изучили навык " + $data_skills[command[3].to_i].name.to_s
          $output[1] = ' '
        else
          Console_Commands.error
        end
      elsif command[1] == "FORGET" 
        if command[2] == "ACTOR" and command[3] != nil and command[4] != nil
          $game_actors[command[3].to_i].forget_skill(command[4].to_i)
          $output[0] = $game_actors[command[3].to_i].name.to_s + " забывает навык " + $data_skills[command[4].to_i].name.to_s
        elsif command[2] == "ALL" and command[3] != nil
          $game_party.members.each { |actor| actor.forget_skill(command[3].to_i) }
          $output[0] = "Все забыли навык " + $data_skills[command[3].to_i].name.to_s
        else
          Console_Commands.error
        end
      elsif command[1] == "LIST"
        command[2] == nil ? i = 1 : i = command[2].to_i
        command[3] == nil ? j = i + 16 : j = command[3].to_i
        index = 0
        $output[0] = "Список оружия с #{i} по #{j}" 
        while i <= j
          if $data_items[i] == nil
            item = "<none>"  if $data_skills[i] == nil
            index += 1
          else
            index += 1
            item = $data_skills[i].name
            item = " n/a " if $data_skills[i].name == "" 
            space = "   " if i < 10
            space = "  "  if i >= 10 &&  i < 100
            space = " "   if i >= 100
          end
          $output[i] = "#{i}#{space}#{item}"
          i += 1 
        end
        Console_Commands.output
      else
        Console_Commands.error
      end
      Console_Commands.output if command[1] != "LIST"
    #---------------------------------------------------------------------------
    #command >actor
    #---------------------------------------------------------------------------      
    elsif command[0] == ">ACTOR"
      $error = command[0]
      if    command[1] == "EDIT" and command[2] != nil #ID героя
        i = command[2].to_i
        $step = 0 if $inrput_no_command == false
        $inrput_no_command = true 
        $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Имя героя:") if $step == 0
        if $step == 1
          $input_text.delete!('>') 
          size = $input_text_index - 2
          $game_actors[i].name = $input_text[0..size]
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Имя героя: #{$game_actors[i].name}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "На какой уровень:")  
        elsif $step == 2
          $actor_leve_debug = $input_text.delete('>').to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "На какой уровень: #{$actor_leve_debug}")
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Max HP:")  
        elsif $step == 3
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[0] ? param = $actor_params[0] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[0, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Max HP: #{$data_classes[$game_actors[i].class.id.to_i].params[0, $actor_leve_debug.to_i]}")
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Max MP: ")  
        elsif $step == 4
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[1] ? param = $actor_params[1] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[1, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Max MP: #{$data_classes[$game_actors[i].class.id.to_i].params[1, $actor_leve_debug.to_i]}")
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "ATK:")  
        elsif $step == 5
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[2] ? param = $actor_params[2] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[2, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "ATK: #{$data_classes[$game_actors[i].class.id.to_i].params[2, $actor_leve_debug.to_i]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "DEF:")  
        elsif $step == 6
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[3] ? param = $actor_params[3] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[3, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "DEF: #{$data_classes[$game_actors[i].class.id.to_i].params[3, $actor_leve_debug.to_i]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "MAT:")  
        elsif $step == 7
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[4] ? param = $actor_params[4] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[4, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "MAT: #{$data_classes[$game_actors[i].class.id.to_i].params[4, $actor_leve_debug.to_i]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "MDF:")  
        elsif $step == 8
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[5] ? param = $actor_params[5] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[5, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "MDF: #{$data_classes[$game_actors[i].class.id.to_i].params[5, $actor_leve_debug.to_i]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "AGI:")  
        elsif $step == 9
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[6] ? param = $actor_params[6] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[6, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "AGI: #{$data_classes[$game_actors[i].class.id.to_i].params[6, $actor_leve_debug.to_i]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "LUK:")  
        elsif $step == 10
          $input_text.delete!('>') 
          $input_text.to_i > $actor_params[7] ? param = $actor_params[7] : param = $input_text
          $data_classes[$game_actors[i].class.id.to_i].params[7, $actor_leve_debug.to_i] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "LUK: #{$data_classes[$game_actors[i].class.id.to_i].params[7, $actor_leve_debug.to_i]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Готово")  
          $inrput_no_command = false
          $step = 0
        end 
      elsif command[1] == "RENAME" and command[2] != nil and command[3] != nil
        i = command[2].to_i
        $game_actors[i].name = command[3].gsub(/([a-z])_/){ $1 + " " } 
        $output[0] = i.to_s + "-ый герой переименован в " + command[3].gsub(/([a-z])_/){ $1 + " " } 
        $output[1] = ' '
      elsif command[1] == "ADD" and command[2] != nil 
        $game_party.add_actor(command[2].to_i)
        $output[0] = "Герой №" + command[2].to_s + " присоединился в команду"
      elsif command[1] == "REMOVE" and command[2] != nil 
        $game_party.remove_actor(command[2].to_i)
        $output[0] = "Герой №" + command[2].to_s + " покидает команду"
        $output[1] = ' '
      elsif command[1] == "LIST"
        command[2] == nil ? i = 1 : i = command[2].to_i
        command[3] == nil ? j = i + 16 : j = command[3].to_i
        $output[0] = "ID  Имя         ЛВЛ МиЛВЛ МаЛВЛ MHP  MMP  ATK  DEF  MAT  MDF  AGI  LUK"
        out_int = 1
        while i <= j
          if $game_actors[i] == nil
            $output[out_int] = i.to_s + "   <Персонажа нет в базе данных>                      " if i < 10
            $output[out_int] = i.to_s + "  <Персонажа нет в базе данных>                       "  if i > 10 &&  i < 100
            $output[out_int] = i.to_s + " <Персонажа нет в базе данных>                        "   if i > 100
            out_int +=1
          else
            id = "#{i}   " if i < 10
            id = "#{i}  " if (10..99).include?(i)
            id = "#{i} " if i > 10
            #--------------
            name = $game_actors[i].name
            name.size > 11 ?  outputname = name[0..10] : outputname = name + (" " * (11 - $game_actors[i].name.size))
            outputname[10] = "~" if name.size > 11
            outputname    = "<без имени>" if name == ""
            #--------------
            $game_actors[i].level > 9 ? current_lvl = "#{$game_actors[i].level}  " : current_lvl = "#{$game_actors[i].level}   "
            #--------------
            $data_actors[i].initial_level > 9 ? minlvl = "#{$data_actors[i].initial_level}    " : minlvl = "#{$data_actors[i].initial_level}     "
            #--------------
            $data_actors[i].max_level > 9 ? maxlvl = "#{$data_actors[i].max_level}    " : maxlvl = "#{$data_actors[i].max_level}     "
            #--------------
            hp = $data_classes[$game_actors[i].class_id].params[0, $game_actors[i].level]
            mhp = "#{hp}" + (" " * (5 - "#{hp}".size)) if hp < 1000
            mhp = "#{hp / 1000}k" + (" " * (5 - "#{hp / 1000}k".size)) if (1000..999999).include?(hp)
            mhp = "#{hp / 1000000}m" + (" " * (5 - "#{hp / 1000000}m".size)) if hp >= 1000000
            #--------------
            mp = $data_classes[$game_actors[i].class_id].params[1, $game_actors[i].level]
            mmp = "#{mp}" + (" " * (5 - "#{mp}".size)) if mp < 1000
            mmp = "#{mp / 1000}k" + (" " * (5 - "#{mp / 1000}k ".size)) if (1000..999999).include?(mp)
            mmp = "#{mp / 1000000}m" + (" " * (5 - "#{mp}".size)) if mp >= 1000000
            #--------------
            atk = $data_classes[$game_actors[i].class_id].params[2, $game_actors[i].level]
            outatk = "#{atk}" + (" " * (5 - "#{atk}".size))if atk < 1000
            outatk = "#{atk / 1000}k" + (" " * (5 - "#{atk / 1000}k".size)) if (1000..999999).include?(atk)
            outatk = "#{atk / 1000000}m" + (" " * (5 - "#{atk / 1000000}m".size)) if atk >= 1000000
            #--------------
            defence = $data_classes[$game_actors[i].class_id].params[3, $game_actors[i].level]
            outdef = "#{defence}" + (" " * (5 - "#{defence}".size)) if defence < 1000
            outdef = "#{defence / 1000}k" + (" " * (5 - "#{defence / 1000}k".size)) if (1000..999999).include?(defence)
            outdef = "#{defence / 1000000}m" + (" " * (5 - "#{defence / 1000000}m".size)) if defence >= 1000000
            #--------------
            mat = $data_classes[$game_actors[i].class_id].params[4, $game_actors[i].level]
            outmat = "#{mat}" + (" " * (5 - "#{mat}".size))if mat < 1000
            outmat = "#{mat / 1000}k" + (" " * (5 - "#{mat / 1000}k".size)) if (1000..999999).include?(mat)
            outmat = "#{mat / 1000000}m" + (" " * (5 - "#{mat / 1000000}m".size)) if mat >= 1000000
            #--------------
            mdf = $data_classes[$game_actors[i].class_id].params[5, $game_actors[i].level]
            outmdf = "#{mdf}" + (" " * (5 - "#{mdf}".size)) if mdf < 1000
            outmdf = "#{mdf / 1000}k" + (" " * (5 - "#{mdf / 1000}k".size)) if (10000..999999).include?(mdf)
            outmdf = "#{mdf / 1000000}m" + (" " * (5 - "#{mdf / 1000000}m".size)) if mdf >= 1000000
            #--------------
            agi = $data_classes[$game_actors[i].class_id].params[6, $game_actors[i].level]
            outagi = "#{agi}" + (" " * (5 - "#{agi}".size)) if agi < 1000
            outagi = "#{agi / 1000}k" + (" " * (5 - "#{agi / 1000}k".size)) if (1000..999999).include?(agi)
            outagi = "#{agi / 1000000}m" + (" " * (5 - "#{agi / 1000000}m".size)) if agi >= 1000000
            #--------------
            luk = $data_classes[$game_actors[i].class_id].params[7, $game_actors[i].level]
            outluk = "#{luk}" + (" " * (5 - "#{luk}".size)) if luk < 1000
            outluk = "#{luk / 1000}k" + (" " * (5 - "#{luk / 1000}k".size)) if (1000..999999).include?(luk)
            outluk = "#{luk / 1000000}m" + (" " * (5 - "#{luk / 1000000}m".size)) if luk >= 1000000
            
            $output[out_int] = "#{id}#{outputname} #{current_lvl}#{minlvl}#{maxlvl}#{mhp}#{mmp}#{outatk}#{outdef}#{outmat}#{outmdf}#{outagi}#{outluk}"
            out_int += 1
          end
          i+=1
        end
        puts ' '
      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >heal
    #---------------------------------------------------------------------------
    elsif command[0] == ">HEAL" #command
      $error = command[0]
      if command[1]    == "ACTOR"
        if command[2] == "HP"
          command[3] == nil ? Console_Commands.error : one = command[3].to_i
          command[4] == nil ? two = command[3].to_i  : two = command[4].to_i
          out_int = 0
          (one..two).each do |x|
            $game_party.members[x].hp = 99999999 
            $output[out_int] = "#{$game_party.members[x].name} восстанавливает HP!" 
            out_int += 1
          end
          Audio.se_play("Audio/SE/Absorb2")
        elsif command[2] == "MP"
          command[3] == nil ? Console_Commands.error : one = command[3].to_i
          command[4] == nil ? two = command[3].to_i  : two = command[4].to_i
          out_int = 0
          (one..two).each do |x|
            $game_party.members[x].mp = 99999999 
            $output[out_int] = "#{$game_party.members[x].name} восстанавливает MP!" 
            out_int += 1
          end
          Audio.se_play("Audio/SE/Barrier")
        elsif command[2] == "TP"
          command[3] == nil ? Console_Commands.error : one = command[3].to_i
          command[4] == nil ? two = command[3].to_i  : two = command[4].to_i
          out_int = 0
          (one..two).each do |x|
            $game_party.members[x].tp = 99999999 
            $output[out_int] = "#{$game_party.members[x].name} восстанавливает HP!" 
            out_int += 1
          end
          Audio.se_play("Audio/SE/Collapse3")
        elsif command[2] == "ALL"
          command[3] == nil ? Console_Commands.error : one = command[3].to_i
          command[4] == nil ? two = command[3].to_i  : two = command[4].to_i
          out_int = 0
          (one..two).each do |x|
            $game_party.members[x].hp = 99999999 
            $game_party.members[x].mp = 99999999 
            $game_party.members[x].tp = 99999999 
            $output[out_int] = "#{$game_party.members[x].name} восстанавливает HP!" 
            out_int += 1
          end
          Audio.se_play("Audio/SE/Absorb2")
          Audio.se_play("Audio/SE/Barrier")
          Audio.se_play("Audio/SE/Collapse3")
        end      
      elsif command[1] == "PARTY"
        if    command[2] == "HP"
          $game_party.all_members.each do |x|
            x.hp = 99999999
          end
          $output[0] = "Команда восстанавливает свои НР!"
          Audio.se_play("Audio/SE/Absorb2")
        elsif command[2] == "MP"
          $game_party.all_members.each do |x|
            x.mp = 99999999
          end
          $output[0] = "Команда восстанавливает свои МР!"
          Audio.se_play("Audio/SE/Barrier")
        elsif command[2] == "TP"
          $game_party.all_members.each do |x|
            x.tp = 99999999
          end
          $output[0] = "Команда восстанавливает свои ТР!"
          Audio.se_play("Audio/SE/Collapse3")
        elsif command[2] == "ALL"
          $game_party.all_members.each do |x|
            x.hp = 99999999
            x.mp = 99999999
            x.tp = 99999999
          end
          $output[0] = "Команда полностью восстанавливается!"
          Audio.se_play("Audio/SE/Absorb2")
          Audio.se_play("Audio/SE/Barrier")
          Audio.se_play("Audio/SE/Collapse3")
        end
      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >enemy
    #---------------------------------------------------------------------------      
    elsif command[0] == ">ENEMY" #command
      $error = command[0]
      if command[1] == "EDIT" and command[2] != nil
        i = command[2].to_i
        $step = 0 if $inrput_no_command == false
        $inrput_no_command = true 
        $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Имя врага:") if $step == 0
        if $step == 1
          $input_text.delete!('>') 
          size = $input_text_index - 2
          $data_enemies[i].name = $input_text[0..size]
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Имя врага: #{$data_enemies[i].name}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Получаемый опыт: ")  
        elsif $step == 2
          $input_text.delete!('>')
          $data_enemies[i].exp = $input_text.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Получаемый опыт: #{$data_enemies[i].exp}")
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Получаемые деньги:")  
        elsif $step == 3
          $input_text.delete!('>')
          $data_enemies[i].gold  = $input_text.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Получаемые деньги: #{$data_enemies[i].gold}")
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Графика (Вписывать название баттлера): ")  
        elsif $step == 4
          $input_text.delete!('>') 
          size = $input_text_index - 2
          $data_enemies[i].battler_name = $input_text[0..size]
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Графика (Вписывать название баттлера): #{$data_enemies[i].battler_name}")
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Оттенок (от 0 до 360):")  
        elsif $step == 5
          $data_enemies[i].battler_hue = $input_text.delete('>').to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Оттенок (от 0 до 360): #{$data_enemies[i].battler_hue}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Max HP: ")  
        elsif $step == 6
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(0) ? param = $data_enemies[i].params[0] : param = $input_text
          $data_enemies[i].params[0] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Max HP: #{$data_enemies[i].params[0]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Max MP:")  
        elsif $step == 7
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(1) ? param = $data_enemies[i].params[1] : param = $input_text
          $data_enemies[i].params[1] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "Max MP: #{$data_enemies[i].params[1]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "ATK:")  
        elsif $step == 8
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(2) ? param = $data_enemies[i].params[2] : param = $input_text
          $data_enemies[i].params[2] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "ATK: #{$data_enemies[i].params[2]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "DEF:")  
        elsif $step == 9
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(3) ? param = $data_enemies[i].params[3] : param = $input_text
          $data_enemies[i].params[3] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "DEF: #{$data_enemies[i].params[3]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "MAT:")  
        elsif $step == 10
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(4) ? param = $data_enemies[i].params[4] : param = $input_text
          $data_enemies[i].params[4] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "MAT: #{$data_enemies[i].params[4]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "MDF:")  
        elsif $step == 11
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(5) ? param = $data_enemies[i].params[5] : param = $input_text
          $data_enemies[i].params[5] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "MDF: #{$data_enemies[i].params[5]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "AGI:")  
        elsif $step == 12
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(6) ? param = $data_enemies[i].params[6] : param = $input_text
          $data_enemies[i].params[6] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "AGI: #{$data_enemies[i].params[6]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "LUK:") 
        elsif $step == 13
          $input_text.delete!('>')
          $input_text.to_i > $data_enemies[i].param_max(6) ? param = $data_enemies[i].params[6] : param = $input_text
          $data_enemies[i].params[7] = param.to_i
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step), "AGI: #{$data_enemies[i].params[7]}")  
          $debug_zone.bitmap.draw_text(5, 2, Graphics.width - 5, 35 * ($step + 1), "Готово")  
          $inrput_no_command = false
          $step = 0
        end 
      elsif (command[1] == "SUMMON_BATTLE" or command[1] == "SB") and command[2] != nil 
        troop_id = command[2].to_i
        esc = false if command[3] == nil or command[3] == "0"#Can Escape?
        esc = true if command[3] == "1"
        cont = false if command[4] == nil or command[4] == "0"#Continue?
        cont = true if command[4] == "1" #Continue?
        BattleManager.setup(troop_id, esc, cont)
        $game_player.make_encounter_count
        SceneManager.call(Scene_Battle)
        Console_Commands.nul_text
        $debug_zone.bitmap.clear
        $reseted_switches = false
      elsif command[1] == "RENAME" and command[2] != nil and command[3] != nil
        i = command[2].to_i
        $data_enemies[i].name = command[3].gsub(/([a-z])_/){ $1 + " " } 
        $output[0] = i.to_s + "-ый враг переименован в " + command[3].gsub(/([a-z])_/){ $1 + " " } 
        $output[1] = ' '
      elsif command[1] == "LIST"
        command[2] == nil ? i = 1 : i = command[2].to_i
        command[3] == nil ? j = i + 16 : j = command[3].to_i
        $output[0] = "ID  NAME  MHP MMP ATK DEF MAT MDF AGI LUK"
        out_int = 1
        (i..j).each do |id|
          if $data_enemies[i] == nil
            $output[out_int] = i.to_s + "n/a           " if i < 10
            $output[out_int] = i.to_s + "n/a          "  if i > 10 &&  i < 100
            $output[out_int] = i.to_s + "n/a         "   if i > 100
            out_int +=1
          else
            temp_text = ""
            temp_text += "#{id}   " if id < 10
            temp_text += "#{id}  " if (10...100).include?(id)
            temp_text += "#{id} " if id >= 100
            
            if $data_enemies[id].name.size > 5
              temp_text += "#{$data_enemies[id].name[0...4]}~ "              
            elsif $data_enemies[id].name.size == 5
              temp_text += "#{$data_enemies[id].name} "
            elsif $data_enemies[id].name == ""
              temp_text += "n/a        "
            else
              temp_text += $data_enemies[id].name + (" " * (6 - $data_enemies[id].name.size))
            end
            (0..7).each do |par|
              parameter_m = "#{$data_enemies[id].params[par]}"
              parameter_m = "#{$data_enemies[id].params[par] / 1000}k"   if (1000...1000000).include?($data_enemies[id].params[par])
              parameter_m = "#{$data_enemies[id].params[par] / 100000}m" if $data_enemies[id].params[par] >= 1000000
              temp_text   += parameter_m + (" " * (4 - parameter_m.size))
            end
            parameter_m = "#{$data_enemies[id].exp}"
            parameter_m = "#{$data_enemies[id].exp / 1000}k"   if (1000...1000000).include?($data_enemies[id].exp)
            parameter_m = "#{$data_enemies[id].exp / 100000}m" if $data_enemies[id].exp >= 1000000
            temp_text   += parameter_m + (" " * (4 - parameter_m.size))
            
            parameter_m = "#{$data_enemies[id].gold}"
            parameter_m = "#{$data_enemies[id].gold / 1000}k"   if (1000...1000000).include?($data_enemies[id].gold)
            parameter_m = "#{$data_enemies[id].gold / 100000}m" if $data_enemies[id].gold >= 1000000
            temp_text   += parameter_m + (" " * (4 - parameter_m.size))
              
            p temp_text
            
            $output.push(temp_text)
          end
        end
      elsif command[1] == "SHOW" or command[1] == "INFO"
        if command[2].to_i != 0
          $enemy = Sprite.new
          $enemy.bitmap = Bitmap.new("Graphics/Battlers/" + $data_enemies[command[2].to_i].battler_name )
          $enemy.x = 360
          $enemy.y = 280
          $enemy.ox = $enemy.bitmap.width / 2
          $enemy.oy = $enemy.bitmap.height 
          x = 20
          y = 90
          Debug_Text.draw_word("Имя: " + $data_enemies[command[2].to_i].name, x, y)
          (0..7).each do |par|
            Debug_Text.draw_word(" #{Vocab.param(par)}: #{$data_enemies[command[2].to_i].params[par]}", x, y + 20 + (20 * par))
          end
          Debug_Text.draw_word(" #{Vocab.currency_unit}: #{$data_enemies[command[2].to_i].gold}", x, y + 180)
          Debug_Text.draw_word(" EXP: #{$data_enemies[command[2].to_i].exp}", x, y + 200)
          
          (0..2).each do |item|
            name = "Ничего"
            item_id = $data_enemies[command[2].to_i].drop_items[item].data_id
            kind_id = $data_enemies[command[2].to_i].drop_items[item].kind
            denominator = $data_enemies[command[2].to_i].drop_items[item].denominator
            
            name = $data_items[item_id].name if kind_id == 1
            name = $data_weapons[item_id].name if kind_id == 2
            name = $data_armors[item_id].name if kind_id == 3
            
            Debug_Text.draw_word(" Дроп #{item +1}: #{name} | 1 к #{denominator}", x, y + 220 + (20 * item))  
          end
          
        end

      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command /window
    #---------------------------------------------------------------------------  
    elsif command[0] == ">WINDOW"
      $error = command[0]
      if    command[1] == "HIDE"
        ShowWindow.call(HWND, 0)
      elsif command[1] == "RESIZE" and command[2] != nil and command[3] != nil and command[4] != nil and command[5] != nil
        SetWindowPos.call(HWND, -2, command[2].to_i, command[3].to_i, command[4].to_i, command[5].to_i, 0)
      elsif command[1] == "RESIZE_GAME" and command[2] != nil and command[3] != nil
        Graphics.resize_screen(command[2].to_i, command[3].to_i) 
      else
        Console_Commands.error
      end
    #---------------------------------------------------------------------------
    #command >gold
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">GOLD"
      $error = command[0]
      if command[1] == "GIVE" and command[2] != nil
        $game_party.gain_gold(command[2].to_i) 
        $output[0] = "Команда получает " + command[2].to_s + " #{Vocab.currency_unit[0]}."
        $output[1] = "Сейчас имеется #{$game_party.gold} #{Vocab.currency_unit[0]}."
      elsif command[1] == "LOSE" and command[2] != nil
        $game_party.lose_gold(command[2].to_i) 
        $output[0] = "Команда теряет " + command[2].to_s + " #{Vocab.currency_unit[0]}."
        $output[1] = "Сейчас имеется #{$game_party.gold} #{Vocab.currency_unit[0]}."
      else
        Console_Commands.error
      end    
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >tone
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">BGM" 
      $error = command[0]
      if command[1] == "LIST" 
        command[2] == nil ? i = 1 : i = command[2].to_i
        command[3] == nil ? j = i + 16 : j = command[3].to_i
        index = 0
        $output[0] = "Список музыки с #{i} по #{j}" 
        output_inyeger = 1
        while i <= j
          if $all_bgm[i] == nil
            item = "<none>"  if $all_bgm[i] == nil
            index += 1
          else
            index += 1
            item = $all_bgm[i]
            item = " n/a " if $all_bgm[i] == "" 
            space = "   " if i < 10
            space = "  "  if i >= 10 &&  i < 100
            space = " "   if i >= 100
          end
          $output[output_inyeger] = "#{i}#{space}#{item}"
          output_inyeger += 1
          i += 1 
        end
      elsif command[1] == "PLAY"
        if command[2] != nil
          if $all_bgm[command[2].to_i] == nil
            command[2] = -1 
            $output[0] = "Данной музыки нет в списке"
            $output[1] = "Музыка сменена на #{$all_bgm[command[2].to_i]}"
            Audio.bgm_play("#{RTP_path}Audio/BGM/#{$all_bgm[command[2].to_i]}")
          else
            if File.exist?("Audio/BGM/#{$all_bgm[command[2].to_i]}")
              Audio.bgm_play("Audio/BGM/#{$all_bgm[command[2].to_i]}")
            elsif $rtpbgm_files.include?($all_bgm[command[2].to_i])
              Audio.bgm_play("Audio/BGM/#{$all_bgm[command[2].to_i]}")
            end
            $output[0] = "Музыка сменена на #{$all_bgm[command[2].to_i]}"
          end
        else
          Console_Commands.error
        end
      elsif command[1] == "OFF" or command[1] == "STOP"
        if command[2] == nil
          Audio.bgm_stop 
          $output[0] = "Музыка выключена"
        else
          Audio.bgm_fade(command[2].to_i)
          sec = command[2].to_i / 1000.0
          index = sec.to_s.index(".")
          $output[0] = "Музыка выключится через #{sec.to_s[0..(index + 1)]} секунд"
          if sec > 300
            min = sec / 60.0
            $output[0] = "Музыка выключится через #{min.to_s[0..(index + 1)]} минут"
          end
        end
      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >tone
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">TONE" 
      $error = command[0]
      if command[1] == "SET" and command[2] != nil and command[3] != nil and command[4] != nil and command[5] != nil
        $game_map.screen.start_tone_change(Tone.new(command[2].to_i, command[3].to_i, command[4].to_i, command[5].to_i), 1)
      elsif command[1] == "CHANGE" and command[2] != nil and command[3] != nil and command[4] != nil and command[5] != nil and command[6] != nil
        $game_map.screen.start_tone_change(Tone.new(command[2].to_i, command[3].to_i, command[4].to_i, command[5].to_i), command[6].to_i)
      else
        Console_Commands.error
      end     
    #---------------------------------------------------------------------------
    #command >screen
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">KHAS"
      if $khas_effect == true
        $error = command[0]
        if command[1] == "LIGHTS"
          if command[2] != nil and command[3] != nil and command[4] != nil and command[5] != nil
            if command[6].to_i != nil
              a = Array.new(1)
              a = [command[2].to_i, command[3].to_i, command[4].to_i, command[5].to_i] 
              s = $game_map.effect_surface
              s.change_color(a[0],a[1],a[2],a[3],command[6].to_i) 
            else
              s.change_color(a[0],a[1],a[2],a[3]) 
            end  
            $output[0] = "Измененяем освещение"
          else    
            Console_Commands.error
          end
        else
          Console_Commands.error
        end  
      else 
        $output[0] = "Khas Awesome Light Effects"
        $output[1] = "                    не установлен!"
      end    
    Console_Commands.output
    #---------------------------------------------------------------------------
    #command >screen
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">SCREEN"
      $error = command[0]
      if command[1] == "SHOW"
        if command[2] != nil
          Graphics.fadein(command[2].to_i) 
        else
          Graphics.fadein(1)
        end
      elsif command[1] == "HIDE"
        if command[2] != nil
          Graphics.fadeout(command[2].to_i) 
        else
          Graphics.fadeout(1) 
        end
      elsif command[1] == "SIZE"
        setCursorPos  = Win32API.new('user32', 'SetCursorPos' , 'iiiiiii' ,'i')
        getCursorXY   = Win32API.new("user32", 'GetCursorPos' , 'P'       , "V")
        result = "0"*8 
        getCursorXY.call(result)
        $mouse_x, $mouse_y = result.unpack("LL") 
        setCursorPos.call(9999,9999,0,0,0,0, 0)
        window = "0"*8 # 
        getCursorXY.call(window)
        $win_x, $win_y = window.unpack("LL") 
        $output[0] = "Твоё разрешение экрана " + ($win_x + 1).to_s + "x" + ($win_y + 1).to_s
        setCursorPos.call($mouse_x,$mouse_y,0,0,0,0, 0)
      else
        Console_Commands.error
      end 
      Console_Commands.output
    #---------------------------------------------------------------------------
    #command >clear
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">CLEAR"
      system('cls')
    #---------------------------------------------------------------------------
    #command >commonevent
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">COMMONEVENT"
      $error = command[0]
      if command[1] == nil
        Console_Commands.error
      else 
        Console_Commands.nul_text
        $debug_zone.bitmap.clear
        $reseted_switches = false
        $game_temp.reserve_common_event(command[1].to_i)
      end
    #---------------------------------------------------------------------------
    #command >map
    #--------------------------------------------------------------------------- 
    elsif command[0] == ">MAP"
      $error = command[0]
      if command[1] == "TROOP"
        if command[2] == "SHOW"
          out_int = 0
          max =  (Graphics.height - 35) / 18
          while out_int < max
            if $game_map.encounter_list[out_int] == nil
              $output[out_int] = "#{out_int + 1} <none>"
            else
              $output[out_int] = "#{out_int + 1} #{$data_troops[$game_map.encounter_list[out_int].troop_id.to_i].name}"
            end
            out_int += 1
            puts out_int
          end
        else
          Console_Commands.error
        end
      elsif command[1] == "INFO"
        a = $game_map.map_id
        if $game_map.encounter_list[0].nil? == true
          encounters = "<none>" 
        else
          encounters = Array.new
          var1 = 0
          new_arr = $game_map.encounter_list
          while new_arr[var1.to_i] != nil
            encounters[var1.to_i] = $data_troops[new_arr[var1.to_i].troop_id.to_i].name
            var1 += 1
          end
        end
        if $game_map.parallax_name == ""
          parall = "<none>" 
        else
          parall = $game_map.parallax_name
        end
        $game_map.disable_dash? == true ? run = "Да" : run = "Нет"
        $game_map.loop_vertical? == true ? vert = "ВКЛ" : vert = "ВЫКЛ"
        $game_map.loop_horizontal? == true ? hor = "ВКЛ" : hor = "ВЫКЛ"
        $output[0] = "Имя карты                     "
        $output[1] = "  " + $data_mapinfos[a].name
        $output[2] = "ID карты                   " + a.to_s
        $output[3] = "Размеры карты              " + $game_map.width.to_s + "x" + $game_map.height.to_s
        $output[4] = "Событий на этой карте      " + $game_map.events.size.to_s
        $output[5] = "Случайные столкновения?    "
        $output[6] = "  " + encounters.to_s
        $output[7] = "Имя файла для параллакса   "
        $output[8] = "  " + parall.to_s
        $output[9] = "Бег отключён?              " + run.to_s
        $output[10] = "Вертикальная прокрутка?    " + vert.to_s
        $output[11] = "Горизонтальная прокрутка?  " + hor.to_s
        $output[12] = "Регион на котором ты стоишь " + $game_player.region_id.to_s 
      elsif command[1] == "EVENT"
        system('cls')
        if command[2] == nil
          tile_num = $game_map.width * $game_map.height
          num1 = 0
          num2 = 1
          while num1 != tile_num
            if $game_map.events[num1.to_i] != nil
              if num2 < 10
                event_num = num2.to_s + "  "
              elsif num2 >= 10 and num2 < 100
                event_num = num2.to_s + " "
              elsif num2 >= 100 
                event_num = num2.to_s 
              end
              ev_x = $game_map.events[num1.to_i].x
              ev_y = $game_map.events[num1.to_i].y
              if ev_x < 10
                ox = ev_x.to_s + "   "
              elsif ev_x >= 10 and num2 < 100
                ox = ev_x.to_s + "  "
              elsif ev_x >= 100 
                ox = ev_x.to_s + " "
              end
              if ev_y < 10
                oy = ev_y.to_s + "   "
              elsif ev_y >= 10 and num2 < 100
                oy = ev_y.to_s + "  "
              elsif ev_y >= 100 
                oy = ev_y.to_s + " "
              end
              $output[num1 - 1] = event_num.to_s + " X:" + ox.to_s + " Y:" + oy.to_s
              num2 +=1
            end
            num1 +=1
          end
        else
          $output[0] = command[2].to_s + " X:" + $game_map.events[command[2].to_i].x.to_s + " Y:" + $game_map.events[command[2].to_i].y.to_s
        end
      elsif command[1] == "EVENTS"
        if command[2] == "SHOW"
          $map_events_show = Array.new(300)
          events = Array.new(300)
          a = 1 
          b = $game_map.width * $game_map.height
          while a <= b
            unless $game_map.events[a].nil? 
              if $game_map.events[a].character_name == "" 
                $game_map.events[a].set_graphic('!Flame',5)
                events[a] = 'edited'
              else
                events[a] = 'nope'
              end
            else
              events[a] = '_'
            end
            a+=1
          end
          $map_events_show[$game_map.map_id] = events
          Console_Commands.nul_text
          $debug_zone.bitmap.clear
          $reseted_switches = false
        elsif command[2] == "SHOW_ARRIVE"
          print $map_events_show[$game_map.map_id]
        elsif command[2] != nil
          if command[3] == "TP" or command[3] == "TELEPORT"
            $game_temp.fade_type = 2
            $game_player.reserve_transfer($game_map.map_id, $game_map.events[command[2].to_i].x, $game_map.events[command[2].to_i].y, 2)
          end
        end
      elsif command[1] == "LIST"
        system('cls')
        command[2] == nil ? a = 1 : i = command[2].to_i
        command[3] == nil ? j = a + 16 : j = command[3].to_i
        $output[0] = 'ID  Имя карты'
        while a <= j
          map_file = "Map00#{a}.rvdata2" if a < 10 
          map_file = "Map0#{a}.rvdata2"  if a >= 10 and a < 100 
          map_file = "Map#{a}.rvdata2"   if a >= 100
          if File.exist?("Data/#{map_file}") == false
            b = a.to_s + "        " if a.to_s.size == 1
            b = a.to_s + "       "  if a.to_s.size == 2
            b = a.to_s + "      "   if a.to_s.size == 3
            $output[a] = b.to_s + '<none>  '
          else
            id = "#{a}    " if a < 10
            id = "#{a}   " if a >= 10 and a < 100
            id = "#{a}  " if a >= 100
            name_map = $data_mapinfos[a].name
            $output[a] = "#{id}#{name_map}"
          end
          a+=1
        end
      else
        Console_Commands.error
      end
      Console_Commands.output
    #---------------------------------------------------------------------------
    #Конец
    #---------------------------------------------------------------------------   
    else
      $error = ">HELP"
      Console_Commands.error
    end  
  end
end

class Debug_Text

  def self.clear_text
    create_text_bitmap if $words == nil
    if  $words.bitmap.disposed? == false
      $words.bitmap.clear_rect(0, Graphics.height - 50, Graphics.width, 90) 
    end
  end
  def self.clear_bitmap
    create_text_bitmap if $words == nil
    $words = nil
  end
  
  def self.create_text_bitmap
    $words = Sprite.new
    $words.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    
    Graphics.update
  end

  def self.draw_word(word, x, y)
    (0...word.size).each do |l|
      draw_letter(word[l].upcase, x + (16 * l), y)
    end
  end

  def self.fill_rects(*arr)
    create_text_bitmap if  $words.bitmap.disposed? 
    black = Color.new(0, 0, 0) 
    arr.each do |a|
      $words.bitmap.fill_rect(a[0]+2, a[1]+2, a[2], a[3], black)
    end
    arr.each do |a|
      color = Color.new(255, 255, 255) 
      color = a[4] if a[4] != nil
      $words.bitmap.fill_rect(a[0], a[1], a[2], a[3], color)
    end
  end
  
  def self.draw_icon(name, x, y)
    a = name.split(", ")
    i = 0
    while a[i] != nil
      p a[i]
      case a[i].upcase
      when "HP", "MP", "ATK", "DEF", "MAT", "MDF", "AGI", "LUK"; draw_letter(a[i], x + (i * 16),y)
      when "_"; draw_letter(" ", x + (i * 16),y)
      end
      i += 1
    end
  end
  
  def self.draw_letter(letter, x, y)
    create_text_bitmap if $words == nil
    case letter
    when "A", "А", "а";  fill_rects([x+4, y, 6, 2], [x+2, y+2, 4, 2], [x+8, y+2, 4, 2], [x, y+4, 4, 10], [x+10, y+4, 4, 10], [x+4, y+8, 6, 2])
    when "B", "В", "в";  fill_rects([x, y, 12, 2], [x, y+6, 12, 2], [x, y+12, 12, 2], [x, y, 4, 14], [x+10, y+2, 4, 4], [x+10, y+8, 4, 4])
    when "C", "С", "с";  fill_rects([x+4, y, 8, 2], [x+2, y+2, 4, 2], [x+10, y+2, 4, 2], [x, y+4, 4, 6], [x+4, y+12, 8, 2], [x+2, y+10, 4, 2], [x+10, y+10, 4, 2])
    when "D";       fill_rects([x, y, 4, 14], [x, y, 10, 2], [x+8, y+2, 4, 2], [x+10, y+4, 4, 6], [x+8, y+10, 4, 2], [x, y+12, 10, 2])
    when "E", "Е", "е";  fill_rects([x, y, 4, 14], [x, y, 14, 2], [x, y+12, 14, 2], [x, y+6, 12, 2])
    when "F";       fill_rects([x, y, 14, 2], [x, y, 4, 14], [x, y+6, 12, 2])
    when "G";       fill_rects([x+4, y, 10, 2], [x+2, y+2, 4, 2], [x, y+4, 4, 6], [x+2, y+10, 4, 2], [x+4, y+12, 10, 2], [x+10, y+6, 4, 6], [x+8, y+6, 2, 2])
    when "H", "Н", "н";  fill_rects([x, y, 4, 14], [x+10, y, 4, 14], [x+4, y+6, 6, 2])
    when "I";       fill_rects([x+2, y, 12, 2], [x+2, y+12, 12, 2], [x+6, y, 4, 14])
    when "J";       fill_rects([x+10, y, 4, 12], [x, y+10, 4, 2], [x+2, y+12, 10, 2])
    when "K", "К", "к";  fill_rects([x, y, 4, 14], [x+10, y, 4, 2], [x+8, y+2, 4, 2], [x+6, y+4, 4, 2], [x+4, y+6, 4, 2], [x+4, y+8, 6, 2], [x+6, y+10, 6, 2], [x+8, y+12, 6, 2])
    when "L";       fill_rects([x, y+12, 12, 2], [x, y, 4, 14])
    when "M", "М", "м";  fill_rects([x, y, 4, 14], [x+10, y, 4, 14], [x+4, y+2, 2, 4], [x+8, y+2, 2, 4], [x+6, y+4, 2, 6])
    when "N";       fill_rects([x, y, 4, 14], [x+10, y, 4, 14], [x+4, y+2, 2, 4], [x+6, y+4, 2, 4], [x+8, y+6, 2, 4])
    when "O", "О", "о";  fill_rects([x+2, y, 10, 2], [x+2, y+12, 10, 2], [x, y+2, 4, 10], [x+10, y+2, 4, 10])
    when "P", "Р", "р";  fill_rects([x, y, 4, 14], [x, y, 12, 2], [x, y+8, 12, 2], [x+10, y+2, 4, 6])
    when "Q";       fill_rects([x+2, y, 10, 2], [x, y+2, 4, 10], [x+10, y+2, 4, 8], [x+2, y+12, 8, 2], [x+2, y+12, 8, 2], [x+8, y+8, 4, 4], [x+6, y+8, 2, 2], [x+12, y+12, 2, 2])
    when "R";       fill_rects([x, y, 4, 14], [x, y, 12, 2], [x+10, y+2, 4, 6], [x+8, y+6, 6, 2], [x, y+8, 10, 2], [x+6, y+10, 6, 2], [x+8, y+12, 6, 2])
    when "S";       fill_rects([x+2, y, 10, 2], [x+2, y+6, 10, 2], [x+2, y+12, 10, 2], [x, y+2, 4, 4], [x+10, y+8, 4, 4])
    when "T", "Т", "т";  fill_rects([x+2, y, 12, 2], [x+6, y, 4, 14])  
    when "U";       fill_rects([x, y, 4, 12], [x+10, y, 4, 12], [x+2, y+12, 10, 2])
    when "V";       fill_rects([x, y, 4, 8], [x+10, y, 4, 8], [x, y+6, 6, 2], [x+8, y+6, 6, 2], [x+2, y+8, 10, 2], [x+4, y+10, 6, 2], [x+6, y+12, 2, 2])
    when "W";       fill_rects([x, y, 4, 12], [x+10, y, 4, 12], [x+2, y+12, 2, 2], [x+10, y+12, 2, 2], [x+4, y+8, 2, 4], [x+8, y+8, 2, 4], [x+6, y, 2, 10])
    when "X", "Х", "х";  fill_rects([x, y, 4, 4], [x+10, y, 4, 4], [x, y+10, 4, 4], [x+10, y+10, 4, 4], [x+2, y+4, 4, 2], [x+8, y+4, 4, 2], [x+2, y+8, 4, 2], [x+8, y+8, 4, 2], [x+4, y+6, 6, 2])
    when "Y";       fill_rects([x+2, y, 4, 6], [x+10, y, 4, 6], [x+6, y+8, 4, 6], [x+4, y+6, 8, 2])
    when "Z";       fill_rects([x, y, 14, 2], [x, y+12, 14, 2], [x+8, y+2, 6, 2], [x+6, y+4, 6, 2], [x+4, y+6, 6, 2], [x+2, y+8, 6, 2], [x, y+10, 6, 2])
      
    when "Б", "б";  fill_rects([x, y, 12, 2], [x, y+6, 12, 2], [x, y+12, 12, 2], [x, y, 4, 14], [x+10, y+8, 4, 4])
    when "Г", "г";  fill_rects([x, y, 12, 2], [x, y, 4, 14])
    when "Д", "д";  fill_rects([x+4, y, 10, 2], [x+4, y, 2, 8], [x+10, y, 4, 14], [x+2, y+8, 4, 4], [x, y+12, 4, 4], [x+12, y+12, 4, 4], [x, y+12, 14, 2])
    when "Ё", "ё";  fill_rects([x+2, y, 4, 2], [x+8, y, 4, 2], [x, y+4, 14, 2], [x, y+8, 12, 2], [x, y+12, 14, 2], [x, y+4, 4, 10])
    when "Ж", "ж";  fill_rects([x, y, 4, 4], [x, y+10, 4, 4], [x+10, y, 4, 4], [x+10, y+10, 4, 4], [x+2, y+4, 2, 2], [x+10, y+4, 2, 2], [x+2, y+8, 2, 2], [x+10, y+8, 2, 2], [x+4, y+6, 6, 2], [x+6, y, 2, 14])
    when "З", "з";  fill_rects([x+2, y, 10, 2], [x, y+2, 4, 2], [x, y+10, 4, 2], [x+10, y+2, 4, 4], [x+10, y+8, 4, 4], [x+4, y+6, 8, 2], [x+2, y+12, 10, 2])
    when "И", "и";  fill_rects([x, y, 4, 14], [x+10, y, 4, 14], [x+8, y+4, 2, 4], [x+6, y+6, 2, 4], [x+4, y+8, 2, 4])
    when "Й", "й";  fill_rects([x+2, y, 10, 2], [x, y+4, 4, 10], [x+10, y+4, 4, 10], [x+8, y+6, 2, 4], [x+6, y+8, 2, 4], [x+4, y+10, 2, 4])
    when "Л", "л";  fill_rects([x+4, y, 10, 2], [x+4, y, 2, 12], [x+2, y+8, 4, 4], [x, y+10, 4, 4], [x+10, y, 4, 14])
    when "П", "п";  fill_rects([x, y, 4, 14], [x+10, y, 4, 14], [x+4, y, 6, 2])
    when "У", "у";  fill_rects([x, y, 4, 6],  [x+10, y, 4, 12],  [x+2, y+6, 10, 2], [x+2, y+12, 10, 2], [x, y+10, 4, 2])
    when "Ф", "ф";  fill_rects([x, y+4, 4, 6], [x+10, y+4, 4, 6], [x+2, y+2, 10, 2], [x+2, y+10, 10, 2], [x+6, y, 2, 14])
    when "Ц", "ц";  fill_rects([x, y, 4, 14], [x+8, y, 4, 14], [x, y+12, 14, 2], [x+10, y+12, 4, 4])
    when "Ч", "ч";  fill_rects([x, y, 4, 6],  [x+10, y, 4, 14],  [x+2, y+6, 10, 2])
    when "Ш", "ш";  fill_rects([x, y, 4, 14], [x+10, y, 4, 14], [x+6, y, 2, 14], [x, y+12, 14, 2])
    when "Щ", "щ";  fill_rects([x, y, 4, 14], [x+10, y, 4, 14], [x+6, y, 2, 14], [x, y+12, 14, 2], [x+12, y+12, 4, 4])
    when "Ъ", "ъ";  fill_rects([x, y, 6, 2], [x+2, y, 4, 14], [x+2, y+4, 10, 2], [x+2, y+12, 10, 2], [x+10, y+6, 4, 6])
    when "Ы", "ы";  fill_rects([x, y, 4, 14], [x, y+4, 8, 2],  [x, y+12, 8, 2], [x+6, y+6, 4, 6], [x+10, y, 4, 6], [x+12, y+6, 2, 6], [x+10, y+12, 4, 2])
    when "Ь", "ь";  fill_rects([x, y+4, 12, 2], [x, y+12, 12, 2], [x, y, 4, 14], [x+10, y+6, 4, 6])
    when "Э", "э";  fill_rects([x+2, y, 8, 2], [x, y+2, 4, 2], [x+8, y+2, 4, 2], [x+2, y+6, 12, 2], [x+10, y+4, 4, 6], [x+2, y+12, 8, 2], [x, y+10, 4, 2], [x+8, y+10, 4, 2])
    when "Ю", "ю";  fill_rects([x, y, 2, 14], [x+6, y, 6, 2], [x, y+6, 6, 2], [x+6, y+12, 6, 2], [x+4, y+2, 4, 10], [x+10, y+2, 4, 10])
    when "Я", "я";  fill_rects([x+2, y, 12, 2], [x, y+2, 4, 6], [x, y+6, 6, 2], [x+10, y, 4, 14], [x+4, y+8, 6, 2], [x+2, y+10, 4, 2], [x, y+12, 6, 2])
      
    when "0";       fill_rects([x+4, y, 6, 2], [x+2, y+2, 2, 2], [x+8, y+2, 4, 2], [x, y+4, 4, 6], [x+10, y+4, 4, 6], [x+2, y+10, 4, 2], [x+10, y+10, 2, 2], [x+4, y+12, 6, 2])
    when "1";       fill_rects([x+6, y, 4, 14], [x+4, y+2, 2, 2], [x+2, y+12, 12, 2])
    when "2";       fill_rects([x+2, y, 10, 2], [x, y+2, 4, 2], [x+10, y+2, 4, 2], [x+8, y+4, 6, 2], [x+4, y+6, 8, 2], [x+2, y+8, 8, 2], [x, y+10, 6, 2], [x, y+12, 14, 2])
    when "3";       fill_rects([x+2, y, 12, 2], [x+8, y+2, 4, 2], [x+6, y+4, 4, 2], [x+4, y+6, 8, 2], [x, y+10, 4, 2], [x+10, y+8, 4, 4], [x+2, y+12, 10, 2])
    when "4";       fill_rects([x+6, y, 6, 2], [x+4, y+2, 6, 2], [x+8, y, 4, 14], [x+2, y+4, 4, 2], [x, y+6, 4, 2], [x, y+8, 14, 2])
    when "5";       fill_rects([x, y, 12, 2], [x, y, 4, 6], [x, y+4, 12, 2], [x+10, y+6, 4, 6], [x+2, y+12, 10, 2], [x, y+10, 4, 2])
    when "6";       fill_rects([x+4, y, 8, 2], [x+2, y+2, 4, 2], [x, y+4, 4, 8], [x, y+6, 12, 2], [x+10, y+8, 4, 4], [x+2, y+12, 10, 2])
    when "7";       fill_rects([x, y, 4, 4], [x+10, y, 4, 4], [x+4, y+8, 4, 6], [x+4, y, 6, 2], [x+8, y+4, 4, 2], [x+6, y+6, 4, 2])
    when "8";       fill_rects([x+2, y, 8, 2], [x+10, y+2, 2, 4], [x, y+2, 4, 4], [x+2, y+4, 4, 4], [x+6, y+6, 4, 4], [x+10, y+8, 4, 4], [x, y+8, 2, 4], [x+2, y+12, 10, 2])
    when "9";       fill_rects([x+2, y, 10, 2], [x, y+2, 4, 4], [x+10, y+2, 4, 8], [x+2, y+6, 10, 2], [x+2, y+12, 8, 2], [x+8, y+10, 4, 2], [x+10, y+8, 4, 2])
    when "<";       fill_rects([x+8, y, 4, 2], [x+6, y+2, 4, 2], [x+4, y+4, 4, 2], [x+2, y+6, 4, 2], [x+4, y+8, 4, 2], [x+6, y+10, 4, 2], [x+8, y+12, 4, 2])
    when ">";       fill_rects([x+2, y, 4, 2], [x+4, y+2, 4, 2], [x+6, y+4, 4, 2], [x+8, y+6, 4, 2], [x+6, y+8, 4, 2], [x+4, y+10, 4, 2], [x+2, y+12, 4, 2])
    when "+";       fill_rects([x+6, y+2, 4, 10], [x+2, y+6, 10, 2])
    when "-";       fill_rects([x+2, y+6, 10, 2])
    when "_";       fill_rects([x+2, y+12, 10, 2])
    when "|";       fill_rects([x+6, y, 4, 14])
    when "=";       fill_rects([x, y+4, 14, 2], [x, y+8, 14, 2])
    when "(";       fill_rects([x+8, y, 4, 2], [x+6, y+2, 4, 2], [x+4, y+4, 4, 6], [x+6, y+10, 4, 2], [x+8, y+12, 4, 2])
    when ")";       fill_rects([x+2, y, 4, 2], [x+4, y+2, 4, 2], [x+6, y+4, 4, 6], [x+4, y+10, 4, 2], [x+2, y+12, 4, 2])
    when "?";       fill_rects([x, y+2, 4, 4], [x+2, y, 10, 4], [x+10, y+2, 4, 4], [x+8, y+6, 4, 2], [x+4, y+8, 6, 2], [x+4, y+12, 6, 2])
    when "!";       fill_rects([x+4, y, 6, 6], [x+4, y, 4, 10], [x+4, y+12, 4, 2])
    when ":";       fill_rects([x+4, y+2, 4, 4], [x+4, y+8, 4, 4])
    when "/";       fill_rects([x, y+12, 2, 2],[x+2, y+10, 2, 2], [x+4, y+8, 2, 2], [x+6, y+6, 2, 2], [x+8, y+4, 2, 2], [x+10, y+2, 2, 2], [x+12, y, 2, 2])
    when ".";       fill_rects([x+4, y+10, 4, 4])
    when ",";       fill_rects([x+4, y+10, 4, 4], [x+2, y+14, 4, 2])
    when "~";       fill_rects([x, y+6, 2, 2], [x+2, y+4, 6, 2], [x+4, y+6, 6, 2], [x+6, y+8, 6, 2], [x+12, y+6, 2, 2])
#~        
    when "HP";      fill_rects([x+2, y, 4, 10, Color.new(255, 0, 0)], [x+8, y, 4, 10, Color.new(255, 0, 0)], [x, y+2, 14, 6, Color.new(255, 0, 0)], [x+4, y+8, 6, 4, Color.new(255, 0, 0)], [x+6, y+12, 2, 2, Color.new(255, 0, 0)], [x+2, y+2, 2, 2])
    when "MP";      fill_rects([x+2, y, 10, 2], [x+4, y+2, 6, 12, Color.new(0, 148, 255)], [x+2, y+6, 10, 8, Color.new(0, 148, 255)], [x, y+8, 14, 4, Color.new(0, 148, 255)], [x+2, y+8, 2, 2], [x+6, y+2, 2, 2])
    when "ATK";     fill_rects([x+10, y, 4, 4, Color.new(128, 128, 128)], [x+8, y+2, 4, 4, Color.new(128, 128, 128)], [x+6, y+4, 4, 4, Color.new(128, 128, 128)], [x+4, y+6, 4, 4, Color.new(128, 128, 128)], [x+10, y, 2, 2], [x+8, y+2, 2, 2], [x+6, y+4, 2, 2], [x+4, y+6, 2, 2], [x, y+10, 4, 4, Color.new(127, 51, 0)], [x+2, y+4, 2, 6, Color.new(63, 63, 63)], [x+4, y+10, 6, 2, Color.new(63, 63, 63)])
    when "DEF";     fill_rects([x+2, y+2, 10, 8, Color.new(128, 128, 128)], [x+4, y+8, 6, 4, Color.new(128, 128, 128)], [x+4, y, 6, 2, Color.new(63, 63, 63)], [x, y+2, 4, 2, Color.new(63, 63, 63)], [x+10, y+2, 4, 2, Color.new(63, 63, 63)], [x, y+2, 2, 6, Color.new(63, 63, 63)], [x+12, y+2, 2, 6, Color.new(63, 63, 63)], [x+2, y+8, 2, 2, Color.new(63, 63, 63)], [x+4, y+10, 2, 2, Color.new(63, 63, 63)], [x+6, y+12, 2, 2, Color.new(63, 63, 63)], [x+8, y+10, 2, 2, Color.new(63, 63, 63)], [x+10, y+8, 2, 2, Color.new(63, 63, 63)], [x+4, y+2, 2, 4])
    when "MAT";     fill_rects([x+12, y, 2, 2],[x+4, y+2, 2, 2],[x+10, y+8, 2, 2],[x, y+12, 2, 2, Color.new(216, 86, 0)], [x+2, y+10, 2, 2, Color.new(216, 86, 0)], [x+4, y+8, 2, 2, Color.new(216, 86, 0)], [x+6, y+6, 2, 2, Color.new(216, 86, 0)], [x+8, y+4, 2, 2, Color.new(216, 86, 0)], [x+8, y, 2, 2, Color.new(216, 86, 0)], [x+6, y, 2, 2, Color.new(127, 51, 0)], [x+10, y+2, 2, 2, Color.new(127, 51, 0)], [x+8, y+6, 2, 2, Color.new(127, 51, 0)], [x+6, y+8, 2, 2, Color.new(127, 51, 0)], [x+4, y+10, 2, 2, Color.new(127, 51, 0)], [x+2, y+12, 2, 2, Color.new(127, 51, 0)])
    when "MDF";     fill_rects([x+2, y+2, 10, 8, Color.new(255, 0, 220)], [x+4, y+8, 6, 4, Color.new(255, 0, 220)], [x+4, y, 6, 2, Color.new(120, 0, 175)], [x, y+2, 4, 2, Color.new(120, 0, 175)], [x+10, y+2, 4, 2, Color.new(120, 0, 175)], [x, y+2, 2, 6, Color.new(120, 0, 175)], [x+12, y+2, 2, 6, Color.new(120, 0, 175)], [x+2, y+8, 2, 2, Color.new(120, 0, 175)], [x+4, y+10, 2, 2, Color.new(120, 0, 175)], [x+6, y+12, 2, 2, Color.new(120, 0, 175)], [x+8, y+10, 2, 2, Color.new(120, 0, 175)], [x+10, y+8, 2, 2, Color.new(120, 0, 175)], [x+4, y+2, 2, 4])
    when "LUK";     fill_rects([x, y, 6, 2, Color.new(255, 216, 0)], [x+8, y, 6, 2, Color.new(255, 216, 0)], [x+4, y+12, 6, 2, Color.new(255, 216, 0)], [x+2, y+10, 10, 2, Color.new(255, 216, 0)], [x+2, y, 4, 4, Color.new(255, 216, 0)], [x+8, y, 4, 4, Color.new(255, 216, 0)], [x, y+4, 4, 6, Color.new(255, 216, 0)], [x+10, y+4, 4, 6, Color.new(255, 216, 0)])
    when "AGI";     fill_rects([x+8, y, 2, 10, Color.new(128, 128, 128)], [x+6, y+2, 6, 2, Color.new(128, 128, 128)], [x+4, y+6, 10, 2, Color.new(128, 128, 128)], [x+6, y+10, 2, 4, Color.new(128, 128, 128)], [x+10, y+10, 2, 4, Color.new(128, 128, 128)], [x, y+2, 4, 2], [x, y+10, 4, 2], [x, y+6, 2, 2])
      
    end
  end
end
