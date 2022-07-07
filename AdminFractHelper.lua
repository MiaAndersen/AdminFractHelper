script_name('AdminFractHelper')
script_version'2.0'
script_author'Mia Andersen & Lloyd_Stallone'

local enable_autoupdate = true
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'{ffffff}обнаружил обновление. Скрипт обновится с {a2c2e2}v.'..thisScript().version..' {ffffff}на {a2c2e2}v.'..updateversion..'{ffffff}.',m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено {a2c2e2}%d{ffffff} из {a2c2e2}%d{ffffff}.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'успешно обновился.',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'{ffffff}не удалось обновиться. Произойдет запуск старой версии.',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не удалось проверить обновление. Повторите попытку или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Повторите попыку или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/MiaAndersen/AdminFractHelper/main/update.json" .. tostring(os.clock())
            Update.prefix = "{a2c2e2}" .. thisScript().name .. "{ffffff} "
            Update.url = "https://github.com/MiaAndersen/AdminFractHelper/"
        end
    end
end

require "lib.moonloader"
require "lib.sampfuncs" 

local sampev = require "lib.samp.events"
local requests = require('requests')
local imgui = require 'imgui'
local vkeys = require "vkeys"
local encoding = require 'encoding'
local inicfg = require 'inicfg'

encoding.default = 'CP1251'
u8 = encoding.UTF8

imgui.ToggleButton = require('imgui_addons').ToggleButton

local dostup = true

local date = os.date("%d.%m.%Y")

local nick_one = ""
local nick_all = ""

local finded = false
local closeipfunc = false

local dates_one = ""
local dates_all = ""

local find_stoped_one = false
local find_sessions_one = false
local allses_one = ""
local date_start_one = ""
local date_finish_one = ""
local propusk_one = 0

local find_stoped_all = false
local find_sessions_all = false
local allses_all = ""
local date_start_all = ""
local date_finish_all = ""
local propusk_all = 0

local imgui_menu = 1
local show_ses_flag = false

local h1 = '0'
local h2 = '0'
local h3 = '0'
local h4 = '0'
local h5 = '0'
local h6 = '0'
local h7 = '0'
local h8 = '0'
local h9 = '0'
local h10 = '0'
local h11 = '0'
local h12 = '0'
local h13 = '0'
local h14 = '0'
local h15 = '0'
local h16 = '0'
local h17 = '0'
local h18 = '0'
local h19 = '0'
local h20 = '0'
local h21 = '0'
local h22 = '0'
local h23 = '0'
local h24 = '0'
local itog = "0"

local infa1 = "xx.xx.xxxx  14:00           xxx max   xx.xx avg    "
local infa2 = "xx.xx.xxxx  16:00           xxx max   xx.xx avg    "
local infa3 = "xx.xx.xxxx  18:00           xxx max   xx.xx avg    "
local infa4 = "xx.xx.xxxx  20:00           xxx max   xx.xx avg    "
local infa5 = "xx.xx.xxxx  14:00           xxx max   xx.xx avg    "
local infa6 = "xx.xx.xxxx  16:00           xxx max   xx.xx avg    "
local infa7 = "xx.xx.xxxx  18:00           xxx max   xx.xx avg    "
local infa8 = "xx.xx.xxxx  20:00           xxx max   xx.xx avg    "
local infa9 = "xx.xx.xxxx  14:00           xxx max   xx.xx avg    "
local infa10 = "xx.xx.xxxx  16:00           xxx max   xx.xx avg    "
local infa11 = "xx.xx.xxxx  18:00           xxx max   xx.xx avg    "
local infa12 = "xx.xx.xxxx  20:00           xxx max   xx.xx avg    "
local tl1 = "{ff0000}Фракция не выбрана"
local tl2 = "{ff0000}Фракция не выбрана"
local tl3 = "{ff0000}Фракция не выбрана"

local togglebutton = imgui.ImBool(false)
local togglebutton2 = imgui.ImBool(false)

local main_window = imgui.ImBool(false)

local buf_nickname = imgui.ImBuffer(256)
local buf_date_start_one = imgui.ImBuffer(256)
local buf_date_finish_one = imgui.ImBuffer(256)

local buf_date_start_all = imgui.ImBuffer(256)
local buf_date_finish_all = imgui.ImBuffer(256)

local settings_buf = imgui.ImBuffer(9500)

local all_admins = {}

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2



    colors[clr.Text]                 = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.22, 0.22, 0.22, 1.00)
    colors[clr.WindowBg]             = ImVec4(1.00, 1.00, 1.00, 0.71)
    colors[clr.ChildWindowBg]        = ImVec4(0.92, 0.92, 0.92, 0.00)
    colors[clr.PopupBg]              = ImVec4(1.00, 1.00, 1.00, 0.94)
    colors[clr.Border]               = ImVec4(1.00, 1.00, 1.00, 0.50)
    colors[clr.BorderShadow]         = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.77, 0.49, 0.66, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(1.00, 1.00, 1.00, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.TitleBg]              = ImVec4(0.76, 0.51, 0.66, 0.71)
    colors[clr.TitleBgActive]        = ImVec4(0.97, 0.74, 0.88, 0.74)
    colors[clr.TitleBgCollapsed]     = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(1.00, 1.00, 1.00, 0.54)
    colors[clr.ScrollbarBg]          = ImVec4(0.81, 0.81, 0.81, 0.54)
    colors[clr.ScrollbarGrab]        = ImVec4(0.78, 0.28, 0.58, 0.13)
    colors[clr.ScrollbarGrabHovered] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.Button]               = ImVec4(0.78, 0.28, 0.58, 0.54)
    colors[clr.ButtonHovered]        = ImVec4(0.77, 0.52, 0.67, 0.54)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.Header]               = ImVec4(0.78, 0.28, 0.58, 0.54)
    colors[clr.HeaderHovered]        = ImVec4(0.78, 0.28, 0.58, 0.25)
    colors[clr.HeaderActive]         = ImVec4(0.79, 0.04, 0.48, 0.63)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.79, 0.44, 0.65, 0.64)
    colors[clr.SeparatorActive]      = ImVec4(0.79, 0.17, 0.54, 0.77)
    colors[clr.ResizeGrip]           = ImVec4(0.87, 0.36, 0.66, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.ResizeGripActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.76, 0.46, 0.64, 0.71)
    colors[clr.CloseButtonActive]    = ImVec4(0.78, 0.28, 0.58, 0.79)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end
