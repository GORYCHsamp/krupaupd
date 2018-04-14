script_name("Krupa")
script_authors("GORYCH")
script_description("Бот крупье")
script_version("1.1")
script_dependencies("CLEO")

---------------------------------------------------------------------------
local hook = require 'lib.samp.events'
local inicfg = require 'inicfg'
require 'lib.moonloader'
local dlstatus = require('moonloader').download_status

function main()
	while not isSampAvailable() do wait(3800) end
	sampAddChatMessage(("{00FA9A}Бот крупье v"..thisScript().version..'{FFD700} |{FFFFFF}Активация: {10bfeb}/bkrupa {FFD700}|{FFFFFF} Автор: {00FA9A}GORYCH'), 0xFFFFFF)
	sampAddChatMessage(("{00FA9A}Бот крупье{FFD700} |{FFFFFF} Настройки: {10bfeb}/krupa {FFD700}"), 0xFFFFFF)
	if not doesDirectoryExist("moonloader/config") then createDirectory("moonloader/config") end
	Data = inicfg.load({
		Settings = {
			Mode = 1,
            Money = 10000,
			Time = 1800,
			Table = 1,
			},
	}, "Krupa")
	inicfg.save(Data, "Krupa")
	Dialog = lua_thread.create_suspended(DialogFunc)
	sampRegisterChatCommand("krupa", Krupa)
	sampRegisterChatCommand("updkrupa", UpdKrupa)
	sampRegisterChatCommand("bkrupa", Bkrupa)
	sampSetClientCommandDescription("krupa", "Настройки бота")
	sampSetClientCommandDescription("bkrupa", "Включить или выключить бота")
	sampSetClientCommandDescription("updkrupa", "Просмотреть список изменений")
	colls = lua_thread.create(collision)
	if Data.Settings.autoupdate == 1 then
	    sampAddChatMessage("{00FA9A}Krupa{FFD700} |{FFFFFF} Проверка обновлений...", 0xFFFFFF)
		update()
		while update ~= false do wait(100) end
	end
	Reload = false 
	Second = false
	proverka = false
	krupie = 0
	Font = renderCreateFont("Arial", 12, 0)
	func()
end
	 
--------------------------- Off Collision ---------------------------
function collision()
			               while true do
						   wait(0)
						   if enabled then
								for i = 0, sampGetMaxPlayerId(true) do
      								  local bool, newPed = sampGetCharHandleBySampPlayerId(i)
      								  if bool and doesCharExist(newPed) then
       								     local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
        								    local pX, pY, pZ = getCharCoordinates(newPed)
        								    local dist = getDistanceBetweenCoords3d(mX, mY, mZ, pX, pY, pZ)
         								   if dist <= 1 and newPed ~= playerPed then
        								         setCharCollision(newPed, false)
         								   end
       								 end
   							    end
							end	
							end
end


function func()

	while true do
		wait(0)
--------------------------FIND ID -------------------------------------
		                                            if Reload == true then 
														myId = nil
														ip = nil
														p = nil
														Nickname = nil
														_, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
														sampTextdrawCreate(1000, string.format("Searching %s id...", idFindFirst), 320, 360)
														sampTextdrawSetStyle(1000, 3)
														sampTextdrawSetOutlineColor(1000, 1, 0)
														sampTextdrawSetLetterSizeAndColor(1000, 0.5, 2, -1)
														sampTextdrawSetShadow(1000, 0.5, -16777216)		
														sampTextdrawSetAlign(1000, 2)																
														if sampIsPlayerConnected(idFindFirst) == false or idFindFirst == myId then
															   if sampGetCurrentDialogId() == 2 then
															   sampCloseCurrentDialogWithButton(0)
															   end
															myId = nil
															_, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
															Nickname = sampGetPlayerNickname(myId)
															sampSetLocalPlayerName(Nickname)
                                                            wait(1000)
                                                            ip, p = sampGetCurrentServerAddress()
                                                            sampConnectToServer(ip, p)
															Reload = false
															while not sampIsDialogActive() do
															wait(500) 
															end
															if sampIsDialogActive() and sampGetCurrentDialogId() == 2 then 
															wait(500)
															proverka = true
															end
															wait(1)
															myId = nil
															_, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
															if myId ~= idFindFirst then
															    sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} id не соответствует выбранному. Поиск..."), 0xff5555)
																Reload = true
															elseif myId == idFindFirst then 
															sampAddChatMessage(string.format("{00FA9A}[Krupa]{ffffff}Указанный id успешно найден. Ваш id: {00FA9A}%s", myId), 0xFFFFFF)
															sampTextdrawDelete(1000)
															Second = false
															idFindFirst = nil
		                                                    idFindSecond = nil
															end
														end
													end
