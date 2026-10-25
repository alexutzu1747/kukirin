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
TextButton.Text = "Spin cu Trotineta (300$)"
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
        
        -- Căutăm trotineta în inventar, în caracter sau în vehiculele active
        local vehicle = nil
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Tool") then
                vehicle = obj
                break
            end
        end
        
        -- Dacă nu e în caracter, o căutăm în Workspace după nume
        if not vehicle then
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj.Name:lower()..find("kukirin") or obj.Name:lower()..find("scooter") or obj.Name:lower()..find("bike") then
                    if obj:FindFirstChild("HumanoidRootPart") or obj:IsA("Model") then
                        vehicle = obj
                        break
                    end
                end
            end
        end
        
        local originalCFrame = root.CFrame
        if vehicle and vehicle:IsA("Model") and vehicle.PrimaryPart then
            originalCFrame = vehicle.PrimaryPart.CFrame
        end
        
        local startTime = tick()
        local duration = 1.2
        
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            local currentAngle = alpha * 59.3 
            local heightOffset = math.sin(alpha * math.pi) * 15 
            
            local newCFrame = originalCFrame + Vector3.new(0, heightOffset, 0)
            
            -- Dacă am găsit vehiculul, mișcăm vehiculul cu totul (te ține pe el)
            if vehicle and vehicle:IsA("Model") and vehicle.PrimaryPart then
                vehicle:SetPrimaryPartCFrame(newCFrame * CFrame.Angles(0, currentAngle, 0))
            else
                -- Variantă alternativă: urcăm ambele elemente dacă sunt separate
                root.CFrame = newCFrame * CFrame.Angles(0, currentAngle, 0)
            end
            
            task.wait()
        end
        
        -- Revenire la sol
        if vehicle and vehicle:IsA("Model") and vehicle.PrimaryPart then
            vehicle:SetPrimaryPartCFrame(originalCFrame)
        else
            root.CFrame = originalCFrame
        end
    end
    
    task.wait(0.5)
    isRunning = false
end)


