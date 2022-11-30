local player = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ss = getgenv().CrosshairSettings
local middle = Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2)

if typeof(Drawing.new) ~= "function" then
    msg("Your exploit does not have a Drawing Library",5)
    return
end
if typeof(ss.Color) ~= "Color3" then
    msg("Invalid Color",2)
    return
end

if typeof(getgenv().crosshairobj) == "table" then
    for i,v in pairs(getgenv().crosshairobj) do
        if typeof(v) == "table" or typeof(v) == "userdata" then
            v:Remove()
        end
    end
end
if typeof(getgenv().crosshairrs) == "RBXScriptConnection" then
    getgenv().crosshairrs:Disconnect()
end
local supported = false
for i,v in next, {286090429,301549746,4292776423,292439477,299659045,4716045691,3233893879,2377868063,2555870920,4651779470,606849621,2916899287,443406476,1224212277,3527629287,388599755} do
    if game.PlaceId == v then
        supported = true
    end
end
if ss.HideGameCrosshair and not supported then
    spawn(function()
        msg("HideGameCrosshair is not available for this game. Check the source for a list of supported games",5) 
    end)
end

local line1 = Drawing.new("Line") -- Top Line
local line2 = Drawing.new("Line") -- Right Line 
local line3 = Drawing.new("Line") -- Bottom Line 
local line4 = Drawing.new("Line") -- Left Line
local dot = Drawing.new("Square") -- garbage dot
getgenv().crosshairobj = {line1 = line1,line2 = line2,line3 = line3,line4 = line4}
line1.Visible = true
line2.Visible = true
line3.Visible = true
line4.Visible = true

game:GetService("UserInputService").InputBegan:Connect(function(i,gp)
    if i.KeyCode == ss.ToggleKey and not gp and line1 and line2 and line3 and line4 then
        line1.Visible = not line1.Visible
        line2.Visible = not line2.Visible
        line3.Visible = not line3.Visible
        line4.Visible = not line4.Visible
    end
end)

getgenv().crosshairrs = RunService.RenderStepped:Connect(function()
    ss = getgenv().CrosshairSettings
    if ss.HideMouseIcon ~= 0 then
        if ss.HideMouseIcon then
            UIS.MouseIconEnabled = false
        else
            UIS.MouseIconEnabled = true
        end
    end
    if ss.FollowCursor then
        middle = UIS:GetMouseLocation()
    else
        middle = Vector2.new(camera.ViewportSize.X/2,camera.ViewportSize.Y/2)
    end
    line1.Transparency = ss.Opacity
    line2.Transparency = ss.Opacity
    line3.Transparency = ss.Opacity
    line4.Transparency = ss.Opacity
    line1.Thickness = ss.Thickness
    line2.Thickness = ss.Thickness
    line3.Thickness = ss.Thickness
    line4.Thickness = ss.Thickness
    line1.Color = ss.Color
    line2.Color = ss.Color
    line3.Color = ss.Color
    line4.Color = ss.Color
    if ss.RainbowColor then
        line1.Color = Color3.fromHSV(tick()%5/5,1,1)
        line2.Color = Color3.fromHSV(tick()%5/5,1,1)
        line3.Color = Color3.fromHSV(tick()%5/5,1,1)
        line4.Color = Color3.fromHSV(tick()%5/5,1,1)
        dot.Color = Color3.fromHSV(tick()%5/5,1,1)
    end
    
    line1.From = Vector2.new(middle.X,middle.Y-ss.Offset)
    line2.From = Vector2.new(middle.X+ss.Offset,middle.Y)
    line3.From = Vector2.new(middle.X,middle.Y+ss.Offset)
    line4.From = Vector2.new(middle.X-ss.Offset,middle.Y)
    line1.To = Vector2.new(middle.X,middle.Y-ss.Offset-ss.Length)
    line2.To = Vector2.new(middle.X+ss.Offset+ss.Length,middle.Y)
    line3.To = Vector2.new(middle.X,middle.Y+ss.Offset+ss.Length)
    line4.To = Vector2.new(middle.X-ss.Offset-ss.Length,middle.Y)
end)
