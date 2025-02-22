ESX = exports["es_extended"]:getSharedObject()

local isWorking = false
local currentTask = nil
local blip = nil
local jobVehicle = nil
local playerJob = nil
local isWearingWorkClothes = false
local startBlip = nil
local taskBlips = {}

function CreateStartBlip()
    if startBlip then
        RemoveBlip(startBlip)
    end

    local coords = Config.Job.StartLocation

    startBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(startBlip, 85)
    SetBlipDisplay(startBlip, 4)
    SetBlipScale(startBlip, 0.8)
    SetBlipColour(startBlip, 2) -- Grün
    SetBlipAsShortRange(startBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Translation[Config.Locale]['menu_name'])
    EndTextCommandSetBlipName(startBlip)
end

function CreateTaskBlips(taskIndex)
    RemoveTaskBlips()

    if not Config.Job.Tasks[taskIndex] then return end

    for i = currentSubTask, #Config.Job.Tasks[taskIndex].tasks do
        local subTask = Config.Job.Tasks[taskIndex].tasks[i]
        local blip = AddBlipForCoord(subTask.location.x, subTask.location.y, subTask.location.z)
        SetBlipSprite(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Translation[Config.Locale]['menu_task'] .. i)
        EndTextCommandSetBlipName(blip)

        table.insert(taskBlips, blip)
    end
end

function RemoveTaskBlips()
    for _, blip in ipairs(taskBlips) do
        RemoveBlip(blip)
    end
    taskBlips = {}
end

CreateStartBlip()

function CheckJob()
    ESX.TriggerServerCallback('lawnmower:getPlayerJob', function(job)
        playerJob = job
    end)
end

function SetWorkClothes()
    local playerPed = PlayerPedId()
    local gender = IsPedMale(playerPed) and "male" or "female"
    local clothes = Config.Job.WorkClothes[gender]

    for _, component in ipairs(clothes.components) do
        SetPedComponentVariation(playerPed, component.component_id, component.drawable, component.texture, 0)
    end
    for _, prop in ipairs(clothes.props) do
        SetPedPropIndex(playerPed, prop.prop_id, prop.drawable, prop.texture, true)
    end
    isWearingWorkClothes = true
    ESX.ShowNotification(Translation[Config.Locale]['clothe_on'])
end

function ResetClothes()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    isWearingWorkClothes = false
    ESX.ShowNotification(Translation[Config.Locale]['clothe_off'])
end

function SpawnJobVehicle()
    local vehicles = GetVehiclesInArea(Config.Job.VehicleSpawn.x, Config.Job.VehicleSpawn.y, Config.Job.VehicleSpawn.z, 5.0)

    if #vehicles > 0 then
        ESX.ShowNotification(Translation[Config.Locale]['spawn_err'])
        return
    end

    local vehicleHash = GetHashKey(Config.Job.VehicleModel)
    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Citizen.Wait(10)
    end

    jobVehicle = CreateVehicle(vehicleHash, Config.Job.VehicleSpawn.x, Config.Job.VehicleSpawn.y, Config.Job.VehicleSpawn.z, Config.Job.VehicleSpawn.w, true, false)
    SetVehicleOnGroundProperly(jobVehicle)
    SetVehicleNumberPlateText(jobVehicle, Config.Job.VehiclePlate)
    SetEntityAsMissionEntity(jobVehicle, true, true)
end

function GetVehiclesInArea(x, y, z, radius)
    local vehicles = {}
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local nearbyVehicles = GetClosestVehicles(x, y, z, radius)

    for _, vehicle in ipairs(nearbyVehicles) do
        if DoesEntityExist(vehicle) then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

function GetClosestVehicles(x, y, z, radius)
    local vehicles = {}
    local vehHandle = FindFirstVehicle()
    local found, veh = FindNextVehicle(vehHandle)

    while found do
        local dist = #(vector3(x, y, z) - GetEntityCoords(veh))
        if dist < radius then
            table.insert(vehicles, veh)
        end
        found, veh = FindNextVehicle(vehHandle)
    end
    EndFindVehicle(vehHandle)
    return vehicles
end

local lastTask = nil

function StartRandomMission()
    CheckJob() 
    isWorking = true

    local newTask
    repeat
        newTask = math.random(1, #Config.Job.Tasks)
    until newTask ~= lastTask

    lastTask = newTask
    currentTask = newTask
    currentSubTask = 1
    local taskData = Config.Job.Tasks[currentTask]

    CreateTaskBlip(taskData.mainLocation, Translation[Config.Locale]['job_main'])
    CreateTaskBlips(currentTask)

    ESX.ShowNotification(Translation[Config.Locale]['job_back'])
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        CheckJob()
    end
end)

function StopJob()
    isWorking = false
    currentTask = nil
    currentSubTask = 1
    RemoveBlip(blip) 
    RemoveTaskBlips() 
    ESX.ShowNotification(Translation[Config.Locale]['job_quit'])
end

function CreateTaskBlip(coords)
    RemoveBlip(blip) 
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 466)
    SetBlipColour(blip, 5)
    SetBlipRoute(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Translation[Config.Locale]['menu_task'])
    EndTextCommandSetBlipName(blip)
end

