
$imported = {} if $imported.nil?
$imported["Z_Autosave_Script"] = true

$select = nil
$autosave_options = [false, false]
class Scene_Title < Scene_Base
  def create_command_window
    @command_window = Window_TitleCommand.new
    @command_window.set_handler(:new_game, method(:command_new_game))
    @command_window.set_handler(:continue, method(:command_continue))
    @command_window.set_handler(:autosave, method(:command_autosaveoptions))
    @command_window.set_handler(:shutdown, method(:command_shutdown))

  end
  def command_autosaveoptions
    close_command_window
    SceneManager.call(Scene_Autosave_Options)
  end
end
class Window_TitleCommand < Window_Command
    def make_command_list
    add_command(Vocab::new_game, :new_game)
    add_command(Vocab::continue, :continue, continue_enabled)
    add_command("Autosave options", :autosave)
    add_command(Vocab::shutdown, :shutdown)
  end
end

class Window_AutosaveOption < Window_Command
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0)
    update_placement
    select_symbol($select) if $select != nil
    self.openness = 0
    open
  end
  #--------------------------------------------------------------------------
  # * Get Window Width
  #--------------------------------------------------------------------------
  def window_width
    return 300
  end
  #--------------------------------------------------------------------------
  # * Update Window Position
  #--------------------------------------------------------------------------
  def update_placement
    self.x = (Graphics.width - width) / 2
    self.y = (Graphics.height - height) / 2
  end
  #--------------------------------------------------------------------------
  # * Create Command List
  #--------------------------------------------------------------------------
  def make_command_list
    $autosave_options[0] == false ? auto = "Timer autosave disabled" : auto = "Save game every: #{$autosave_options[0]} min"
    $autosave_options[1] == false ? autho = "disabled" : autho = "enabled"
    add_command(auto, :timer_as)
    add_command("Moving autosave #{autho}", :move_as)
    add_command("Reset options", :reset_options)
    add_command("Back to menu", :return_to_menu)
  end
end


class Scene_Autosave_Options < Scene_MenuBase
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    Graphics.freeze
    create_background
    create_foreground
    create_command_window
  end
  #--------------------------------------------------------------------------
  # * Get Transition Speed
  #--------------------------------------------------------------------------
  def transition_speed
    return 20
  end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    SceneManager.snapshot_for_background
    dispose_background
    dispose_foreground
  end
  #--------------------------------------------------------------------------
  # * Create Background
  #--------------------------------------------------------------------------
  def create_background
    @sprite1 = Sprite.new
    @sprite1.bitmap = Cache.title1($data_system.title1_name)
    @sprite2 = Sprite.new
    @sprite2.bitmap = Cache.title2($data_system.title2_name)
    center_sprite(@sprite1)
    center_sprite(@sprite2)
  end
  #--------------------------------------------------------------------------
  # * Create Foreground
  #--------------------------------------------------------------------------
  def create_foreground
    @foreground_sprite = Sprite.new
    @foreground_sprite.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @foreground_sprite.z = 100
    draw_game_title if $data_system.opt_draw_title
  end
  #--------------------------------------------------------------------------
  # * Draw Game Title
  #--------------------------------------------------------------------------
  def draw_game_title
    @foreground_sprite.bitmap.font.size = 48
    rect = Rect.new(0, 0, Graphics.width, Graphics.height / 2)
    @foreground_sprite.bitmap.draw_text(rect, $data_system.game_title, 1)
  end
  #--------------------------------------------------------------------------
  # * Free Background
  #--------------------------------------------------------------------------
  def dispose_background
    @sprite1.bitmap.dispose
    @sprite1.dispose
    @sprite2.bitmap.dispose
    @sprite2.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Foreground
  #--------------------------------------------------------------------------
  def dispose_foreground
    @foreground_sprite.bitmap.dispose
    @foreground_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # * Move Sprite to Screen Center
  #--------------------------------------------------------------------------
  def center_sprite(sprite)
    sprite.ox = sprite.bitmap.width / 2
    sprite.oy = sprite.bitmap.height / 2
    sprite.x = Graphics.width / 2
    sprite.y = Graphics.height / 2
  end
  #--------------------------------------------------------------------------
  # * Create Command Window
  #--------------------------------------------------------------------------
  def create_command_window
    @command_window = Window_AutosaveOption.new
    @command_window.set_handler(:timer_as,       method(:command_timer))
    @command_window.set_handler(:move_as,        method(:command_move))
    @command_window.set_handler(:reset_options,  method(:command_reset))
    @command_window.set_handler(:return_to_menu, method(:command_return))
    @command_window.set_handler(:cancel,   method(:return_scene))
  end
  #--------------------------------------------------------------------------
  # * Close Command Window
  #--------------------------------------------------------------------------
  def close_command_window
    @command_window.close
    update until @command_window.close?
  end
  #--------------------------------------------------------------------------
  # * [New Game] Command
  #--------------------------------------------------------------------------
  def command_timer
    if $autosave_options[0] == false
      $autosave_options[0] = 1
    else
      if Input.press?(:LEFT)
        if $autosave_options[0] <= 1
          $autosave_options[0] = false
        else
          $autosave_options[0] -= 1
        end
      else
        if $autosave_options[0] >= 10
          $autosave_options[0] = false
        else
          $autosave_options[0] += 1
        end
      end
    end
    $select = :timer_as
    SceneManager.goto(Scene_Autosave_Options)
  end
  #--------------------------------------------------------------------------
  # * [Continue] Command
  #--------------------------------------------------------------------------
  def command_move
    if $autosave_options[1] == false
      $autosave_options[1] = true
    else
      $autosave_options[1] = false
    end
    $select = :move_as
    SceneManager.goto(Scene_Autosave_Options)
  end
  #--------------------------------------------------------------------------
  # * [Shut Down] Command
  #--------------------------------------------------------------------------
  def command_reset
    $autosave_options = [false, false]
    $select = nil
    SceneManager.goto(Scene_Autosave_Options)
  end
  #--------------------------------------------------------------------------
  # * Exit
  #--------------------------------------------------------------------------
  def command_return
    SceneManager.goto(Scene_Title)
  end