--------------------------IF id 1 = id 2 -------------------------------------
		                                if Second == true then
												for i=0, 1000, 1 do
        											if i >= idFindFirst and i <= idFindSecond then
													    myId = nil
														ip = nil
														p = nil
														Nickname = nil
														_, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
														sampTextdrawCreate(1001, string.format("Searching %s to %s...", idFindFirst, idFindSecond), 320, 360)
														sampTextdrawSetOutlineColor(1001, 1, 0)
														sampTextdrawSetStyle(1001, 3)
														sampTextdrawSetLetterSizeAndColor(1001, 0.5, 2, -1)
														sampTextdrawSetShadow(1001, 0.5, -16777216)		
														sampTextdrawSetAlign(1001, 2)
														if sampIsPlayerConnected(i) == false or i == myId then
															if sampGetCurrentDialogId() == 2 then
															sampCloseCurrentDialogWithButton(0)
															end
															Nickname = sampGetPlayerNickname(myId)
															sampSetLocalPlayerName(Nickname)
                                                            wait(1000)
                                                            ip, p = sampGetCurrentServerAddress()
                                                            sampConnectToServer(ip, p)
															Second = false
															while not sampIsDialogActive() do
															wait(500) 
															end
															if sampIsDialogActive() and sampGetCurrentDialogId() == 2 then 
															wait(500)
															proverka = true
															end
        												end
    												end
											    end
												if proverka == true then
												myId = nil
												_, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
															if myId < idFindFirst or myId > idFindSecond then
															    sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} id %s не попадает в выбранный диапазон. Поиск...", myId), 0xff5555)
																Second = true
																proverka = false
															end
															if myId > idFindFirst and myId < idFindSecond then 
															sampAddChatMessage(string.format("{00FA9A}[Krupa]{ffffff} id успешно найден. Ваш id: {00FA9A}%s", myId), 0xFFFFFF)
															sampTextdrawDelete(1001)
															Second = false
															idFindFirst = nil
		                                                    idFindSecond = nil
															proverka = false
															end
												end
                                        end	
		-----------------------------------------BOT----------------------------------
		---------------------------------------Olivia---------------------------------
		if isPlayerPlaying(playerHandle) and enabled and Data.Settings.Table == 2 then
		    if enabled then Goto(37.980000, 2272.719971, 1501.670044, 3.000000, -255, false)			-- к столу
			if Data.Settings.Mode == 2 then
			while krupie ~= 1 and enabled do wait(1000) end
			wait(1)
			if krupie == 1 then
			end
			end
			if Data.Settings.Mode == 1 then
			i=0
			while enabled and i < (Data.Settings.Time/1000) do 
			i = i+1
			wait(1000)
			end
			end
			if enabled then Goto(37.529999, 2265.050049, 1500.790039, 1.000000, -255, false) -- вниз
			if enabled then Goto(33.669998, 2258.270020, 1500.790039, 1.000000, -255, false) -- перила
			if enabled then Goto(37.660000, 2246.429932, 1501.670044, 1.000000, -255, false) -- столик
			if enabled then Goto(37.220001, 2232.810059, 1500, 1.000000, -255, false) -- 
			if enabled then Goto(26.168000, 2233.590000, 1501.670044, 1.000000, -255, false) -- деньги
			wait(700)
			if enabled then EmulateKey(18, true)
			wait(20)
			if enabled then EmulateKey(18, false)
			wait(700)
			if enabled then Goto(26.160000, 2233.659912, 1501.670044, 1.000000, -255, false)
			if enabled then Goto(38.230000, 2233.189941, 1501.670044, 1.000000, -255, false)
			if enabled then Goto(37.660000, 2246.429932, 1501.670044, 1.000000, -255, false)
			if enabled then Goto(33.669998, 2258.270020, 1500.790039, 1.000000, -255, false)
			if enabled then Goto(37.529999, 2265.050049, 1500.790039, 1.000000, -255, false)
			if enabled then Goto(37.980000, 2271.719971, 1501.670044, 1.000000, -255, false)
			krupie = 0
			i = 0
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
			--------------------------- FIRST TABLE ----------------------------------
		if isPlayerPlaying(playerHandle) and enabled and Data.Settings.Table == 1 then
			if enabled then Goto(33.410000, 2241.330078, 1500, 3.000000, -255, false)
			if Data.Settings.Mode == 2 then
			while krupie ~= 1 and enabled do wait(1000) end
			wait(1)
			if krupie == 1 then
			end
			end
			if Data.Settings.Mode == 1 then
			i=0
			while enabled and i < (Data.Settings.Time/1000) do 
			i = i+1
			wait(1000)
			end
			end
			if enabled then Goto(38.980000, 2235.770020, 1500, 1.000000, -255, false)
			if enabled then Goto(37.220001, 2232.810059, 1500, 1.000000, -255, false)
			if enabled then Goto(26.168000, 2233.590000, 1500, 1.000000, -255, false)
			wait(700)
			if enabled then EmulateKey(18, true)
			wait(20)
			if enabled then EmulateKey(18, false)
			wait(700)
			if enabled then Goto(36.369999, 2233.030029, 1500, 1.000000, -255, false)
			if enabled then Goto(38.689999, 2234.969971, 1500, 1.000000, -255, false)
			if enabled then Goto(34.410000, 2240.330078, 1500, 1.000000, -255, false)
			krupie = 0
			i = 0
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
			end
		end
	