apply_custom_style()

if not doesFileExist("moonloader/config/online_counter.json") then 
        local file = io.open("moonloader/config/online_counter.json", "w") 
        file:write(encodeJson({ 
            admins = "";
        }))
        io.close(file)
end

if doesFileExist("moonloader/config/online_counter.json") then
    local file = io.open("moonloader/config/online_counter.json", "r") 
    if file then 
        database = decodeJson(file:read("*a")) 
        io.close(file)
    end 
end

function main()
    while not isSampAvailable() do wait(2000) end
    repeat wait(0) until sampIsLocalPlayerSpawned()

    if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end

    local request = requests.get('https://pastebin.com/raw/MtVkppyu')
    local dosnick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    local function res()
        for n in request.text:gmatch('[^\r\n]+') do
            if dosnick:find(n) then return true end
        end
        return false
    end
    if not res() then 
        sampAddChatMessage('У вас нет прав на использование данного скрипта, поскольку в реестр разрешенных никнеймов ваш ник отсутствует.', 0xAFAFAF)
        dostup = false
        thisScript():unload()
    end

    _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    mynick = sampGetPlayerNickname(myid)

    sampAddChatMessage('Добро пожаловать, {a2c2e2}'..mynick..'{FFFFFF}. Вы успешно авторизовались в помощнике для следящей администрации.', 0xFFFFFF)
    sampAddChatMessage('AdminFractHelper успешно загружен. Чтобы открыть меню, используйте команду {a2c2e2}/afhmenu{ffffff}.', 0xFFFFFF)
        local request = requests.get('https://pastebin.com/raw/25MVjRhZ')
        for n in request.text:gmatch('[^\r\n]+') do
            if n == '1' then
                sampAddChatMessage('{6495ED}Новый комментарий от старшего следящего Mia_Andersen:', 0xFFFFFF)
                local request = requests.get('https://pastebin.com/raw/FFAB6x5F')
                for n in request.text:gmatch('[^\r\n]+') do
                    sampAddChatMessage(u8:decode(n), 0xFFFFFF)
                end
            end
        end

    sampRegisterChatCommand('afhmenu', cmd_main)

    imgui.Process = false

    while true do
        wait(0)

        local result, button, list, input = sampHasDialogRespond(10)

        if result then
            if button == 1 then
                if list == 0 then
                    sampShowDialog(11, "{34c924}AdminFractHelper: {FFFFFF}Информация о скрипте", "{ffffff}Скрипт {abcdef}AdminFractHelper{ffffff} был разработан администраторами {abcdef}Mia_Andersen{ffffff} и {abcdef}Lloyd_Stallone{ffffff}.\nДанный скрипт предназначен для следящей администрации проекта {34c924}Trinity GTA{FFFFFF}, который в большом объеме облегчит их повседневную рутину.\nДля работы с скриптом существует одна единственная команда — {abcdef}/afhmenu{ffffff}, в которой собраны все необходимые для работы функции.\n\nОгромная благодарность выражается бывшему администратору {abcdef}Maximiliano_Marino{ffffff} за код скрипта счетчика онлайна.", "X")
                elseif list == 1 then
                    cmd_counter()
                elseif list == 2 then
                    sampShowDialog(25, '{34c924}AdminFractHelper: {FFFFFF}Подсчет онлайна фракции','1)   Вывод полученных данных\n2)   Начать сбор данных\n3)   Очистить старые данные', "Выбор", "Назад", 2)
                elseif list == 3 then
                    sampAddChatMessage('Чтобы узнать, какая фракция приняла определенное количество человек, выбирайте пункт нужной фракции в диалоге {a2c2e2}«Графики наборов»{ffffff}.', 0xFFFFFF)
                    sampAddChatMessage('Скрипт подсчитает количество наборов и выведет в чат число игроков, принятых во фракцию.', 0xFFFFFF)
                    sampSendChat('/invstat')
                elseif list == 4 then
                    cmd_fleader()
                elseif list == 5 then
                    sampShowDialog(15, "{34c924}AdminFractHelper: {FFFFFF}Настройка даты", "{ffffff}Для того, чтобы {a2c2e2}AdminFractHelper{ffffff} смог получить верную информацию об организации, вам необходимо указать дату, по которой вы проводите проверку.\nПосле того, как вы указали день, вы можете выбрать пункты {abcdef}«Подсчет онлайна фракции»{ffffff} или {abcdef}«Подсчет инвайтов»{ffffff}.\n\nСейчас используется дата {D8A903}"..date.."{ffffff}. Пожалуйста, укажите день в формате {abcdef}«dd.mm.yyyy»{ffffff} в поле ниже:", "Ввод", "Назад", 1)
                elseif list == 6 then
                    sampShowDialog(19, '{34c924}AdminFractHelper: {FFFFFF}Настройки скрипта','1)   Перезагрузить скрипт\n2)   Отключить скрипт', "Выбор", "Назад", 2)
                elseif list == 7 then
                    sampShowDialog(501, "{34c924}AdminFractHelper: {FFFFFF}Нововведения", "{fbec5d}Список доработок в версии "..thisScript().version..":\n\n{D8A903}о {FFFFFF}В скрипте были исправлены критические ошибки, из-за которых он крашился.", "X")
                end
            end
        end

        local result, button, list, input = sampHasDialogRespond(15)

        if result then
            if button == 1 then
                if input == nil or input == ""
                then
                    sampShowDialog(15, "{34c924}AdminFractHelper: {FFFFFF}Настройка даты", "{ffffff}Для того, чтобы {a2c2e2}AdminFractHelper{ffffff} смог получить верную информацию об организации, вам необходимо указать дату, по которой вы проводите проверку.\nПосле того, как вы указали день, вы можете выбрать пункты {abcdef}«Подсчет онлайна фракции»{ffffff} или {abcdef}«Подсчет инвайтов»{ffffff}.\n\nСейчас используется дата {D8A903}"..date.."{ffffff}. Пожалуйста, укажите день в формате {abcdef}«dd.mm.yyyy»{ffffff} в поле ниже:", "Ввод", "Назад", 1)
                else
                    if input == string.match(input, '%d+%.%d+%.%d+') then
                        date = input
                        sampShowDialog(510, " ", "{FFFFFF}Вы назначили дату {D8A903}"..date.."{ffffff} новой датой поиска данных.", "X")
                    else
                        sampShowDialog(511, " ", "{AFAFAF}Введеное вами значение {D8A903}"..input.."{AFAFAF} не является датой.", "X")
                    end
                end
            else
                cmd_main()
            end
        end

        local result, button, list, input = sampHasDialogRespond(511)

        if result then
            if button == 1 then
                sampShowDialog(15, "{34c924}AdminFractHelper: {FFFFFF}Настройка даты", "{ffffff}Для того, чтобы {a2c2e2}AdminFractHelper{ffffff} смог получить верную информацию об организации, вам необходимо указать дату, по которой вы проводите проверку.\nПосле того, как вы указали день, вы можете выбрать пункты {abcdef}«Подсчет онлайна фракции»{ffffff} или {abcdef}«Подсчет инвайтов»{ffffff}.\n\nСейчас используется дата {D8A903}"..date.."{ffffff}. Пожалуйста, укажите день в формате {abcdef}«dd.mm.yyyy»{ffffff} в поле ниже:", "Ввод", "Назад", 1)
            else
                sampShowDialog(15, "{34c924}AdminFractHelper: {FFFFFF}Настройка даты", "{ffffff}Для того, чтобы {a2c2e2}AdminFractHelper{ffffff} смог получить верную информацию об организации, вам необходимо указать дату, по которой вы проводите проверку.\nПосле того, как вы указали день, вы можете выбрать пункты {abcdef}«Подсчет онлайна фракции»{ffffff} или {abcdef}«Подсчет инвайтов»{ffffff}.\n\nСейчас используется дата {D8A903}"..date.."{ffffff}. Пожалуйста, укажите день в формате {abcdef}«dd.mm.yyyy»{ffffff} в поле ниже:", "Ввод", "Назад", 1)
            end
        end

        local result, button, list, input = sampHasDialogRespond(512)

        if result then
            if button == 1 then
                sampShowDialog(25, '{34c924}AdminFractHelper: {FFFFFF}Подсчет онлайна фракции','1)   Вывод полученных данных\n2)   Начать сбор данных\n3)   Очистить старые данные', "Выбор", "Назад", 2)
            else
                sampShowDialog(25, '{34c924}AdminFractHelper: {FFFFFF}Подсчет онлайна фракции','1)   Вывод полученных данных\n2)   Начать сбор данных\n3)   Очистить старые данные', "Выбор", "Назад", 2)
            end
        end

        local result, button, list, input = sampHasDialogRespond(19)

        if result then
            if button == 1 then
                if list == 0 then
                    sampAddChatMessage('AdminFractHelper был успешно перезагружен.', 0xAFAFAF)
                    thisScript():reload()
                elseif list == 1 then
                    sampAddChatMessage('AdminFractHelper завершает свою работу.', 0xAFAFAF)
                    thisScript():unload()
                end
            else
                cmd_main()
            end
        end

        local result, button, list, input = sampHasDialogRespond(25)

        if result then
            if button == 1 then
                if list == 0 then
                    sampShowDialog(473, '{34c924}Графики онлайна фракций трёх стран за {D8A903}'..date,'{7FFFD4}________________________________________________________________\n\n{FF0000}'..tl1..':{FFFFFF}\n\n'..infa1.."\n"..infa2.."\n"..infa3.."\n"..infa4..'\n\n{7FFFD4}________________________________________________________________\n\n{FF0000}'..tl2..':{FFFFFF}\n\n'..infa5.."\n"..infa6.."\n"..infa7.."\n"..infa8..'\n\n{7FFFD4}________________________________________________________________\n\n{FF0000}'..tl3..':{FFFFFF}\n\n'..infa9.."\n"..infa10.."\n"..infa11.."\n"..infa12..'\n{7FFFD4}________________________________________________________________', "Готово")
                elseif list == 1 then
                    sampAddChatMessage('Чтобы узнать, какой онлайн был у проверяемой фракции в час пик, выбирайте пункт нужной фракции в диалоге {a2c2e2}«Графики онлайна»{ffffff}.', 0xFFFFFF)
                    sampAddChatMessage('Скрипт подсчитает нужные данные и выведет в новом диалоге результат.', 0xFFFFFF)
                    sampSendChat('/fstat')
                elseif list == 2 then
                    infa1 = "xx.xx.xxxx  14:00           xxx max   xx.xx avg    "
                    infa2 = "xx.xx.xxxx  16:00           xxx max   xx.xx avg    "
                    infa3 = "xx.xx.xxxx  18:00           xxx max   xx.xx avg    "
                    infa4 = "xx.xx.xxxx  20:00           xxx max   xx.xx avg    "
                    infa5 = "xx.xx.xxxx  14:00           xxx max   xx.xx avg    "
                    infa6 = "xx.xx.xxxx  16:00           xxx max   xx.xx avg    "
                    infa7 = "xx.xx.xxxx  18:00           xxx max   xx.xx avg    "
                    infa8 = "xx.xx.xxxx  20:00           xxx max   xx.xx avg    "
                    infa9 = "xx.xx.xxxx  14:00           xxx max   xx.xx avg    "
                    infa10 = "xx.xx.xxxx  16:00           xxx max   xx.xx avg    "
                    infa11 = "xx.xx.xxxx  18:00           xxx max   xx.xx avg    "
                    infa12 = "xx.xx.xxxx  20:00           xxx max   xx.xx avg    "
                    tl1 = "N/A"
                    tl2 = "N/A"
                    tl3 = "N/A"
                    sampShowDialog(512, " ", "{AFAFAF}Данные об онлайне фракций были успешно стерты.", "X")
                end
            else
                cmd_main()
            end
        end

        if new_nick then
            new_nick = false
            local nick_id = 0
            for nicks in (database["admins"]):gmatch("[^\n]+") do
                if nick_id == find_nick_id then
                    nick_all, propusk_all, finded, allses_all = nicks, 0, false, ""
                    all_admins[nick_all] = {}
                    all_admins[nick_all]["sessions"] = ""
                    if togglebutton2.v then
                        sampAddChatMessage("{AFAFAF}Ведётся запись сессий аккаунта {FFFFFF}" .. nick_all .. "{AFAFAF}.")
                    end
                end
                find_sessions_all = true
                nick_id = nick_id + 1
            end
            if find_nick_id == nick_id then
                finded, closeipfunc, show_ses_flag, find_sessions_all = false, true, true, false
                find_nick_id, propusk_all = 0, 0
                nick_all, allses_all = "", ""
                sampAddChatMessage("{AFAFAF}Вся необходимая информация была получена. Были проведены необходимые подсчёты. Теперь можно увидеть итог.")
                find_stoped_all = true
            end
        end

    end
