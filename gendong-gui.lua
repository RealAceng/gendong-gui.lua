-- Gendong GUI by ChatGPT
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "GendongGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.05, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local GendongBtn = Instance.new("TextButton", Frame)
GendongBtn.Size = UDim2.new(1, 0, 0, 50)
GendongBtn.Position = UDim2.new(0, 0, 0, 0)
GendongBtn.Text = "👤 Gendong"
GendongBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
GendongBtn.TextColor3 = Color3.new(1, 1, 1)
GendongBtn.Font = Enum.Font.SourceSansBold
GendongBtn.TextSize = 20

local LepasBtn = Instance.new("TextButton", Frame)
LepasBtn.Size = UDim2.new(1, 0, 0, 50)
LepasBtn.Position = UDim2.new(0, 0, 0, 60)
LepasBtn.Text = "❌ Lepas"
LepasBtn.BackgroundColor3 = Color3.fromRGB(178, 34, 34)
LepasBtn.TextColor3 = Color3.new(1, 1, 1)
LepasBtn.Font = Enum.Font.SourceSansBold
LepasBtn.TextSize = 20

-- Function Gendong
local Weld = nil

GendongBtn.MouseButton1Click:Connect(function()
    local target = nil

    -- Cari target terdekat
    local shortest = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if distance < shortest then
                shortest = distance
                target = player
            end
        end
    end

    if target then
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if targetHRP and myHRP then
            Weld = Instance.new("WeldConstraint", myHRP)
            Weld.Part0 = myHRP
            Weld.Part1 = targetHRP
            targetHRP.CFrame = myHRP.CFrame * CFrame.new(0, 0, -2)
        end
    end
end)

-- Function Lepas
LepasBtn.MouseButton1Click:Connect(function()
    if Weld then
        Weld:Destroy()
        Weld = nil
    end
end)
