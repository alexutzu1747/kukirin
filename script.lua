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
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local originalCFrame = root.CFrame
        local startTime = tick()
        local duration = 1.0 
        
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            local currentAngle = alpha * 59.3 
            local heightOffset = math.sin(alpha * math.pi) * 30 
            
            root.CFrame = originalCFrame + Vector3.new(0, heightOffset, 0) * CFrame.Angles(0, currentAngle, 0)
            task.wait()
        end
        
        task.wait(1.0)
        root.CFrame = originalCFrame
    end
    
    isRunning = false
end)
