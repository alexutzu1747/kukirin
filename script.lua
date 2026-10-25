local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("KukirinHelper") then
    PlayerGui.KukirinHelper:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KukirinHelper"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Position = UDim2.new(0, 50, 0, 200)
TextButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 18
TextButton.Font = Enum.Font.SourceSansBold
TextButton.Text = "Sari & Spin (300$)"
TextButton.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = TextButton

local isRunning = false

TextButton.MouseButton1Click:Connect(function()
    if isRunning then return end
    isRunning = true
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        
        if humanoid and root then
            -- Forțăm o săritură reală
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            
            -- Facem rotirea (spin) rapidă în aer
            local startTime = tick()
            local duration = 1.5 -- 1.5 secunde de rotire
            
            while tick() - startTime < duration do
                -- Rotim caracterul treptat pe axa Y
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(45), 0)
                task.wait(0.03)
            end
        end
    end
    
    task.wait(0.5)
    isRunning = false
end)