end

function cmd_main()
    sampShowDialog(10, "{34c924}AdminFractHelper", "1)   Информация о скрипте\n2)   Режим {a2c2e2}«Подсчет онлайна лидеров»\n3)   Режим {a2c2e2}«Подсчет онлайна фракций»\n4)   Режим {a2c2e2}«Подсчет инвайтов»\n5)   Список лидеров\n6)   Настройка даты для проверки\n7)   Настройки помощника\n8)   Нововведения", "Выбор", "Выход", 2)
end

function cmd_counter()
        main_window.v = not main_window.v
        imgui.Process = main_window.v
end

function AverageOnline(sessions, datestart, datefinish)
        local datetime1 = {}
        local datetime2 = {}
        local days = 0
        local average_online = 0
        local all_time = ""
        local old_date = ""
        local sessons_need = ""
        local date = get_ipfunc_date(datestart)
        datetime1.day = tonumber(datestart:match("(%d+).%d+.%d+"))
        datetime1.month = tonumber(datestart:match("%d+.(%d+).%d+"))
        datetime1.year = tonumber(datestart:match("%d+.%d+.(%d+)"))

        datetime2.day = tonumber(datefinish:match("(%d+).%d+.%d+"))
        datetime2.month = tonumber(datefinish:match("%d+.(%d+).%d+"))
        datetime2.year = tonumber(datefinish:match("%d+.%d+.(%d+)"))
        datetime2 = os.date("!*t", (os.time(datetime2) + 24 * 60 * 60))
        datefinish = datetime2.day .. "." .. datetime2.month .. "." .. datetime2.year
        datefinish = get_ipfunc_date(datefinish)
        while date ~= datefinish do
            local alltime_m = 0
            local alltime = ""
            local afk_m = 0
            local afk = ""
            local tabl = ""
            date = datetime1.day .. "." .. datetime1.month .. "." .. datetime1.year
            date = get_ipfunc_date(date)
            if old_date ~= date then
                if sessions:find("%d+:%d+%s+%d+.%d+.%d+%s+%d+:%d+%s+%d+.%d+.%d+") then
                    local old_session = ""
                    for line in sessions:gmatch("[^\n]+") do
                        if line:find("nleft") == nil and line:find("player online") == nil and line:find("invalid_session") == nil then
                            local time1, day1, time2, day2 = line:match("(%d+:%d+)%s+(%d+.%d+.%d+)%s+(%d+:%d+)%s+(%d+.%d+.%d+)")
                            local afk_ses = 0
                            if line:find("AFK (%d+.%d+) .") ~= nil then
                                afk_ses = tonumber(line:match("AFK (%d+.%d+) ."))
                            end
                            local time_m_1 = tonumber(time1:match("(%d+):")) * 60 + tonumber(time1:match(":(%d+)"))
                            local time_m_2 = tonumber(time2:match("(%d+):")) * 60 + tonumber(time2:match(":(%d+)"))
                            if date == day1 and date == day2 and old_session ~= line then
                                average_online = average_online + (time_m_2 - time_m_1)
                                alltime_m = alltime_m + (time_m_2 - time_m_1)
                                if line:find("AFK (%d+.%d+) .") ~= nil then
                                    afk_m = afk_m + ((time_m_2 - time_m_1) * afk_ses / 100)
                                end
                                old_session = line
                            elseif date ~= day1 and date == day2 and old_session ~= line then
                                average_online = average_online + time_m_2
                                alltime_m = alltime_m + time_m_2
                                if line:find("AFK (%d+.%d+) .") ~= nil then
                                    afk_m = afk_m + (time_m_2 * afk_ses / 100)
                                end
                                old_session = line
                            elseif date == day1 and date ~= day2 and old_session ~= line then
                                average_online = average_online + ((24 * 60) - time_m_1)
                                alltime_m = alltime_m + ((24 * 60) - time_m_1)
                                if line:find("AFK (%d+.%d+) .") ~= nil then
                                    afk_m = afk_m + (((24 * 60) - time_m_1) * afk_ses / 100)
                                end
                                old_session = line
                            end
                        end
                    end
                    if alltime_m ~= 0 and date ~= "" then
                        alltime = tostring(math.floor(alltime_m / 60)) .. ":"
                        tabl = tostring(math.floor(alltime_m / 60)) .. ","
                        afk = tostring(math.floor(afk_m / 60)) .. ":"
                        if 10 - alltime_m % 60 > 0 then
                            alltime = alltime .. 0 .. tostring(alltime_m % 60)
                        else
                            alltime = alltime .. tostring(alltime_m % 60)
                        end
                        if 10 - math.floor(alltime_m % 60 * 100 / 60) > 0 then
                            tabl = tabl .. 0 .. tostring(math.floor(alltime_m % 60 * 100 / 60))
                        else
                            tabl = tabl .. tostring(math.floor(alltime_m % 60 * 100 / 60))
                        end
                        if 10 - afk_m % 60 > 0 then
                            afk = afk .. 0 .. tostring(math.floor(afk_m % 60))
                        else
                            afk = afk .. tostring(math.floor(afk_m % 60))
                        end            
                    else
                        alltime = "0"
                        afk = "0"
                        tabl = "0"
                    end
                end
                old_date = date
                all_time = all_time .. "Онлайн за " .. date .. ": " .. alltime .. " | Время AFK: " .. afk .. " | Для таблицы: " .. tabl .. "\n"
                days = days + 1
            end
            datetime1 = os.date("!*t", (os.time(datetime1) + 24 * 60 * 60))
            date = datetime1.day .. "." .. datetime1.month .. "." .. datetime1.year
            date = get_ipfunc_date(date)
        end

        average_online = tonumber(string.format("%.2f", (average_online / days / 60)))
        return all_time, average_online
