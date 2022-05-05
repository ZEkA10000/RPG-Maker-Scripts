#SimplePopUp for items 
# script by: ZEkA10000
# create date: 14-jul-2018
# updated: 21-jan-2019

#Description:
#This scpipt creates window and shows added items from chests

#Updates 0.1: 
#Window can show more that 1 item

#Updates 0.2: 
#Added window animation
#Fixed error with Yanfly Party System

#Updates 0.3: 
#Added message "You found:
#Added window styles
#Fixed disposed bitmap for window styles

#How to instal:
#Just copy this script into ▼ Materials

#Copyright for using. 
#If you use it, don't forget to indicate that I am the author of this scpript in your game.

class Simple_Popup
  
  #more than 11 items
  MOR_STU      = "And more..." 
  #found message | "" for don't using that message
  FOUNDED      = "You founded:" 
  
  MOR_STU_ICON = 261 #RTP bag icon 
  SHOWING_TIME = 60  #60 Frames
  
  # TURN ON showing window
  POP_UP_ON    = true
  
  # RTP Money icon
  MONEY        = 361
  
  VARIABLE_FOR_STYLE = 1 
  # Variable = 0 default window 
  # Variable = 1 custom shadowed window 
  # Variable = 2 without window
  
  
  def self.shadow_back
    shadowskin = Bitmap.new(128, 128)
    shadowskin.fill_rect(0, 0, 64, 64, Color.new(0, 0, 0, 160))
    shadowskin.gradient_fill_rect(0, 0,  64, 12, Color.new(0, 0, 0, 0),   Color.new(0, 0, 0, 160), true)
    shadowskin.gradient_fill_rect(0, 52, 64, 12, Color.new(0, 0, 0, 160), Color.new(0, 0, 0, 0),   true)
    shadowskin.fill_rect(64, 96, 8, 8, Color.new(255, 255, 255, 255))
    return shadowskin
  end
  
  def self.nograf
    shadowskin = Bitmap.new(128, 128)
    shadowskin.fill_rect(64, 96, 8, 8, Color.new(255, 255, 255, 255))
    return shadowskin
  end
  
  def self.show_items(item, amount)
    dont_add = false
    if POP_UP_ON
      $names = [] if $names == nil
      $disposetime = [] if $disposetime == nil
      $icons_index = [] if $icons_index == nil
      $name_sizes = [] if $name_sizes == nil
      
      $my_message.dispose if $my_message != nil 
      f_s = 8
      if item == nil 
        n = " " 
        visibility = false
        i_ind = 0
      else
        if item.class == Fixnum 
          n = "x#{amount}" 
          i_ind = item
        else
          n = " #{item.name} x#{amount}"
          i_ind = item.icon_index
        end
        visibility = true
      end
      if $disposetime.size >= 11
        $names.shift
        $disposetime.shift
        $icons_index.shift
        $name_sizes.shift
      end
      $names.push(n) if n != " "
      $icons_index.push(i_ind) if i_ind != 0
      $disposetime[0] == 0 ? $disposetime[0] = Simple_Popup::SHOWING_TIME : $disposetime.push(Simple_Popup::SHOWING_TIME)
      $names.each { |nm| $name_sizes.push(nm.size) }
      sz = $names.size
      sz = 11 if $names.size > 11
      
      if visibility == true
        @w = 32 + 30 + (f_s * $name_sizes.max) + n.size
        @h = 32 + (24 * sz)
        @x = $game_player.screen_x - @w / 2
        @x = 0 if @x < 0
        if @x + @w > Graphics.width
          x = @x
          w = @w
          while x + w > Graphics.width
            x -= 1
          end
          @x = x
        end 
        @y = $game_player.screen_y - @h - 32
        @y = $game_player.screen_y if $game_player.screen_y < 64
        if @y < 0
          @y = 0 
          @x = $game_player.screen_x + 16 
          @x = $game_player.screen_x - 16 - @w if @x + @w > Graphics.width
        end
        $my_message = Window_Base.new(@x, @y, @w, @h)
        $my_message.openness = 0
        $my_message.open
        if $game_variables[Simple_Popup::VARIABLE_FOR_STYLE] == 1; $my_message.windowskin = shadow_back; end
        if $game_variables[Simple_Popup::VARIABLE_FOR_STYLE] == 2; $my_message.windowskin = nograf; end
        $my_message.visible = visibility
        (0..10).each do |i|
          if $names != nil
            if $names[i] != nil
              if i == 0 and sz == 11
                out_name = MOR_STU
                out_icon = MOR_STU_ICON
              else 
                if Simple_Popup::FOUNDED != ""
                  if $names[0] != Simple_Popup::FOUNDED
                    $names.unshift(Simple_Popup::FOUNDED)
                    $disposetime.unshift(Simple_Popup::SHOWING_TIME)
                    $icons_index.unshift(0)
                    $name_sizes.unshift(Simple_Popup::FOUNDED.size)
                  end
                end
                out_name = $names[i]
                out_icon = $icons_index[i]
              end
              $my_message.draw_icon(out_icon, 0, 24 * i)
              $my_message.draw_currency_value2(out_name, "", 0, 24 * i, @w - 24)
            end
          end
        end
      end
    end
  end
end
class Scene_Base
  alias dispose_update update
  def update
    if SceneManager.scene_is?(Scene_Title)
      $my_message = nil if $my_message != nil
    end
    if Simple_Popup::POP_UP_ON
      $my_message.update if $my_message != nil
      if $disposetime != nil
        if $disposetime.index(nil) != nil
          $disposetime.compact!  
        end
        if $disposetime.max != nil
          if $disposetime.max > 0
            $disposetime.collect! { |x| x -= 1 if x > 0}
          elsif $disposetime.max == 0
            $my_message.close if $my_message != nil
            $names = []
            $icons_index = []
            $name_sizes = []
            $disposetime = []
          end
        end
      end
    end
    dispose_update
  end
end

#==============================================================================
# ** Window_Base
#------------------------------------------------------------------------------
#  This is a super class of all windows within the game.
#==============================================================================

class Window_Base < Window
  def draw_currency_value2(value, unit, x, y, width)
    cx = text_size(unit).width
    change_color(normal_color)
    draw_text(x, y, width - cx - 2, line_height, value, 2)
    change_color(system_color)
    draw_text(x, y, width, line_height, unit, 2)
  end
end
class Game_Interpreter
  #--------------------------------------------------------------------------
  # * Change Gold
  #--------------------------------------------------------------------------
  def command_125
    value = operate_value(@params[0], @params[1], @params[2])
    Simple_Popup.show_items(Simple_Popup::MONEY, value)
    $game_party.gain_gold(value)
  end
  #--------------------------------------------------------------------------
  # * Change Items
  #--------------------------------------------------------------------------
  def command_126
    value = operate_value(@params[1], @params[2], @params[3])
    Simple_Popup.show_items($data_items[@params[0]], value)
    $game_party.gain_item($data_items[@params[0]], value)
  end
  #--------------------------------------------------------------------------
  # * Change Weapons
  #--------------------------------------------------------------------------
  def command_127
    value = operate_value(@params[1], @params[2], @params[3])
    Simple_Popup.show_items($data_weapons[@params[0]], value)
    $game_party.gain_item($data_weapons[@params[0]], value, @params[4])
  end
  #--------------------------------------------------------------------------
  # * Change Armor
  #--------------------------------------------------------------------------
  def command_128
    value = operate_value(@params[1], @params[2], @params[3])
    Simple_Popup.show_items($data_armors[@params[0]], value)
    $game_party.gain_item($data_armors[@params[0]], value, @params[4])
  end
end