--------------------------- SERVER MESSAGE ---------------------------

function hook.onServerMessage(color, text) 
		if string.find(text, "Вы уже заработали %d+%$ за то что следите за игрой в кости!") then
				MoneyPaid = tonumber(string.match(text, "Вы уже заработали (%d+)$ за то что следите за игрой в кости!"))
				if MoneyPaid >= Data.Settings.Money then krupie = 1 end
        end
end


----------------------------Activation -----------------------------------
function Bkrupa()
enabled = not enabled
	if enabled then
		sampAddChatMessage("[Бот Krupa]: Активирован", 0x40FF40)
	else
		sampAddChatMessage("[Бот Krupa]: Деактивирован", 0xFF4040)
	end
end

----------------------------UPDDIALOG----------------------------
function UpdKrupa()
 local DialogText = "{00FA9A}v 1.0 : {F6DB6A}Бот крупье + Автоматическая ловля id. Отключена коллизия игроков при работе бота.\n\n{F6DB6A}В планах создать разные пути для персонажа для меньшей палевности.\n\n{FFFFFF}Если нашлись баги - пишите в Skype (egor6160) или Discord(GORYCH #0995)\n\nОбновление скрипта взято у FYP.\nПеремещение персонажа взято у SR_team"
	    dialogId = 1002
	    dialogButton = nil
	    dialogListItem = nil
	    dialogInput = nil
	    dialogBool = false
	    sampShowDialog(dialogId, "{FFFFFF}Обновления" , DialogText,"Закрыть","", 0)
	    if dialogButton == 0 then
		end
end

----------------------------DIALOG-------------------------------------

function Krupa()
	Dialog:run()
end

