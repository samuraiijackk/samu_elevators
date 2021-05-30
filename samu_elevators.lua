ESX = nil
PlayerData = {}
local zekimuren = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function openActionMenu()
    local ped = PlayerPedId()
    local elements = {
        {label = 'Garaj', value = 'up'},
        {label = 'Lobi', value = 'down'},
        {label = 'Çatı', value = 'braha'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'elevator_actions', {
        title = 'Asansör',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'up' then
            biniliyor = true
            DoScreenFadeOut(2000)
            exports['mythic_progbar']:Progress({
                name = "elevatorgarage",
                duration = 5000,
                label = 'Asansöre Biniyorsun..',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(cancelled)
                if not cancelled then
                    biniliyor = false
                    SetEntityCoords(ped, 344.72, -586.43, 28.08, false, false, false, true) --GARAGE
                    ClearPedTasksImmediately(ped)
                    DoScreenFadeIn(3000)
                else
                    biniliyor = false
                    ClearPedTasksImmediately(ped)
                    DoScreenFadeIn(3000)
                end
            end)
        elseif data.current.value == 'down' then
            biniliyor2 = true
            DoScreenFadeOut(2000)
            exports['mythic_progbar']:Progress({
                name = "elevatorgarage",
                duration = 5000,
                label = 'Asansöre Biniyorsun..',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(cancelled)
                if not cancelled then
                    biniliyor2 = false
                    SetEntityCoords(ped, 330.15, -601.01, 43.29, false, false, false, true) --LOBBY
                    ClearPedTasksImmediately(ped)
                    DoScreenFadeIn(3000)
                else
                    biniliyor2 = false
                    ClearPedTasksImmediately(ped)
                    DoScreenFadeIn(3000)
                end
            end)
        elseif data.current.value == 'braha' then
            biniliyor3 = true
            DoScreenFadeOut(2000)
            exports['mythic_progbar']:Progress({
                name = "elevatorgarage",
                duration = 5000,
                label = 'Asansöre Biniyorsun..',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(cancelled)
                if not cancelled then
                    biniliyor3 = false
                    SetEntityCoords(ped, 338.68, -583.69, 74.17, false, false, false, true) --HELICOPTERS
                    ClearPedTasksImmediately(ped)
                    DoScreenFadeIn(3000)
                else
                    biniliyor3 = false
                    ClearPedTasksImmediately(ped)
                    DoScreenFadeIn(3000)
                end
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local getcoords = GetEntityCoords(ped)
        local inRange = false
        
        for k,v in pairs(Config.GetInCoords) do
            local dst = GetDistanceBetweenCoords(getcoords, v[1], v[2], v[3], true)

            if dst < 3.0 then
                --exports['mythic_notify']:DoHudText('success', 'DST WORKING!')
                inRange = true
                DrawText3Ds(v.x, v.y, v.z, "[E] Asansor")
                if IsControlJustReleased(0, 38) then
                    openActionMenu()
                end
            end
        end
        if not inRange then
            ESX.UI.Menu.CloseAll()
            Citizen.Wait(2000)
        end
    end 
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end



    

    