end
function get_ipfunc_date(new_date)
        local datetime = {}
        datetime.day = tonumber(new_date:match("(%d+).%d+.%d+"))
        datetime.month = tonumber(new_date:match("%d+.(%d+).%d+"))
        datetime.year = tonumber(new_date:match("%d+.%d+.(%d+)"))
        local date_ipfunc = ""
        if 10 - datetime.day > 0 then
            if 10 - datetime.month > 0 then
                date_ipfunc = "0" .. datetime.day .. "." .. "0" .. datetime.month .. "." .. datetime.year
            else
                date_ipfunc = "0" .. datetime.day .. "." .. datetime.month .. "." .. datetime.year
            end
        else
            if 10 - datetime.month > 0 then
                date_ipfunc = datetime.day .. "." .. "0" .. datetime.month .. "." .. datetime.year
            else
                date_ipfunc = datetime.day .. "." .. datetime.month .. "." .. datetime.year
            end
        end
        return date_ipfunc
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if title:find("График онлайна") ~= nil then
        zag = title
         for line in text:gmatch(date.."  14:00[^\n]+") do
            if infa1 == "xx.xx.xxxx  14:00           xxx max   xx.xx avg    " then
            infa1 = line
            if title:find ("График онлайна ") then
                title = title:gsub("График онлайна ", "")
                tl1 = title
                sampAddChatMessage('{ffffff}Данные фракции '..tl1..' {ffffff}получены. Закройте страницу.')
            end
            elseif infa5 == "xx.xx.xxxx  14:00           xxx max   xx.xx avg    " then
                infa5 = line
                if title:find ("График онлайна ") then
                    title = title:gsub("График онлайна ", "")
                    tl2 = title
                    sampAddChatMessage('{ffffff}Данные фракции '..tl2..' {ffffff}получены. Закройте страницу.')
                end
            elseif infa9 == "xx.xx.xxxx  14:00           xxx max   xx.xx avg    " then
                infa9 = line
                if title:find ("График онлайна ") then
                    title = title:gsub("График онлайна ", "")
                    tl3 = title
                    sampAddChatMessage('{ffffff}Данные фракции '..tl3..' {ffffff}получены. Закройте страницу.')
                    sampAddChatMessage('{ffffff}Для получения результата вычислений используйте {abcdef}/afhmenu » Подсчет онлайна фракции » Вывод полученных данных{ffffff}.')
                end
		    end
        end
         for line in text:gmatch(date.."  16:00[^\n]+") do
            if infa2 == "xx.xx.xxxx  16:00           xxx max   xx.xx avg    " then
                infa2 = line
                elseif infa6 == "xx.xx.xxxx  16:00           xxx max   xx.xx avg    " then
                    infa6 = line
                elseif infa10 == "xx.xx.xxxx  16:00           xxx max   xx.xx avg    " then
                    infa10 = line
                end
            end
         for line in text:gmatch(date.."  18:00[^\n]+") do
            if infa3 == "xx.xx.xxxx  18:00           xxx max   xx.xx avg    " then
                infa3 = line
                elseif infa7 == "xx.xx.xxxx  18:00           xxx max   xx.xx avg    " then
                    infa7 = line
                elseif infa11 == "xx.xx.xxxx  18:00           xxx max   xx.xx avg    " then
                    infa11 = line
                end
            end
         for line in text:gmatch(date.."  20:00[^\n]+") do
            if infa4 == "xx.xx.xxxx  20:00           xxx max   xx.xx avg    " then
                infa4 = line
                elseif infa8 == "xx.xx.xxxx  20:00           xxx max   xx.xx avg    " then
                    infa8 = line
                elseif infa12 == "xx.xx.xxxx  20:00           xxx max   xx.xx avg    " then
                    infa12 = line
                end
            end
    end
    if title:find("График наборов") ~= nil then
        head = title:gsub("График наборов ", "")
        h1 = string.match(text, date.."  01:00           (%d+) чел%.")
        h2 = string.match(text, date.."  02:00           (%d+) чел%.")
        h3 = string.match(text, date.."  03:00           (%d+) чел%.")
        h4 = string.match(text, date.."  04:00           (%d+) чел%.")
        h5 = string.match(text, date.."  05:30           (%d+) чел%.")
        h6 = string.match(text, date.."  06:00           (%d+) чел%.")
        h7 = string.match(text, date.."  07:00           (%d+) чел%.")
        h8 = string.match(text, date.."  08:00           (%d+) чел%.")
        h9 = string.match(text, date.."  09:00           (%d+) чел%.")
        h10 = string.match(text, date.."  10:00           (%d+) чел%.")
        h11 = string.match(text, date.."  11:00           (%d+) чел%.")
        h12 = string.match(text, date.."  12:00           (%d+) чел%.")
        h13 = string.match(text, date.."  13:00           (%d+) чел%.")
        h14 = string.match(text, date.."  14:00           (%d+) чел%.")
        h15 = string.match(text, date.."  15:00           (%d+) чел%.")
        h16 = string.match(text, date.."  16:00           (%d+) чел%.")
        h17 = string.match(text, date.."  17:00           (%d+) чел%.")
        h18 = string.match(text, date.."  18:00           (%d+) чел%.")
        h19 = string.match(text, date.."  19:00           (%d+) чел%.")
        h20 = string.match(text, date.."  20:00           (%d+) чел%.")
        h21 = string.match(text, date.."  21:00           (%d+) чел%.")
        h22 = string.match(text, date.."  22:00           (%d+) чел%.")
        h23 = string.match(text, date.."  23:00           (%d+) чел%.")
        h24 = string.match(text, date.."  00:00           (%d+) чел%.")
        if h1 == nil or h2 == nil or h3 == nil or h4 == nil or h5 == nil or h6 == nil or h7 == nil or h8 == nil or h9 == nil or h10 == nil or h11 == nil or h12 == nil or h13 == nil or h14 == nil or h15 == nil or h16 == nil or h17 == nil or h18 == nil or h19 == nil or h20 == nil or h21 == nil or h22 == nil or h23 == nil or h24 == nil then
           sampAddChatMessage('Найдены не все данные. Проверьте, проверяете ли вы день, который уже прошел: {abcdef}/afhmenu » Настройка даты для проверки{ffffff}.', 0xFFFFFF)
        else
            itog = calc(h1..'+'..h2..'+'..h3..'+'..h4..'+'..h5..'+'..h6..'+'..h7..'+'..h8..'+'..h9..'+'..h10..'+'..h11..'+'..h12..'+'..h13..'+'..h14..'+'..h15..'+'..h16..'+'..h17..'+'..h18..'+'..h19..'+'..h20..'+'..h21..'+'..h22..'+'..h23..'+'..h24)
            sampAddChatMessage('Количеств инвайтов у '..head..'{FFFFFF}: {a2c2e2}'..itog..'{FFFFFF}.', 0xFFFFFF)
        end
    end

        if find_sessions_one then
            if title:find("Анализ сессий") ~= nil then
                if text:find("Последние 30 сессий") then
                    if togglebutton.v then
                        setVirtualKeyDown(VK_RETURN, true)
                        setVirtualKeyDown(VK_RETURN, false)
                    else
                        sampAddChatMessage("{AFAFAF}Выбирайте пункт в диалоге с содержанием {FFFFFF}«Последние 30, пропустив N сессий аккаунта»{AFAFAF}.")
                    end
                elseif text:find("Укажите значение ") then
                    sampSendDialogResponse(id, 1, nil, propusk_one)
                    propusk_one = propusk_one + 30
                elseif text:find("Укажите текущий ник аккаунта, сесии которого вы хотите найти") then
                    sampSendDialogResponse(id, 1, nil, nick_one)
                end
            end
            if title:find("Последние 30 сессий аккаунта ") then
                local datet = {}
                datet.year = tonumber(text:match("%d+:%d+ %d+.%d+.(%d+)"))
                datet.month = tonumber(text:match("%d+:%d+ %d+.(%d+).%d+"))
                datet.day = tonumber(text:match("%d+:%d+ (%d+).%d+.%d+"))
                local datess = os.time(datet) - 24 * 60 * 60
                if text:find(date_start_one) == nil then
                    if not finded and not (datess < old_month) then
                        allses_one = text .. "\n" .. allses_one
                        sampSendDialogResponse(id, 1, nil, nil)
                    end
                    if finded then
                        allses_one = text .. "\n" .. allses_one
                        find_sessions_one = false
                        closeipfunc = true
                        sampAddChatMessage("{AFAFAF}Вся необходимая информация была получена. Были проведены необходимые подсчёты. Теперь можно увидеть итог.")
                        local dates, sred = AverageOnline(allses_one, date_start_one, date_finish_one)
                        dates_one = dates .. "\n\n" .. "Средний онлайн без учёта АФК: " .. sred
                        find_stoped_one = true
                        sampSendDialogResponse(id, 1, nil, nil)
                    end
                    if datess < old_month then
                        finded = true
                        allses_one = text .. "\n" .. allses_one
                        sampSendDialogResponse(id, 1, nil, nil)
                    end
                else
                    finded = true
                    allses_one = text .. "\n" .. allses_one
                    sampSendDialogResponse(id, 1, nil, nil)
                end
            end
            if text:find("Аккаунт с указанным вами ником не найден.") then
                find_sessions_one = false
                closeipfunc = true
                sampSendDialogResponse(id, 1, nil, nil)
                sampAddChatMessage("{AFAFAF}Аккаунт с никнеймом {FFFFFF}«" .. nick_one .. "»{AFAFAF} не найден.")
                sampAddChatMessage("{AFAFAF}Вся необходимая информация была получена. Были проведены необходимые подсчёты. Теперь можно увидеть итог.")
                find_stoped_one = true
            end
            if text:find("Сессии по указанным вами параметрам не найдены.") then
                find_sessions_one = false
                closeipfunc = true
                sampSendDialogResponse(id, 1, nil, nil)
                sampAddChatMessage("{AFAFAF}У аккаунта «{FFFFFF}" .. nick_one .. "»{AFAFAF} были найдены не все сессии.")
                sampAddChatMessage("{AFAFAF}Вся необходимая информация была получена. Были проведены необходимые подсчёты. Теперь можно увидеть итог.")
                find_stoped_one = true
            end
        end
        if find_sessions_all then
            if title:find("Анализ сессий") ~= nil then
                if text:find("Последние 30 сессий") then
                    if togglebutton.v then
                        setVirtualKeyDown(VK_RETURN, true)
                        setVirtualKeyDown(VK_RETURN, false)
                    else
                        sampAddChatMessage("{AFAFAF}Выбирайте пункт в диалоге с содержанием {FFFFFF}«Последние 30, пропустив N сессий аккаунта»{AFAFAF}.")
                    end
                elseif text:find("Укажите значение ") then
                    sampSendDialogResponse(id, 1, nil, propusk_all)
                    propusk_all = propusk_all + 30
                elseif text:find("Укажите текущий ник аккаунта, сесии которого вы хотите найти") then
                    sampSendDialogResponse(id, 1, nil, nick_all)
                end
            end
            if title:find("Последние 30 сессий аккаунта ") then
                local datet = {}
                datet.year = tonumber(text:match("%d+:%d+ %d+.%d+.(%d+)"))
                datet.month = tonumber(text:match("%d+:%d+ %d+.(%d+).%d+"))
                datet.day = tonumber(text:match("%d+:%d+ (%d+).%d+.%d+"))
                local datess = os.time(datet) - 24 * 60 * 60
                if text:find(date_start_all) == nil then
                    if not finded and not (datess < old_month) then
                        allses_all = text .. "\n" .. allses_all
                        sampSendDialogResponse(id, 1, nil, nil)
                    end
                    if finded then
                        finded = false
                        allses_all = text .. "\n" .. allses_all
                        find_nick_id = find_nick_id + 1
                        new_nick, find_sessions_all, propusk_all = true, false, 0
                        all_admins[nick_all]["sessions"] = allses_all
                        all_admins[nick_all]["dates"], all_admins[nick_all]["average_online"] = AverageOnline(allses_all, date_start_all, date_finish_all)
                        sampSendDialogResponse(id, 1, nil, nil)
                    end
                    if (datess < old_month) then
                        finded = true
                        allses_all = text .. "\n" .. allses_all
                        sampSendDialogResponse(id, 1, nil, nil)
                    end
                else
                    finded = true
                    allses_all = text .. "\n" .. allses_all
                    sampSendDialogResponse(id, 1, nil, nil)
                end
            end
            if text:find("Аккаунт с указанным вами ником не найден.") then
                find_nick_id = find_nick_id + 1
                new_nick, find_sessions_all, propusk_all = true, false, 0
                all_admins[nick_all]["sessions"] = allses_all
                all_admins[nick_all]["average_online"] = "не найден"
                all_admins[nick_all]["dates"] = "не найден"
                sampAddChatMessage("{AFAFAF}Аккаунт с никнеймом {FFFFFF}«" .. nick_all .. "»{AFAFAF} не найден.", 0xe3256d)
                sampSendDialogResponse(id, 1, nil, nil)
            end
            if text:find("Сессии по указанным вами параметрам не найдены.") then
                find_nick_id = find_nick_id + 1
                new_nick, find_sessions_all, propusk_all = true, false, 0
                all_admins[nick_all]["sessions"] = allses_all
                sampAddChatMessage("{AFAFAF}У аккаунта «{FFFFFF}" .. nick_all .. "»{AFAFAF} были найдены не все сессии.", 0xe3256d)
                sampSendDialogResponse(id, 1, nil, nil)
            end
        end
