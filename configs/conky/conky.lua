function string:split( inSplitPattern, outResults )
  if not outResults then
    outResults = { }
  end
  local theStart = 1
  local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  while theSplitStart do
    table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
    theStart = theSplitEnd + 1
    theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  end
  table.insert( outResults, string.sub( self, theStart ) )
  return outResults
end

function conky_i3_battery()
  local battery_info = conky_parse("${battery_short BAT0}"):split(" ")
  local battery_percent = tonumber(conky_parse("${battery_percent BAT0}"))
  icon = ""
  color = ""

  if battery_info[1] == "D" then
    if battery_percent < 20 then
      icon = ""
      color = "red"
    elseif battery_percent < 40 then
      icon = ""
      color = "red"
    elseif battery_percent < 60 then
      icon = ""
      color = "blue"
    elseif battery_percent < 80 then
      icon = ""
      color = "\\#06AD00"
    else
      icon = ""
      color = "\\#06AD00"
    end
  elseif battery_info[1] == "C" then
    icon = ""
    color = "\\#0097C9"
  else
    return '{"full_text":"","color":"\\#C1C1C1", "interval":1,"border":"\\#C1C1C1","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},'
  end
  return string.format('{ "full_text": "%s %s%% (ETA: %s)", "interval": 1, "color": "%s","border":"%s","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},',icon , battery_percent,conky_parse("${battery_time}"),color,color);

end

function conky_i3_wifi()
  local wifi_status = tonumber(conky_parse("${if_up enp6s0}1${endif}"))
  if wifi_status == 1 then
    return string.format('{"full_text":"  %s","interval":2,"color":"\\#C1C1C1","border":"\\#C1C1C1","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},',conky_parse("${addr enp6s0}"));
  else
    return '{"full_text":"","interval":2,"color":"\\#DEDB23","border":"\\#DEDB23","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},';
  end
end


function conky_i3_lan()
  local lan_status = tonumber(conky_parse("${if_up eth0}1${endif}"))
  if lan_status == 1 then
    local ssid = conky_parse("${wireless_essid wlan0}");

    return string.format('{"full_text":" %s","interval":2,"color":"\\#0097C9","border":"\\#0097C9","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},',conky_parse("${addr eth0}"));
  else
    return '{"full_text":"","interval":2,"color":"\\#DEDB23","border":"\\#DEDB23","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},';
  end
end

function conky_i3_volume()
  local volume_string = string.gsub(conky_parse("${exec ~/.config/i3/conky-volume}"),"%%","");
  local volume = tonumber(volume_string)
  if volume == 0 then
    color = "red"
  else
    color = "\\#C1C1C1"
  end
  return string.format('{ "full_text": " %s","interval":1,"color":"%s","border":"%s","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},',volume,color,color)
end

function conky_i3_ram()
  local percentage = tonumber(conky_parse("${memperc}"))
  if percentage > 80 then
    color = "red"
  elseif percentage > 70 then
    color = "\\#DEDB23"
  else
    color = "\\#C1C1C1"
  end

  return string.format('{"full_text":"RAM %s%%","interval":1,"color":"%s","border":"%s","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},',percentage,color,color)
end

function conky_i3_cpu()
  local percentage = tonumber(conky_parse("${cpu cpu0}"))
  if percentage > 80 then
    color = "red"
  elseif percentage > 50 then
    color = "\\#DEDB23"
  else
    color = "\\#C1C1C1"
  end

  return string.format('{"full_text":" %s%%","interval":1,"color":"%s","border":"%s","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},',percentage,color,color)
end

function conky_i3_keyboard_lid()
  local lid = tonumber(conky_parse("${exec cat /sys/class/leds/asus::kbd_backlight/brightness}"))
  if lid then
    return string.format('{"full_text":" %s","interval":"1","color":"\\#C1C1C1","border":"\\#C1C1C1","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},',lid)
  else
    return '{"full_text":"","interval":"1","color":"\\#DEDB23","border":"\\#DEDB23","border_bottom":0,"border_left":0,"border_right":0,"border_top":2},'
  end
end