function DialogFunc()
	if Data.Settings.Mode == 1 then ModeString = "{55FF55}Время." else ModeString = "{55FF55}Деньги." end
	if Data.Settings.Table == 1 then TableString = "{55FF55}Первый стол." else TableString = "{55FF55}Стол с Оливией(бот)." end
	if Reload then RelString = string.format("{55FF55}Ловля %s id.", idFindFirst) elseif Second then RelString = string.format("{55FF55}Ловля от %s до %s id.", idFindFirst,idFindSecond) elseif Second == false or Reload == false then RelString = "{FF5555}Выключен." end
	if Data.Settings.Mode == 1 then
	local DialogText = string.format("{F6DB6A}Выбрать режим\t%s\n{F6DB6A}Выбрать время\t%d с.\n{F6DB6A}Ловля id\t%s\n{F6DB6A}Выбор стола\t%s", ModeString, Data.Settings.Time/1000, RelString, TableString)
	dialogId = 1100
	dialogButton = nil
	dialogListItem = nil
	dialogInput = nil
	dialogBool = false
	sampShowDialog(dialogId, "{FFFFFF}Настройки бота Крупье." , DialogText, "Выбрать", "Закрыть", 4)
	while not dialogBool do
		wait(0)
		dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
	end
	if dialogButton ~= 0 then
		if dialogListItem == 0 then
		if Data.Settings.Mode == 1 then 
		Data.Settings.Mode = 2 
		inicfg.save(Data, "Krupa") 
		Krupa() 
		else Data.Settings.Mode = 1
		inicfg.save(Data, "Krupa")
		Krupa() 
		end
		elseif dialogListItem == 1 then
		::Time::
		local DialogText = string.format("{F6DB6A}Введите время.\n{F6DB6A}Введите время, через которое бот будет забирать зарплату.\n{F6DB6A}Время указывать в секундах.\n\n{F6DB6A}Установленное время: {FFFFFF}%d", Data.Settings.Time/1000)
					dialogButton = nil
					dialogListItem = nil
					dialogInput = nil
					dialogBool = false
					sampShowDialog(dialogId, "{FFFFFF}Изменение клавиши." , DialogText, "Применить", "Назад", 1)
					sampSetCurrentDialogEditboxText(Data.Settings.Time/1000)
					while not dialogBool do
						wait(0)
						dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
					end
					if dialogButton ~= 0 then
						if dialogInput ~= nil and #dialogInput > 0 and string.find(dialogInput, "%d+") then
							dialogInput = tonumber(string.match(dialogInput, "^%D*(%d+)%D*"))
						    if dialogInput >= 1 and dialogInput <= 18000 then
							dialogInput = dialogInput * 1000
							Data.Settings.Time = dialogInput
							inicfg.save(Data, "Krupa")
							Krupa()
							elseif dialogInput > 18000 then
							sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} А вы точно уверены, что вам нужен этот бот?"), 0xff5555)
							sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите значение от 1 секунды до 5 часов"), 0xff5555)
							goto Time
						elseif dialogInput == 0 then
							sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите число от 1 (1 секунда) до 18000 (5 часов)."), 0xff5555)
							goto Time
							end
					else
						Krupa()
		            end
		end
	    elseif dialogListItem == 2 then
		::oneid::