end

function sampev.onSendDialogResponse(dialogId, button, listboxId, input)
        if find_text_one or find_text_all then
            if dialogId == 550 and listboxId ~= 4 then
                togglebutton.v = false
            end
        end
        if closeipfunc then
            if dialogId == 550 and button == 0 then
                closeipfunc = false
                main_window.v = true
                imgui.Process = true
            end
        end
end

function imgui.OnDrawFrame()
    
    local sw, sh = getScreenResolution()
        if not main_window.v then
            imgui.Process = false
        end

        if main_window.v then

            imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.SetNextWindowSize(imgui.ImVec2(900, 500), imgui.Cond.FirstUseEver)
            imgui.Begin(u8"Online Count", main_window)

            imgui.BeginChild('up_menu', imgui.ImVec2(0, 40), true)
                imgui.Text('               ');imgui.SameLine();
                if imgui.Button("  "  .. u8(" НАСТРОЙКИ "), imgui.ImVec2(200, 30)) then
                    imgui_menu = 1
                end
                imgui.SameLine();imgui.Text('               ');imgui.SameLine();
                if imgui.Button("  " .. u8(" ПОДСЧЁТ ПО НИКУ "), imgui.ImVec2(200, 30)) then
                    imgui_menu = 2
                end
                imgui.SameLine();imgui.Text('               ');imgui.SameLine();
                if imgui.Button("  "  .. u8(" ПОДСЧЁТ ПО СПИСКУ "), imgui.ImVec2(200, 30)) then
                    imgui_menu = 3
                end
            imgui.EndChild()

            if imgui_menu == 1 then
                imgui.BeginChild('settings_menu', imgui.ImVec2(0, 60), true)
                imgui.Text(u8("Автоматически нажимать на ENTER — "))
                imgui.SameLine()
                if imgui.ToggleButton("auto enter", togglebutton) and togglebutton.v then
                    sampAddChatMessage('{AFAFAF}Выбирайте пункт в диалоге с содержанием {FFFFFF}«Последние 30, пропустив N сессий аккаунта»{AFAFAF} и закройте диалоговое окно.')
                    main_window.v = false
                    closeipfunc = true
                    sampSendChat("/ipfunc")
                end

                imgui.Text(u8("Выводить в чат чьи записываются сессии — "))
                imgui.SameLine()
                imgui.ToggleButton(u8"чьи сессии", togglebutton2)

                imgui.EndChild()

                imgui.BeginChild('nicks', imgui.ImVec2(0, 0), true)
                settings_buf.v = u8(database["admins"])
                imgui.Text(u8("Введите в список никнеймы, онлайн которых вы желаете посчитать."))
                imgui.InputTextMultiline(u8'', settings_buf, imgui.ImVec2(870, 345))
                if database["admins"] ~= settings_buf.v then
                    database["admins"] = settings_buf.v
                    local msg_save = io.open("moonloader/config/online_counter.json", "w")
                    msg_save:write(encodeJson(database))
                    msg_save:close()
                end
                imgui.EndChild()

            elseif imgui_menu == 2 then
                imgui.BeginChild('one_nick_settings', imgui.ImVec2(450, 0), true)
                imgui.PushItemWidth(200)
                imgui.InputText(u8"Никнейм.", buf_nickname)
                if buf_nickname.v:find("%a+_%a+") ~= nil then
                    nick_one = buf_nickname.v
                    nick_one = nick_one:match("%a+_%a+")
                end
                imgui.PushItemWidth(100)
                imgui.InputText(u8(""), buf_date_start_one)
                if buf_date_start_one.v:find("%d+.%d+.%d+") ~= nil then
                    date_start_one = buf_date_start_one.v
                    date_start_one = date_start_one:match("(%d+.%d+.%d+)")
                end
                imgui.SameLine();imgui.Text(u8" - "); imgui.SameLine()
                imgui.PushItemWidth(100)
                imgui.InputText(u8(" "), buf_date_finish_one)
                if buf_date_start_one.v:find("%d+.%d+.%d+") ~= nil then
                    date_finish_one = buf_date_finish_one.v
                    date_finish_one = date_finish_one:match("(%d+.%d+.%d+)")
                end
                if date_start_one ~= "" and date_finish_one ~= "" and nick_one ~= "" then
                    if imgui.Button(u8"Сосчитать", imgui.ImVec2(0, 0)) then
                        main_window.v = false
                        date_start_one = get_ipfunc_date(date_start_one)
                        date_finish_one = get_ipfunc_date(date_finish_one)
                        finded = false
                        find_sessions_one = true
                        allses_one = ""
                        propusk_one = 0
                        local datet = {}
                        datet.day = tonumber(date_start_one:match("(%d+).%d+.%d+"))
                        datet.month = tonumber(date_start_one:match("%d+.(%d+).%d+"))
                        datet.year = tonumber(date_start_one:match("%d+.%d+.(%d+)"))
                        old_month = os.time(datet) - 24 * 60 * 60
                        sampSendChat("/ipfunc")
                    end
                end
                imgui.EndChild()
                imgui.SameLine()
                imgui.BeginChild('one_nick_count', imgui.ImVec2(0, 0), true)
                imgui.Text(u8("Никнейм: " .. nick_one))
                if date_start_one ~= "" and date_finish_one ~= "" and date_start_one ~= nil and date_finish_one ~= nil then
                    imgui.Text(u8(date_start_one .. " — " .. date_finish_one))
                end
                imgui.Text(u8(dates_one))
                imgui.EndChild()
            elseif imgui_menu == 3 then
                imgui.BeginChild('up_menu2', imgui.ImVec2(0, 40), true)
                imgui.PushItemWidth(100)
                imgui.InputText(u8(""), buf_date_start_all)
                if buf_date_start_all.v:find("%d+.%d+.%d+") ~= nil then
                    date_start_all = buf_date_start_all.v
                    date_start_all = date_start_all:match("(%d+.%d+.%d+)")
                end
                imgui.SameLine();imgui.Text(u8" - "); imgui.SameLine()
                imgui.PushItemWidth(100)
                imgui.InputText(u8(" "), buf_date_finish_all)
                if buf_date_start_all.v:find("%d+.%d+.%d+") ~= nil then
                    date_finish_all = buf_date_finish_all.v
                    date_finish_all = date_finish_all:match("(%d+.%d+.%d+)")
                end
                imgui.SameLine()
                if date_start_all ~= "" and date_finish_all ~= "" then
                    if imgui.Button(u8"Найти сессии", imgui.ImVec2(0, 0)) then
                        sampSendChat("/ipfunc")
                        date_start_all = get_ipfunc_date(date_start_all)
                        date_finish_all = get_ipfunc_date(date_finish_all)
                        new_nick = true
                        show_ses_flag = false
                        find_nick_id = 0
                        main_window.v = false
                        local datet = {}
                        datet.day = tonumber(date_start_all:match("(%d+).%d+.%d+"))
                        datet.month = tonumber(date_start_all:match("%d+.(%d+).%d+"))
                        datet.year = tonumber(date_start_all:match("%d+.%d+.(%d+)"))
                        old_month = os.time(datet) - 24 * 60 * 60
                    end
                    if show_ses_flag then
                        imgui.SameLine()
                        if imgui.Button(u8"Очистить", imgui.ImVec2(0, 0)) then
                            show_ses_flag, new_nick, find_sessions_all, finded, old_month, nick_all, allses_all, dates_all, propusk_all, find_nick_id = false, false, false, false, "", "", "", "", 0, 0
                        end
                    end
                end
                imgui.EndChild()
                imgui.BeginChild('all_nicks', imgui.ImVec2(450, 0), true)
                if show_ses_flag then
                    for nicks in (database["admins"]):gmatch("[^\n]+") do
                        if imgui.Button(u8(nicks), imgui.ImVec2(150, 0)) then
                            dates_all = "Никнейм: " .. nicks .. "\nПериод подсчёта: " .. date_start_all .. " — " .. date_finish_all .. "\n\n"
                            dates_all = dates_all .. all_admins[nicks]["dates"] .. "\nСредний онлайн без учёта АФК: " .. all_admins[nicks]["average_online"] 
                        end
                        imgui.SameLine()
                        imgui.Text(u8("Средний онлайн без учёта АФК: " .. all_admins[nicks]["average_online"]))
                    end
                end
                imgui.EndChild()
                imgui.SameLine()
                imgui.BeginChild('nicks_sessions', imgui.ImVec2(0, 0), true)
                imgui.Text(u8(dates_all))
                imgui.EndChild()
            end
            imgui.End()
        end
end

function calc(str)
    return assert(load("return " .. str))()
end

function cmd_fleader()
    local request = requests.get('https://pastebin.com/raw/75MnJSxF')
        for n in request.text:gmatch('[^\r\n]+') do
            sampAddChatMessage(u8:decode(n), 0xFFFFFF)
        end
end
