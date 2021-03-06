local main_menu = {}

function main_menu.init()
  if menu == 1 then
    screen.move(0,10)
    screen.text("cheat codes")
    screen.move(10,30)
    for i = 1,7 do
      screen.level(page.main_sel == i and 15 or 3)
      if i < 4 then
        screen.move(10,20+(10*i))
      elseif i < 7 then
        screen.move(60,10*(i-1))
      elseif i == 7 then
        screen.move(118,64)
      end
      local selected = {"[ loops ]", "[ levels ]", "[ panning ]", "[ filters ]", "[ delay ]", "[ timing ]", "[?]"}
      local unselected = {"loops", "levels", "panning", "filters", "delay", "timing", " ? "}
      if page.main_sel == i then
        screen.text(selected[i])
      else
        screen.text(unselected[i])
      end
    end
  elseif menu == 2 then
    screen.move(0,10)
    screen.level(3)
    screen.text("loops")
    if key1_hold then
      if page.loops_sel < 3 and bank[page.loops_sel+1].id == 16 and grid.alt == 0 then
        screen.move(0,20)
        screen.level(6)
        screen.text("(pad 16 overwrites bank!)")
      end
      if grid.alt == 1 then
        screen.move(0,20)
        screen.level(6)
        screen.text("(grid-ALT sets offset for all)")
      end
      for i = 1,3 do
        screen.move(0,20+(i*10))
        screen.level(page.loops_sel == i-1 and 15 or 3)
        if grid.alt == 0 then
          local loops_to_screen_options = {"a", "b", "c"}
          screen.text(loops_to_screen_options[i]..""..bank[i].id)
        else
          local loops_to_screen_options = {"(a)","(b)","(c)"}
          screen.text(loops_to_screen_options[i])
        end
        screen.move(20,20+(i*10))
        screen.text((bank[i][bank[i].id].mode == 1 and "Live" or "Clip")..":")
        screen.move(40,20+(i*10))
        screen.text(bank[i][bank[i].id].clip)
        screen.move(55,20+(i*10))
        screen.text("offset: "..string.format("%.0f",((math.log(bank[i][bank[i].id].offset)/math.log(0.5))*-12)).." st")
      end
      screen.level(page.loops_sel == 3 and 15 or 3)
      screen.move(0,60)
      screen.text("L"..rec.clip)
      screen.move(20,60)
      screen.text(rec.state == 1 and "recording" or "not recording")
      screen.move(88,60)
      local rate_options = {"8 s","16 s","32 s"}
      screen.text(rate_options[params:get"live_buff_rate"])
      screen.move(111,60)
      screen.level(3)
      screen.text(string.format("%0.f",util.linlin(rec.start_point-(8*(rec.clip-1)),rec.end_point-(8*(rec.clip-1)),0,100,(poll_position_new[1] - (8*(rec.clip-1))))).."%")
    else
      screen.line_width(1)
      for i = 1,3 do
        screen.move(0,10+(i*15))
        screen.level(page.loops_sel == i-1 and 15 or 3)
        local loops_to_screen_options = {"a", "b", "c"}
        screen.text(loops_to_screen_options[i]..""..bank[i].id)
        screen.move(15,10+(i*15))
        screen.line(120,10+(i*15))
        screen.close()
        screen.stroke()
      end
      for i = 1,3 do
        screen.level(page.loops_sel == i-1 and 15 or 3)
        local start_to_screen = util.linlin(1,9,15,120,(bank[i][bank[i].id].start_point - (8*(bank[i][bank[i].id].clip-1))))
        screen.move(start_to_screen,24+(15*(i-1)))
        screen.text("|")
        local end_to_screen = util.linlin(1,9,15,120,bank[i][bank[i].id].end_point - (8*(bank[i][bank[i].id].clip-1)))
        screen.move(end_to_screen,30+(15*(i-1)))
        screen.text("|")
        local current_to_screen = util.linlin(1,9,15,120,(poll_position_new[i+1] - (8*(bank[i][bank[i].id].clip-1))))
        screen.move(current_to_screen,27+(15*(i-1)))
        screen.text("|")
      end
      screen.level(page.loops_sel == 3 and 15 or 3)
      local recording_playhead = util.linlin(1,9,15,120,(poll_position_new[1] - (8*(rec.clip-1))))
      if rec.state == 1 then
        screen.move(recording_playhead,64)
        screen.text(".")
      elseif rec.state == 0 then
        screen.move(recording_playhead,67)
        screen.text_center("||")
      end
      local recording_start = util.linlin(1,9,15,120,(rec.start_point - (8*(rec.clip-1))))
      screen.move(recording_start,66)
      screen.text("|")
      local recording_end = util.linlin(1,9,15,120,rec.end_point - (8*(rec.clip-1)))
      screen.move(recording_end,66)
      screen.text("|")
      screen.move(123,64)
      screen.text(rec.clip)
    end
    screen.level(3)
    screen.move(0,64)
    screen.text("...")
  elseif menu == 3 then
    screen.move(0,10)
    screen.level(3)
    screen.text("levels")
    screen.line_width(1)
    local level_options = {"levels","envelope enable","decay"}
    for i = 1,3 do
      screen.level(3)
      screen.move(10,79-(i*20))
      local level_markers = {"0 -", "1 -", "2 -"}
      screen.text(level_markers[i])
      screen.move(10+(i*20),64)
      screen.level(level_options[page.levels_sel+1] == "levels" and 15 or 3)
      local level_to_screen_options = {"a", "b", "c"}
      if key1_hold or grid.alt == 1 then
        screen.text("("..level_to_screen_options[i]..")")
      else
        screen.text(level_to_screen_options[i]..""..bank[i].id)
      end
      screen.move(35+(20*(i-1)),57)
      local level_to_screen = util.linlin(0,2,0,40,bank[i][bank[i].id].level)
      --screen.level(bank[i][bank[i].id].pause and 3 or 15)
      screen.line(35+(20*(i-1)),57-level_to_screen)
      screen.close()
      screen.stroke()
      screen.level(level_options[page.levels_sel+1] == "envelope enable" and 15 or 3)
      screen.move(90,10)
      screen.text("env?")
      screen.move(90+((i-1)*15),20)
      if bank[i][bank[i].id].enveloped then
        screen.text("|\\")
      else
        screen.text("-")
      end
      screen.level(level_options[page.levels_sel+1] == "decay" and 15 or 3)
      screen.move(90,30)
      screen.text("decay")
      screen.move(90,30+((i)*10))
      local envelope_to_screen_options = {"a", "b", "c"}
      if key1_hold or grid.alt == 1 then
        screen.text("("..envelope_to_screen_options[i]..")")
      else
        screen.text(envelope_to_screen_options[i]..""..bank[i].id)
      end
      screen.move(110,30+((i)*10))
      if bank[i][bank[i].id].enveloped then
        screen.text(string.format("%.1f", bank[i][bank[i].id].envelope_time))
      else
        screen.text("---")
      end
    end
    screen.level(3)
    screen.move(0,64)
    screen.text("...")
  elseif menu == 4 then
    screen.move(0,10)
    screen.level(3)
    screen.text("panning")
    for i = 1,3 do
      screen.level(3)
      screen.move(10+((i-1)*53),25)
      local pan_options = {"L", "C", "R"}
      screen.text(pan_options[i])
      local pan_to_screen = util.linlin(-1,1,10,112,bank[i][bank[i].id].pan)
      screen.move(pan_to_screen,35+(10*(i-1)))
      local pan_to_screen_options = {"a", "b", "c"}
      screen.level(15)
      if key1_hold or grid.alt == 1 then
        screen.text("("..pan_to_screen_options[i]..")")
      else
        screen.text(pan_to_screen_options[i]..""..bank[i].id)
      end
    end
    --
    screen.level(3)
    screen.move(0,64)
    screen.text("...")
  elseif menu == 5 then
    screen.move(0,10)
    screen.level(3)
    screen.text("filters")
    
    for i = 1,3 do
      screen.move(17+((i-1)*45),25)
      screen.level(15)
      local filters_to_screen_options = {"a", "b", "c"}
      if key1_hold or grid.alt == 1 then
        screen.text_center(filters_to_screen_options[i]..""..bank[i].id)
      else
        screen.text_center("("..filters_to_screen_options[i]..")")
      end
      screen.move(17+((i-1)*45),35)
      
      screen.level(page.filtering_sel+1 == 1 and 15 or 3)
      if slew_counter[i].slewedVal ~= nil then
        if slew_counter[i].slewedVal >= -0.04 and slew_counter[i].slewedVal <=0.04 then
        screen.text_center(".....|.....")
        elseif slew_counter[i].slewedVal < -0.04 then
          if slew_counter[i].slewedVal > -0.2 then
            screen.text_center("....||.....")
          elseif slew_counter[i].slewedVal > -0.4 then
            screen.text_center("...|||.....")
          elseif slew_counter[i].slewedVal > -0.6 then
            screen.text_center("..||||.....")
          elseif slew_counter[i].slewedVal > -0.8 then
            screen.text_center(".|||||.....")
          elseif slew_counter[i].slewedVal >= -1.01 then
            screen.text_center("||||||.....")
          end
        elseif slew_counter[i].slewedVal > 0 then
          if slew_counter[i].slewedVal < 0.4 then
            screen.text_center(".....||....")
          elseif slew_counter[i].slewedVal < 0.6 then
            screen.text_center(".....|||...")
          elseif slew_counter[i].slewedVal < 0.8 then
            screen.text_center(".....||||..")
          elseif slew_counter[i].slewedVal < 0.9 then
            screen.text_center(".....|||||.")
          elseif slew_counter[i].slewedVal <= 1.01 then
            screen.text_center(".....||||||")
          end
        end
      end
      screen.move(17+((i-1)*45),45)
      screen.level(page.filtering_sel+1 == 2 and 15 or 3)
      local ease_time_to_screen = bank[i][bank[i].id].tilt_ease_time
      screen.text_center(string.format("%.2f",ease_time_to_screen/100).."s")
      screen.move(17+((i-1)*45),55)
      screen.level(page.filtering_sel+1 == 3 and 15 or 3)
      local ease_type_to_screen = bank[i][bank[i].id].tilt_ease_type
      local ease_types = {"cont","jumpy"}
      screen.text_center(ease_types[ease_type_to_screen])
    end
    screen.level(3)
    screen.move(0,64)
    screen.text("...")
  elseif menu == 6 then
    screen.move(0,10)
    screen.level(3)
    screen.text("delay")
    local options = {"rate","feed","cutoff","q","level"}
    for i = 1,5 do
      screen.level(page.delay_sel == i-1 and 15 or 3)
      screen.move(65,12 + (10*i))
      screen.text_center(options[i])
    end
    local rates = {"x2","x1 3/4","x1 2/3","x1 1/2","x1 1/3","x1 1/4","x1","/1 1/4","/1 1/3","/1 1/2","/1 2/3","/1 3/4","/2"}
    screen.level(page.delay_sel == 0 and 15 or 3)
    screen.move(25,22)
    screen.text_center(rates[params:get("delay L: rate")])
    screen.move(105,22)
    screen.text_center(rates[params:get("delay R: rate")])
    screen.level(page.delay_sel == 1 and 15 or 3)
    screen.move(25,32)
    screen.text_center(string.format("%.0f", params:get("delay L: feedback")))
    screen.move(105,32)
    screen.text_center(string.format("%.0f", params:get("delay R: feedback")))
    screen.level(page.delay_sel == 2 and 15 or 3)
    screen.move(25,42)
    screen.text_center(string.format("%.0f", params:get("delay L: filter cut")))
    screen.move(105,42)
    screen.text_center(string.format("%.0f", params:get("delay R: filter cut")))
    screen.level(page.delay_sel == 3 and 15 or 3)
    screen.move(25,52)
    screen.text_center(string.format("%.2f", params:get("delay L: filter q")))
    screen.move(105,52)
    screen.text_center(string.format("%.2f", params:get("delay R: filter q")))
    screen.level(page.delay_sel == 4 and 15 or 3)
    screen.move(25,62)
    screen.text_center(string.format("%.2f", params:get("delay L: global level")))
    screen.move(105,62)
    screen.text_center(string.format("%.2f", params:get("delay R: global level")))
    screen.level(3)
    screen.move(0,64)
    screen.text("...")
  elseif menu == 7 then
    screen.move(0,10)
    screen.level(3)
    screen.text("timing")
    screen.level(10)
    screen.move(15,30)
    screen.line(120,30)
    screen.stroke()
    for i = 1,5 do
      screen.level(page.time_sel == i and 15 or 3)
      local time_options = {"clk","P1","P2","P3","ALL"}
      screen.move(15+(23*(i-1)),25)
      screen.text(time_options[i])
      local glb_options = {"bpm","clk source","send crow clk?"}
      local p_options = {"linearize","snap to bars","crow output"}
      for j = 1,3 do
        screen.level(page.time_page_sel[page.time_sel] == j and 15 or 3)
        screen.move(15,40+(10*(j-1)))
        if page.time_sel == 1 then
          screen.text(glb_options[j])
          local clock_options = {"internal","MIDI","crow"}
          local fine_options = {params:get("bpm"), clock_options[params:get("clock")],params:get("crow_clock_out") == 2 and "yes" or "no"}
          screen.move(85,40+(10*(j-1)))
          screen.text(fine_options[j])
        elseif page.time_sel < 5 then
          screen.text(p_options[j])
          local fine_options = {"[K3]",bank[page.time_sel-1].snap_to_bars.." [+K3]", bank[page.time_sel-1].crow_execute == 1 and "pads" or "clk"}
          screen.move(85,40+(10*(j-1)))
          screen.text(fine_options[j])
          if bank[page.time_sel-1].crow_execute ~= 1 then
            screen.move(102,60)
            screen.level(page.time_page_sel[page.time_sel] == 4 and 15 or 3)
            screen.text("(/"..crow.count_execute[page.time_sel-1]..")")
          end
        elseif page.time_sel == 5 then
          local all_options = {"linear recording?","quantize pads?","quant resolution"}
          screen.text(all_options[j])
          local quant_div_options = {"1/4","1/8","1/8t","1/16","1/32"}
          local fine_options = {params:get("lock_pat") == 2 and "yes" or "no", params:get("quantize_pads") == 2 and "yes" or "no", quant_div_options[params:get("quant_div")]}
          screen.move(95,40+(10*(j-1)))
          screen.text(fine_options[j])
        end
      end
    end
    screen.level(3)
    screen.move(0,64)
    screen.text("...")
  elseif menu == 8 then
    screen.move(0,10)
    screen.level(3)
    screen.text("help")
    if help_menu == "welcome" then
      help_menus.welcome()
    elseif help_menu == "banks" then
      help_menus.banks()
    elseif help_menu == "zilchmo_4" then
      help_menus.zilchmo4()
    elseif help_menu == "zilchmo_3" then
      help_menus.zilchmo3()
    elseif help_menu == "zilchmo_2" then
      help_menus.zilchmo2()
    elseif help_menu == "grid patterns" then
      help_menus.grid_pattern()
    elseif help_menu == "alt" then
      help_menus.alt()
    elseif help_menu == "loop" then
      help_menus.loop()
    elseif help_menu == "mode" then
      help_menus.mode()
    elseif help_menu == "buffer jump" then
      help_menus.buffer_jump()
    elseif help_menu == "buffer switch" then
      help_menus.buffer_switch()
    elseif help_menu == "arc params" then
      help_menus.arc_params()
    elseif help_menu == "arc patterns" then
      help_menus.arc_pattern()
    end
    screen.level(3)
    screen.move(0,64)
    screen.text("...")
  end
end

return main_menu