----------------------------------- Первый id ----------------------------------------
		if Second == false and Reload == false
		then
		local DialogText = string.format("\n{F6DB6A}Введите id от которого будет вестись ловля.\n\n{F6DB6A}От:")
					dialogButton = nil
					dialogListItem = nil
					dialogInput = nil
					dialogBool = false
					sampShowDialog(dialogId, "{FFFFFF}Первый id." , DialogText, "Применить", "Назад", 1)
					sampSetCurrentDialogEditboxText(idFindFirst)
					while not dialogBool do
						wait(0)
						dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
					end
					if dialogButton ~= 0 then
						if dialogInput ~= nil and #dialogInput > 0 and string.find(dialogInput, "%d+") then
							dialogInput = tonumber(string.match(dialogInput, "^%D*(%d+)%D*"))
							idFindFirst = dialogInput
							
						     for i=0, 1000, 1 do
  						          if (sampIsPlayerConnected(i)) then
						    		Num = i
 						           end
  						end
						if idFindFirst >= 0 and idFindFirst <= Num then  -- Если больше либо равен 0 и меньше наибольшего
							    ----------------------------------- Второй id ----------------------------------------
								local DialogText = string.format("\n{F6DB6A}Введите id до которого будет вестись ловля.\n\n{F6DB6A}От %d до id:", idFindFirst)
								    dialogButton = nil
								    dialogListItem = nil
								    dialogInput = nil
								    dialogBool = false
								    sampShowDialog(dialogId, "{FFFFFF}Второй id." , DialogText, "Применить", "Назад", 1)
								    sampSetCurrentDialogEditboxText(idFindSecond)
								    while not dialogBool do
									    wait(0)
								    	dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
								    end
								    if dialogButton ~= 0 then
									    if dialogInput ~= nil and #dialogInput > 0 and string.find(dialogInput, "%d+") then
									    	dialogInput = tonumber(string.match(dialogInput, "^%D*(%d+)%D*"))
											idFindSecond = dialogInput
											
											for i=0, 1000, 1 do
  						   			           if(sampIsPlayerConnected(i)) then
						    			    		Num = i
 						     			          end
  						     			     end
										    if idFindSecond >= idFindFirst and idFindSecond <= Num then	
                                                if idFindFirst == idFindSecond then  ----- Если одинаковое значение
												sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля %s id", idFindSecond), 0xFFFFFF)
												Reload = true 
											    end
												if idFindFirst < idFindSecond then   ----- Если первый id меньше второго
												sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля id от %s до %s",idFindFirst, idFindSecond), 0xFFFFFF)
												Second = true
												end
											elseif idFindSecond > Num then
										    sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите id, не превышающий наибольший на сервере ( %d )",Num), 0xff5555)
											elseif idFindSecond < idFindFirst then
										    sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите меньший id первым.",Num), 0xff5555)
											idFindFirst = nil
											idFindSecond = nil
											goto oneid
										    end
					                    end
					                else
					                    idFindFirst = nil
						                idFindSecond = nil
						                Krupa()
					                end
						elseif idFindFirst > Num then
						sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите id, не превышающий наибольший на сервере ( %d )",Num), 0xff5555)
						end
		            end
					else
					    idFindFirst = nil
						Krupa()
					end
		elseif Second == true then
        Second = false
        sampTextdrawDelete(1001)
		idFindFirst = nil
		idFindSecond = nil
		sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля отключена"), 0xff5555)
		Krupa()
        elseif Reload == true then
        Reload = false
        sampTextdrawDelete(1000)	
        idFindFirst = nil
		idFindSecond = nil		
		sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля отключена"), 0xff5555)
		Krupa()
		end
		elseif dialogListItem == 3 then 
		if Data.Settings.Table == 1 then 
		Data.Settings.Table = 2
		inicfg.save(Data, "Krupa") 
		Krupa() 
		else 
		Data.Settings.Table = 1
		inicfg.save(Data, "Krupa")
		Krupa() 
		end
		end
	end
	 end
	if Data.Settings.Mode == 2 then
	local DialogText = string.format("{F6DB6A}Выбрать режим\t%s\n{F6DB6A}Выбрать количество денег\t%d$\n{F6DB6A}Ловля id\t%s\n{F6DB6A}Выбор стола\t%s", ModeString, Data.Settings.Money, RelString, TableString)
	dialogId = 1100
	dialogButton = nil
	dialogListItem = nil
	dialogInput = nil
	dialogBool = false
	sampShowDialog(dialogId, "{FFFFFF}Настройки бота Крупье." , DialogText, "Выбрать", "Закрыть", 4)
	while not dialogBool do
		wait(0)
		dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
	end
	if dialogButton ~= 0 then
		if dialogListItem == 0 then
		if Data.Settings.Mode == 1 then 
		Data.Settings.Mode = 2 
		inicfg.save(Data, "Krupa") 
		Krupa() 
		else Data.Settings.Mode = 1
		inicfg.save(Data, "Krupa")
		Krupa() 
		end
		elseif dialogListItem == 1 then
		::Money::
		local DialogText = string.format("\n{F6DB6A}Введите количество денег, после которого бот будет забирать зарплату.\n\n{F6DB6A}Установленная сумма: {FFFFFF}%d", Data.Settings.Money)
					dialogButton = nil
					dialogListItem = nil
					dialogInput = nil
					dialogBool = false
					sampShowDialog(dialogId, "{FFFFFF}Изменение количества денег." , DialogText, "Применить", "Назад", 1)
					sampSetCurrentDialogEditboxText(Data.Settings.Money)
					while not dialogBool do
						wait(0)
						dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
					end
					if dialogButton ~= 0 then
						if dialogInput ~= nil and #dialogInput > 0 and string.find(dialogInput, "%d+") then
							dialogInput = tonumber(string.match(dialogInput, "^%D*(%d+)%D*"))
						    if dialogInput % 100 == 0 then
						    if dialogInput >= 1000 and dialogInput < 1000000 then
							Data.Settings.Money = dialogInput
							inicfg.save(Data, "Krupa")
							Krupa()
							elseif dialogInput >= 1000000 then
							sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} А вы точно уверены, что вам нужен этот бот?"), 0xff5555)
							sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Рекомендуем вводить небольшие значения."), 0xff5555)
							goto Money
						elseif dialogInput < 1000 then
							sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите число от 1000$."), 0xff5555)
							goto Money
						end
						else
						sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите число, кратное 100."), 0xff5555)
						goto Money
							end
						end
					else
						Krupa()
		            end
		elseif dialogListItem == 2 then
		::id::
