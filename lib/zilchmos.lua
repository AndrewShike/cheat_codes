zilchmos = {}

function zilchmos.init(k,i)

  which_bank = i
  if menu == 8 then
    help_menu = "zilchmo_"..k
  end
    if fingers[k][i].con == "1" then
      if k == 4 then
        if grid.alt == 0 then
          bank[i][bank[i].id].start_point = (eight*(bank[i][bank[i].id].clip-1)) + 1
        else
          for j = 1,16 do
            bank[i][j].start_point = (eight*(bank[i][j].clip-1)) + 1
          end
        end
        softcut.loop_start(i+1,bank[i][bank[i].id].start_point)
      elseif k == 3 then
        if grid.alt == 0 then
          bank[i][bank[i].id].pan = -1
        else
          for j = 1,16 do
            bank[i][j].pan = -1
          end
        end
        softcut.pan(i+1,-1)
      elseif k == 2 then
        if grid.alt == 0 then
          if bank[i][bank[i].id].level > 0 then
            bank[i][bank[i].id].level = bank[i][bank[i].id].level-0.125
          end
        else
          for j = 1,16 do
            if bank[i][j].level > 0 then
              bank[i][j].level = bank[i][j].level-0.125
            end
          end
        end
        if not bank[i][bank[i].id].enveloped then
          softcut.level_slew_time(i+1,1.0)
          softcut.level(i+1,bank[i][bank[i].id].level)
        end
      end
    end
    if fingers[k][i].con == "2" then
      if k == 4 then
        if grid.alt == 0 then
          bank[i][bank[i].id].start_point = 1+((eight/16)*(bank[i].id-1))
        else
          for j = 1,16 do
            bank[i][j].start_point = 1+((eight/16)*(j-1))
          end
        end
        softcut.loop_start(i+1,bank[i][bank[i].id].start_point)
      elseif k == 3 then
        if grid.alt == 0 then
          bank[i][bank[i].id].pan = 0
        else
          for j = 1,16 do
            bank[i][j].pan = 0
          end
        end
        softcut.pan(i+1,0)
      elseif k == 2 then
        if grid.alt == 0 then
          if bank[i][bank[i].id].level < 2.0 then
            bank[i][bank[i].id].level = bank[i][bank[i].id].level+0.125
          end
        else
          for j = 1,16 do
            if bank[i][j].level < 2.0 then
              bank[i][j].level = bank[i][j].level+0.125
            end
          end
        end
        if not bank[i][bank[i].id].enveloped then
          softcut.level_slew_time(i+1,1.0)
          softcut.level(i+1,bank[i][bank[i].id].level)
        end
      end
    end
    if fingers[k][i].con == "3" then
      if k == 4 then
        if grid.alt == 0 then
          bank[i][bank[i].id].end_point = 1+((eight/16)*bank[i].id)
        else
          for j= 1,16 do
            bank[i][j].end_point = 1+((eight/16)*j)
          end
        end
        softcut.loop_end(i+1,bank[i][bank[i].id].end_point)
      elseif k == 3 then
        if grid.alt == 0 then
          bank[i][bank[i].id].pan = 1
        else
          for j = 1,16 do
            bank[i][j].pan = 1
          end
        end
        softcut.pan(i+1,1)
      end
    end
    if fingers[k][i].con == "4" then
      if grid.alt == 0 then
        bank[i][bank[i].id].end_point = (eight*bank[i][bank[i].id].clip)+1
      else
        for j = 1,16 do
          bank[i][j].end_point = (eight*bank[i][j].clip)+1
        end
      end
      softcut.loop_end(i+1,bank[i][bank[i].id].end_point)
    end
    if fingers[k][i].con == "12" then
      if k == 4 then
        if grid.alt == 0 then
          local current_end = math.floor(bank[i][bank[i].id].end_point * 100)
          local min_start = math.floor(((eight*(bank[i][bank[i].id].clip-1))+1) * 100)
          bank[i][bank[i].id].start_point = math.random(min_start,current_end)/100
        else
          for j = 1,16 do
            local current_end = math.floor(bank[i][j].end_point*100)
            local min_start = math.floor(((eight*(bank[i][j].clip-1))+1) * 100)
            bank[i][j].start_point = math.random(min_start,current_end)/100
          end
        end
        if bank[i][bank[i].id].loop == true and bank[i][bank[i].id].enveloped == false then
        --if bank[i][bank[i].id].loop == true then
          cheat(i,bank[i].id)
        end
      elseif k == 3 then
        if grid.alt == 0 then
          if bank[i][bank[i].id].pan >= -0.9 then
            bank[i][bank[i].id].pan = bank[i][bank[i].id].pan - 0.1
          end
        else
          for j = 1,16 do
            if bank[i][j].pan >= -0.9 then
              bank[i][j].pan = bank[i][j].pan - 0.1
            end
          end
        end
        softcut.pan(i+1,bank[i][bank[i].id].pan)
      elseif k == 2 then
        if bank[i][bank[i].id].pause == false then
          if grid.alt == 0 then
            bank[i][bank[i].id].pause = true
          else
            for j = 1,16 do
              bank[i][j].pause = true
            end
          end
          softcut.level(i+1,0.0)
          softcut.rate(i+1,0.0)
        else
          if grid.alt == 0 then
            bank[i][bank[i].id].pause = false
          else
            for j = 1,16 do
              bank[i][j].pause = false
            end
          end
          if not bank[i][bank[i].id].enveloped then
            softcut.level(i+1,bank[i][bank[i].id].level)
          else
            cheat(i,bank[i].id)
          end
          softcut.rate(i+1,bank[i][bank[i].id].rate*bank[i][bank[i].id].offset)
        end
      end
    end
    if fingers[k][i].con == "23" then
      if k == 4 then
        if grid.alt == 0 then
          local jump = math.random(100,(eight+1) * 100)/100+(eight*(bank[i][bank[i].id].clip-1))
          local current_difference = (bank[i][bank[i].id].end_point - bank[i][bank[i].id].start_point)
          if jump+current_difference >= (eight+1)+(eight*(bank[i][bank[i].id].clip-1)) then
            bank[i][bank[i].id].end_point = (eight+1)+(eight*(bank[i][bank[i].id].clip-1))
            bank[i][bank[i].id].start_point = bank[i][bank[i].id].end_point - current_difference
          else
            bank[i][bank[i].id].start_point = jump
            bank[i][bank[i].id].end_point = bank[i][bank[i].id].start_point + current_difference
          end
        else
          for j = 1,16 do
            local jump = math.random(100,(eight+1) * 100)/100+(eight*(bank[i][j].clip-1))
            local current_difference = (bank[i][j].end_point - bank[i][j].start_point)
            if jump+current_difference >= (eight+1)+(eight*(bank[i][j].clip-1)) then
              bank[i][j].end_point = (eight+1)+(eight*(bank[i][j].clip-1))
              bank[i][j].start_point = bank[i][j].end_point - current_difference
            else
              bank[i][j].start_point = jump
              bank[i][j].end_point = bank[i][j].start_point + current_difference
            end
          end
        end
        softcut.loop_start(i+1,bank[i][bank[i].id].start_point)
        softcut.loop_end(i+1,bank[i][bank[i].id].end_point)
      elseif k == 3 then
        if grid.alt == 0 then
          if bank[i][bank[i].id].pan <= 0.9 then
            bank[i][bank[i].id].pan = bank[i][bank[i].id].pan + 0.1
          end
        else
          for j = 1,16 do
            if bank[i][j].pan <= 0.9 then
              bank[i][j].pan = bank[i][j].pan + 0.1
            end
          end
        end
        softcut.pan(i+1,bank[i][bank[i].id].pan)
      end
    end
    if fingers[k][i].con == "34" then
        if grid.alt == 0 then
          local current_start = math.floor(bank[i][bank[i].id].start_point * 100)
          local max_end = math.floor(((eight*bank[i][bank[i].id].clip)+1) * 100)
          bank[i][bank[i].id].end_point = math.random(current_start,max_end)/100
        else
          for j = 1,16 do
            local current_start = math.floor(bank[i][j].start_point * 100)
            local max_end = math.floor(((eight*bank[i][j].clip)+1) * 100)
            bank[i][j].end_point = math.random(current_start,max_end)/100
          end
        end
        softcut.loop_end(i+1,bank[i][bank[i].id].end_point)
    end
    if fingers[k][i].con == "13" then
      if k == 4 then
        local double = (bank[i][bank[i].id].end_point - bank[i][bank[i].id].start_point)*2
        if bank[i][bank[i].id].end_point - double > 0 then
          bank[i][bank[i].id].start_point = bank[i][bank[i].id].end_point - double
          softcut.loop_start(i+1,bank[i][bank[i].id].start_point)
        end
      elseif k == 3 then
        if grid.alt == 0 then
          bank[i][bank[i].id].pan = bank[i][bank[i].id].pan * -1
        else
          for j = 1,16 do
            bank[i][j].pan = bank[i][j].pan * -1
          end
        end
        softcut.pan(i+1,bank[i][bank[i].id].pan)
      end
    end
    if fingers[k][i].con == "24" then
      if k == 4 then
        local halve = ((bank[i][bank[i].id].end_point - bank[i][bank[i].id].start_point)/2)/2
        bank[i][bank[i].id].start_point = bank[i][bank[i].id].start_point + halve
        bank[i][bank[i].id].end_point = bank[i][bank[i].id].end_point - halve
        softcut.loop_start(i+1,bank[i][bank[i].id].start_point)
        softcut.loop_end(i+1,bank[i][bank[i].id].end_point)
      end
    end
    if fingers[k][i].con == "14" then
      if grid.alt == 0 then
        bank[i][bank[i].id].rate = bank[i][bank[i].id].rate*-1
        --[[local current = params:get("rate "..i)
        params:set("rate "..i,13-current)]]--
      else
        for j = 1,16 do
          bank[i][j].rate = bank[i][j].rate*-1
        end
        --[[local current = params:get("rate "..i)
        params:set("rate "..i,13-current)]]--
      end
      if bank[i][bank[i].id].pause == false then
        softcut.rate(i+1, bank[i][bank[i].id].rate*bank[i][bank[i].id].offset)
      end
    end
    if fingers[k][i].con == "124" then
      if grid.alt == 0 then
        if math.abs(bank[i][bank[i].id].rate) < 4 then
          bank[i][bank[i].id].rate = bank[i][bank[i].id].rate*2
        end
        --[[if params:get("rate "..i) < 12 and params:get("rate "..i) >= 7 then
          params:delta("rate "..i,1)
        elseif params:get("rate "..i) >= 1 and params:get("rate "..i) <= 6 then
          params:delta("rate "..i,-1)
        end]]--
      else
        for j = 1,16 do
          if math.abs(bank[i][j].rate) < 4 then
            bank[i][j].rate = bank[i][j].rate*2
          end
          --[[if params:get("rate "..i) < 12 and params:get("rate "..i) >= 7 then
            params:delta("rate "..i,1)
          elseif params:get("rate "..i) >= 1 and params:get("rate "..i) < 6 then
            params:delta("rate "..i,-1)
          end]]--
        end
      end
      if bank[i][bank[i].id].pause == false then
        softcut.rate(i+1, bank[i][bank[i].id].rate*bank[i][bank[i].id].offset)
        --softcut.level(i+1,bank[i][bank[i].id].level)
        -- WILL THIS WORK??
      end
    end
    if fingers[k][i].con == "134" then
      if grid.alt == 0 then
        if math.abs(bank[i][bank[i].id].rate) > 0.125 then
          bank[i][bank[i].id].rate = bank[i][bank[i].id].rate/2
        end
        --[[if params:get("rate "..i) > 7 then
          params:delta("rate "..i,-1)
        elseif params:get("rate "..i) >= 1 and params:get("rate "..i) < 6 then
          params:delta("rate "..i,1)
        end]]--
      else
        for j = 1,16 do
          if math.abs(bank[i][j].rate) > 0.125 then
            bank[i][j].rate = bank[i][j].rate/2
          end
          --[[if params:get("rate "..i) > 7 then
            params:delta("rate "..i,-1)
          elseif params:get("rate "..i) > 1 and params:get("rate "..i) < 6 then
            params:delta("rate "..i,1)
          end]]--
        end
      end
      if bank[i][bank[i].id].pause == false then
        softcut.rate(i+1, bank[i][bank[i].id].rate*bank[i][bank[i].id].offset)
        --softcut.level(i+1,bank[i][bank[i].id].level)
        -- WILL THIS WORK??
      end
    end
    if fingers[k][i].con == "123" then
      if k == 4 then
        if i == 1 then
          bank[i][bank[i].id].start_point = bank[2][bank[2].id].start_point - (eight*(bank[2][bank[2].id].clip-1))
          bank[i][bank[i].id].end_point = bank[2][bank[2].id].end_point - (eight*(bank[2][bank[2].id].clip-1))
        elseif i == 2 or 3 then
          bank[i][bank[i].id].start_point = bank[1][bank[1].id].start_point + (eight*(bank[i][bank[i].id].clip-1))
          bank[i][bank[i].id].end_point = bank[1][bank[1].id].end_point + (eight*(bank[i][bank[i].id].clip-1))
        end
        softcut.loop_start(i+1,bank[i][bank[i].id].start_point)
        softcut.loop_end(i+1,bank[i][bank[i].id].end_point)
        softcut.position(i+1,bank[i][bank[i].id].start_point)
      elseif k == 3 then
        if grid.alt == 0 then
          bank[i][bank[i].id].pan = math.random(-100,100)/100
        else
          for j = 1,16 do
            bank[i][j].pan = math.random(-100,100)/100
          end
        end
        softcut.pan(i+1,bank[i][bank[i].id].pan)
      end
    end
    if fingers[k][i].con == "234" then
      if k == 4 then
        if i == 3 then
          bank[3][bank[3].id].start_point = (bank[2][bank[2].id].start_point - (eight*(bank[2][bank[2].id].clip-1))) + (eight*(bank[3][bank[3].id].clip-1))
          bank[3][bank[3].id].end_point = (bank[2][bank[2].id].end_point - (eight*(bank[2][bank[2].id].clip-1))) + (eight*(bank[3][bank[3].id].clip-1))
        elseif i == 1 or 2 then
          bank[i][bank[i].id].start_point = (bank[3][bank[3].id].start_point - (eight*(bank[3][bank[3].id].clip-1))) + (eight*(bank[i][bank[i].id].clip-1))
          bank[i][bank[i].id].end_point = (bank[3][bank[3].id].end_point - (eight*(bank[3][bank[3].id].clip-1))) + (eight*(bank[i][bank[i].id].clip-1))
        end
        softcut.loop_start(i+1,bank[i][bank[i].id].start_point)
        softcut.loop_end(i+1,bank[i][bank[i].id].end_point)
        softcut.position(i+1,bank[i][bank[i].id].start_point)
      end
    end
    if fingers[k][i].con == "1234" then
      if grid.alt == 0 then
        if math.abs(bank[i][bank[i].id].rate) < 4 then
          if bank[i][bank[i].id].fifth == false then
            bank[i][bank[i].id].rate = bank[i][bank[i].id].rate*1.5
            bank[i][bank[i].id].fifth = true
          else
            bank[i][bank[i].id].rate = math.ceil(math.abs(bank[i][bank[i].id].rate))
            bank[i][bank[i].id].fifth = false
          end
        end
      else
        for j = 1,16 do
          if math.abs(bank[i][j].rate) < 4 then
            if bank[i][j].fifth == false then
              bank[i][j].rate = bank[i][j].rate*1.5
              bank[i][j].fifth = true
            else
              bank[i][j].rate = math.ceil(math.abs(bank[i][j].rate))
              bank[i][j].fifth = false
            end
          end
        end
      end
      if bank[i][bank[i].id].pause == false then
        softcut.rate(i+1, bank[i][bank[i].id].rate*bank[i][bank[i].id].offset)
      end
    end

end

return zilchmos