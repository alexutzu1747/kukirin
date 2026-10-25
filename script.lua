local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Simulare mică de salt și rotire prin impuls fizic
rootPart.Velocity = Vector3.new(0, 50, 0)
for i = 1, 15 do
    rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(24), 0)
    task.wait(0.03)
end