end


class AutoSave
  $auto_save_enabled = true        #Автосохранение [ВКЛ/ВЫКЛ]
  Index_TimerAutoSave = 15
  Index_MoveAutoSave = 14
  
  def self.start_autosave
    if $autosave_options[0] != false
      if $autosave_options[0] == 1
        time = $game_system.playtime_s.split(":")[2].to_i
        if time == 59
          if $saved == false
            DataManager.save_game(Index_TimerAutoSave)
            puts "Идет авто-сохранение"
            Graphics.wait(10)
            $saved = true
          end
        else
          $saved = false
        end
      elsif $autosave_options[0] > 1
        time1 = $game_system.playtime_s.split(":")[1].to_i
        time2 = $game_system.playtime_s.split(":")[2].to_i
        if time1 % $autosave_options[0] == 0 and time2 = 0
          if $saved == false
            DataManager.save_game(Index_TimerAutoSave)
            puts "Идет авто-сохранение"
            Graphics.wait(10)
            $saved = true
          end
        else
          $saved = false
        end
      end
    end
  end
  def self.start_movesave
    if $autosave_options[1] == true
      DataManager.save_game(Index_MoveAutoSave)
      puts "Идет авто-сохранение"
      Graphics.wait(10)
    end
  end
end

class Game_Player < Game_Character
  def perform_transfer
    if transfer?
      set_direction(@new_direction)
      if @new_map_id != $game_map.map_id
        $game_map.setup(@new_map_id)
        $game_map.autoplay
      end
      moveto(@new_x, @new_y)
      clear_transfer_info
      AutoSave.start_movesave
    end
  end
end

class Scene_Base
  alias auto_save update
  def update
    auto_save
    if $auto_save_enabled
      if SceneManager.scene.to_s.include?("Scene_Map")
        AutoSave.start_autosave       
      end
    end
  end
end

class Window_FileList < Window_Selectable
  def draw_item(index)
    if index == AutoSave::Index_TimerAutoSave 
      file = YEA::SAVE::SLOT_NAME
      file = "TimerSave" if $autosave_options[0] != false
    elsif index == AutoSave::Index_MoveAutoSave   
      file = YEA::SAVE::SLOT_NAME
      file = "MoveSave" if $autosave_options[1] != false
    else
      file = YEA::SAVE::SLOT_NAME
    end
    header = DataManager.load_header(index)
    enabled = !header.nil?
    rect = item_rect(index)
    rect.width -= 4
    $dave_index = index
    draw_icon(save_icon?(header), rect.x, rect.y, enabled)
    change_color(normal_color, enabled)
    text = sprintf(file, (index + 1).group)
    draw_text(rect.x+24, rect.y, rect.width-24, line_height, text)
  end
end

class Window_SaveFile < Window_Base
  def refresh
    contents.clear
    change_color(normal_color)
    if @file_index == AutoSave::Index_TimerAutoSave 
      name = Vocab::File + " #{@file_index + 1}"
      name = "TimerSave" if $autosave_options[0] != false
    elsif @file_index == AutoSave::Index_MoveAutoSave 
      name = Vocab::File + " #{@file_index + 1}"
      name = "MoveSave" if $autosave_options[1] != false
    else
      name = Vocab::File + " #{@file_index + 1}"
    end
    draw_text(4, 0, 200, line_height, name)
    @name_width = text_size(name).width
    draw_party_characters(152, 58)
    draw_playtime(0, contents.height - line_height, contents.width - 4, 2)
  end
end