----------------------------------- Первый id ----------------------------------------
		if Second == false and Reload == false
		then
		local DialogText = string.format("\n{F6DB6A}Введите id от которого будет вестись ловля.\n\n{F6DB6A}От:")
					dialogButton = nil
					dialogListItem = nil
					dialogInput = nil
					dialogBool = false
					sampShowDialog(dialogId, "{FFFFFF}Первый id." , DialogText, "Применить", "Назад", 1)
					sampSetCurrentDialogEditboxText(idFindFirst)
					while not dialogBool do
						wait(0)
						dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
					end
					if dialogButton ~= 0 then
						if dialogInput ~= nil and #dialogInput > 0 and string.find(dialogInput, "%d+") then
							dialogInput = tonumber(string.match(dialogInput, "^%D*(%d+)%D*"))
							idFindFirst = dialogInput
							
						     for i=0, 1000, 1 do
  						          if (sampIsPlayerConnected(i)) then
						    		Num = i
 						           end
  						end
						if idFindFirst >= 0 and idFindFirst <= Num then  -- Если больше либо равен 0 и меньше наибольшего
							    ----------------------------------- Второй id ----------------------------------------
								local DialogText = string.format("\n{F6DB6A}Введите id до которого будет вестись ловля.\n\n{F6DB6A}От %d до id:", idFindFirst)
								    dialogButton = nil
								    dialogListItem = nil
								    dialogInput = nil
								    dialogBool = false
								    sampShowDialog(dialogId, "{FFFFFF}Второй id." , DialogText, "Применить", "Назад", 1)
								    sampSetCurrentDialogEditboxText(idFindSecond)
								    while not dialogBool do
									    wait(0)
								    	dialogBool, dialogButton, dialogListItem, dialogInput = sampHasDialogRespond(dialogId)
								    end
								    if dialogButton ~= 0 then
									    if dialogInput ~= nil and #dialogInput > 0 and string.find(dialogInput, "%d+") then
									    	dialogInput = tonumber(string.match(dialogInput, "^%D*(%d+)%D*"))
											idFindSecond = dialogInput
											
											for i=0, 1000, 1 do
  						   			           if(sampIsPlayerConnected(i)) then
						    			    		Num = i
 						     			          end
  						     			     end
										    if idFindSecond >= idFindFirst and idFindSecond <= Num then	
                                                if idFindFirst == idFindSecond then  ----- Если одинаковое значение
												sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля %s id", idFindSecond), 0xFFFFFF)
												Reload = true 
											    end
												if idFindFirst < idFindSecond then   ----- Если первый id меньше второго
												sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля id от %s до %s",idFindFirst, idFindSecond), 0xFFFFFF)
												Second = true
												end
											elseif idFindSecond > Num then
										    sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите id, не превышающий наибольший на сервере ( %d )",Num), 0xff5555)
											elseif idFindSecond < idFindFirst then
										    sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите меньший id первым.",Num), 0xff5555)
											idFindFirst = nil
											idFindSecond = nil
											goto id
										    end
					                    end
					                else
					                    idFindFirst = nil
						                idFindSecond = nil
						                Krupa()
					                end
						elseif idFindFirst > Num then
						sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Введите id, не превышающий наибольший на сервере ( %d )",Num), 0xff5555)
						end
		            end
					else
					    idFindFirst = nil
						Krupa()
					end
		elseif Second == true then
        Second = false
        sampTextdrawDelete(1001)
		idFindFirst = nil
		idFindSecond = nil
		sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля отключена"), 0xff5555)
		Krupa()
        elseif Reload == true then
        Reload = false
        sampTextdrawDelete(1000)	
        idFindFirst = nil
		idFindSecond = nil		
		sampAddChatMessage(string.format("{00FA9A}[Krupa]{ff5555} Ловля отключена"), 0xff5555)
		Krupa()
		end
	elseif dialogListItem == 3 then 
		if Data.Settings.Table == 1 then 
		Data.Settings.Table = 2
		inicfg.save(Data, "Krupa") 
		Krupa() 
		else 
		Data.Settings.Table = 1
		inicfg.save(Data, "Krupa")
		Krupa() 
		end
		end
		end
	end
	end



