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
TextButton.Text = "Sari cu Trotineta (300$)"
TextButton.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = TextButton

local isRunning = false

TextButton.MouseButton1Click:Connect(function()
    if isRunning then return end
    isRunning = true
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local originalCFrame = root.CFrame
        
        -- Căutăm trotineta (poate fi unelte în caracter sau un model atașat)
        local scooter = char:FindFirstChild("Scooter") or char:FindFirstChild("Kukirin") or char:FindFirstChildOfClass("Model")
        
        local startTime = tick()
        local duration = 1.2 -- Durata mișcării în aer
        
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            local currentAngle = alpha * 59.3 -- Câte rotații (spin) să facă
            local heightOffset = math.sin(alpha * math.pi) * 15 -- Înălțimea la care urcă (cu tot cu trotinetă)
            
            -- Ridicăm și rotim jucătorul împreună cu tot ce deține
            local newCFrame = originalCFrame + Vector3.new(0, heightOffset, 0)
            root.CFrame = newCFrame * CFrame.Angles(0, currentAngle, 0)
            
            -- Dacă trotineta e separat în caracter, o mișcăm și pe ea odată cu root-ul
            if scooter and scooter:IsA("Model") and scooter.PrimaryPart then
                scooter:SetPrimaryPartCFrame(root.CFrame)
            end
            
            task.wait()
        end
        
        -- Revenire la sol la poziția inițială
        root.CFrame = originalCFrame
    end
    
    task.wait(0.5)
    isRunning = false
end)