function CheckTaskCompletion()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    if currentTask and currentSubTask then
        local task = Config.Job.Tasks[currentTask].tasks[currentSubTask]

        if #(playerCoords - task.location) < 0.5 then
            if task.type == "mow" then
                TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_LEAF_BLOWER", 0, true)
            elseif task.type == "weed" then
                TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
            elseif task.type == "check" then
                TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, true)
            end

            Citizen.Wait(task.time)
            ClearPedTasks(playerPed)

            RemoveTaskBlips()
            currentSubTask = currentSubTask + 1

            if currentSubTask > #Config.Job.Tasks[currentTask].tasks then
                TriggerServerEvent('lawnmower:completeTask', Config.Job.Payment)
                ESX.ShowNotification(Translation[Config.Locale]['job_earn'] .. Config.Job.Payment .. Translation[Config.Locale]['job_earn2'])
                StopJob()
            else
                CreateTaskBlips(currentTask)
                CreateTaskBlip(Config.Job.Tasks[currentTask].tasks[currentSubTask].location, Translation[Config.Locale]['job_nexttask'])
            end
        end
    end
end

function DrawMarkers()
    if not playerJob or playerJob.name ~= Config.Job.Name then return end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local function IsNear(coords, range)
        return #(playerCoords - vector3(coords.x, coords.y, coords.z)) < range
    end

    if IsNear(Config.Job.StartLocation, 50.0) then
        DrawMarker(1, Config.Job.StartLocation.x, Config.Job.StartLocation.y, Config.Job.StartLocation.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 0, 255, 0, 200, false, true, 2, nil, nil, false)
    end

    if jobVehicle and IsPedInVehicle(playerPed, jobVehicle, false) and IsNear(Config.Job.VehicleDespawn, 50.0) then
        DrawMarker(1, Config.Job.VehicleDespawn.x, Config.Job.VehicleDespawn.y, Config.Job.VehicleDespawn.z - 1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.5, 255, 0, 0, 200, false, true, 2, nil, nil, false)
    end

    if isWorking and currentTask and currentSubTask then
        local task = Config.Job.Tasks[currentTask]
        if task and task.tasks and task.tasks[currentSubTask] then
            local taskLocation = task.tasks[currentSubTask].location
            if IsNear(taskLocation, 50.0) then
                DrawMarker(1, taskLocation.x, taskLocation.y, taskLocation.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 0, 0, 255, 200, false, true, 2, nil, nil, false)
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())

        if not playerJob then
            CheckJob()
        end

        DrawMarkers()

        if playerJob and playerJob.name == Config.Job.Name then
            if #(playerCoords - vector3(Config.Job.StartLocation.x, Config.Job.StartLocation.y, Config.Job.StartLocation.z)) < 2.0 then
                if not isWearingWorkClothes then
                    ESX.ShowHelpNotification(Translation[Config.Locale]['job_input1'])
                    if IsControlJustReleased(0, 38) then
                        SetWorkClothes()
                    end
                else
                    ESX.ShowHelpNotification(Translation[Config.Locale]['job_input2'])
                    if IsControlJustReleased(0, 47) then
                        ResetClothes()
                    end
                end
            end

            if IsControlJustReleased(0, Config.Job.StartButton) then
                if isWorking then
                    StopJob()
                else
                    if isWearingWorkClothes then
                        if jobVehicle == nil then
                            SpawnJobVehicle()
                        end
                        StartRandomMission()
                        CreateVehicleBlip(jobVehicle)
                    else
                        ESX.ShowNotification(Translation[Config.Locale]['job_clothe_err'])
                    end
                end
            end                      

            if isWorking and currentTask then
                local task = Config.Job.Tasks[currentTask]
                if CheckTaskCompletion(task) then
                    TriggerServerEvent('lawnmower:completeTask', Config.Job.Payment)
                    ESX.ShowNotification(Translation[Config.Locale]['job_earn3'] .. Config.Job.Payment .. Translation[Config.Locale]['job_earn2'])
                    StopJob()
                end
            end

            if DoesEntityExist(jobVehicle) then
                if #(playerCoords - vector3(Config.Job.VehicleDespawn.x, Config.Job.VehicleDespawn.y, Config.Job.VehicleDespawn.z)) < 5.0 then
                    ESX.ShowHelpNotification(Translation[Config.Locale]['job_car_back'])
                    if IsControlJustReleased(0, 38) then
                        DeleteVehicle(jobVehicle)
                        jobVehicle = nil
                        ESX.ShowNotification(Translation[Config.Locale]['job_car_success'])
                    end
                end
            end            
        end
    end
end)

local jobVehicleBlip = nil

function CreateVehicleBlip(vehicle)
    if DoesBlipExist(jobVehicleBlip) then
        RemoveBlip(jobVehicleBlip)
    end
    jobVehicleBlip = AddBlipForEntity(vehicle)
    SetBlipSprite(jobVehicleBlip, 227)
    SetBlipColour(jobVehicleBlip, 3)
    SetBlipScale(jobVehicleBlip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Translation[Config.Locale]['job_car'])
    EndTextCommandSetBlipName(jobVehicleBlip)
end

if DoesBlipExist(jobVehicleBlip) then
    RemoveBlip(jobVehicleBlip)
    jobVehicleBlip = nil
end

function ReturnVehicle()
    if jobVehicle and IsPedInVehicle(PlayerPedId(), jobVehicle, false) then
        ESX.ShowNotification(Translation[Config.Locale]['job_car_back_nof'])
        DeleteEntity(jobVehicle)
        if DoesBlipExist(jobVehicleBlip) then
            RemoveBlip(jobVehicleBlip)
            jobVehicleBlip = nil
        end
        jobVehicle = nil
    end
end