--------------------------- Взято у SR Team ---------------------------
function SetAngle(x, y, z)
	local posX, posY, posZ = getCharCoordinates(playerPed)
	local pX = x - posX
	local pY = y - posY
	local zAngle = getHeadingFromVector2d(pX, pY)
	if isCharInAnyCar(playerPed) then
		local car = storeCarCharIsInNoSave(playerPed)
		setCarHeading(car, zAngle)
	else
		setCharHeading(playerPed, zAngle)
	end
	restoreCameraJumpcut()
end

function Goto(x, y, z, radius, move_code, isSprint)
	repeat
		local posX, posY, posZ = getCharCoordinates(playerPed)
		SetAngle(x, y, z)
		MovePlayer(move_code, isSprint)
		local dist = getDistanceBetweenCoords3d(x, y, z, posX, posY, z)
		wait(0)
	until not enabled or dist < radius
end

function MovePlayer(move_code, isSprint)
	setGameKeyState(1, move_code)
	if isSprint then setGameKeyState(16, 255) end
end

--------------------------- Update ---------------------------

function update()
	local fpath = os.getenv('TEMP') .. '\\botkrupa-version025.json'
	downloadUrlToFile('https://raw.githubusercontent.com/GORYCHsamp/krupaupd/master/krupa.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			local f = io.open(fpath, 'r')
		if f then
			local info = decodeJson(f:read('*a'))
			updatelink = info.updateurl
			if info and info.latest then
					version = info.latest
					if tonumber(version) > tonumber(thisScript().version) then
					sampAddChatMessage(("{00FA9A}Krupa{FFD700} |{FFFFFF} Обновление найдено"), 0xFFFFFF)
						lua_thread.create(goupdate)
					else
					sampAddChatMessage(("{00FA9A}Krupa{FFD700} |{FFFFFF} Обновлений не найдено"), 0xFFFFFF)
					update = false
				end
			end
		end
	end
end)
end
function goupdate()
sampAddChatMessage(("{00FA9A}Krupa{FFD700} |{FFFFFF} Обновление до версии: {00FA9A}"..version), 0xFFFFFF)
sampAddChatMessage(("{00FA9A}Krupa{FFD700} |{FFFFFF} Текущая версия: {00FA9A}"..thisScript().version), 0xFFFFFF)
wait(10)
downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
	if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
	sampAddChatMessage(('{00FA9A}Krupa{FFD700} | {FFFFFF}Обновление завершено!'), 0xFFFFFF)
	sampAddChatMessage(('{00FA9A}Krupa{FFD700} | {FFFFFF}Если есть баги или остался этот пишите - gorychanim@gmail.com'), 0xFFFFFF)
	goplay = 1
	thisScript():reload()
end
end)
end