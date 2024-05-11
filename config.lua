Config = {}

Config.keys = {
    confirm = {191, 'Enter'},
    cancel = {73, 'X'},
    rleft = {44, 'Q'},
    rright = {38, 'E'},
    up = {45, 'R'},
    down = {23, 'F'},
    left = {34, 'A'},
    right = {35, 'D'},
    forward = {32, 'W'},
    backward = {33, 'S'}
}

Config.Translations = {
    ['title'] = 'Adjust animation',
    ['no_anim'] = 'Use animation first!',
    keys = {
        ['X'] = 'Cancel',
        ['Enter'] = 'Confirm',
        ['Q'] = 'Rot. left',
        ['E'] = 'Rot. right',
        ['R'] = 'Up',
        ['F'] = 'Down',
        ['A'] = 'Left',
        ['D'] = 'Right',
        ['W'] = 'Forward',
        ['S'] = 'Backward'
    }
}

Config.command = 'adjust'

Config.setupPed = function(ped)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end

Config.maxDistance = 30

Config.rotateSpeed = 5

Config.movementSpeed = 0.05

Config.cloneAlpha = 204

Config.returnToStart = true

Config.walkToPosition = true

Config.getCurrentAnimation = function()
    if GetResourceState('scully_emotemenu') == 'started' then
        local data, lastVariant = exports.scully_emotemenu:getLastEmote()
        if not data then return end
        local movementFlag = cache.vehicle and 51 or 0
        if not cache.vehicle and data.Options.Flags then
            if data.Options.Flags.Loop then movementFlag = 1 end
            if data.Options.Flags.Move then movementFlag = 51 end
            if data.Options.Flags.Stuck then movementFlag = 50 end
        end
        if not IsEntityPlayingAnim(cache.ped, data.Dictionary, data.Animation, 3) then return end
        return {
            dict = data.Dictionary,
            anim = data.Animation,
            flag = movementFlag,
            command = 'e ' .. data.Command
        }
    elseif GetResourceState('rpemotes') == 'started' then
        --[[
            =================================================================================================
            Make sure you are using the modified version that is required for the script to function properly
                                            https://docs.pixelprecision.dev
            =================================================================================================
        ]]
        local data = exports.rpemotes:getCurrentEmote()
        if not data then return end
        local MovementType = cache.vehicle and 51 or 0
        if data.AnimationOptions then
            if data.AnimationOptions.EmoteLoop then
                MovementType = 1
                if data.AnimationOptions.EmoteMoving then
                    MovementType = 51
                end
    
            elseif data.AnimationOptions.EmoteMoving then
                MovementType = 51
            elseif data.AnimationOptions.EmoteMoving == false then
                MovementType = 0
            elseif data.AnimationOptions.EmoteStuck then
                MovementType = 50
            end
    
        else
            MovementType = 0
        end
    
        if InVehicle == 1 then
            MovementType = 51
        end
        if not IsEntityPlayingAnim(cache.ped, data[1], data[2], 3) then return end
        return {
            dict = data[1],
            anim = data[2],
            flag = MovementType,
            command = 'e ' .. data[4]
        }
    end
end

Config.Notify = function(message)
    lib.notify({
        title = 'Adjust animation',
        description = message,
        type = 'info'
    })
end