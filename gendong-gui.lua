-- Gendong di Pundak - GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "GendongPundakGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.05, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

local GendongBtn = Instance.new("TextButton", Frame)
GendongBtn.Size = UDim2.new(1, 0, 0, 50)
GendongBtn.Position = UDim2.new(0, 0, 0, 0)
GendongBtn.Text = "👤 Gendong di Pundak"
GendongBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
GendongBtn.TextColor3 = Color3.new(1, 1, 1)
GendongBtn.Font = Enum.Font.SourceSansBold
GendongBtn.TextSize = 18

local LepasBtn = Instance.new("TextButton", Frame)
LepasBtn.Size = UDim2.new(1, 0, 0, 50)
LepasBtn.Position = UDim2.new(0, 0, 0, 60)
LepasBtn.Text = "❌ Lepas"
LepasBtn.BackgroundColor3 = Color3.fromRGB(178, 34, 34)
LepasBtn.TextColor3 = Color3.new(1, 1, 1)
LepasBtn.Font = Enum.Font.SourceSansBold
LepasBtn.TextSize = 18

-- Variabel penyimpanan weld
local Weld = nil
local TargetChar = nil

-- Fungsi Gendong
GendongBtn.MouseButton1Click:Connect(function()
    local target = nil
    local shortest = math.huge

    -- Cari player terdekat
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
        TargetChar = target.Character
        local targetHRP = TargetChar:FindFirstChild("HumanoidRootPart")
        local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if targetHRP and myHRP then
            -- Buat WeldConstraint agar target nempel di pundak
            Weld = Instance.new("WeldConstraint", myHRP)
            Weld.Part0 = myHRP
            Weld.Part1 = targetHRP
            -- Atur posisi target di atas pundak
            targetHRP.CFrame = myHRP.CFrame * CFrame.new(0, 2, 0)
        end
    end
end)

-- Fungsi Lepas
LepasBtn.MouseButton1Click:Connect(function()
    if Weld then
        Weld:Destroy()
        Weld = nil
        if TargetChar and TargetChar:FindFirstChild("HumanoidRootPart") then
            -- Bikin target jatuh
            local bodyVelocity = Instance.new("BodyVelocity", TargetChar.HumanoidRootPart)
            bodyVelocity.Velocity = Vector3.new(0, -50, 0) -- Dorong ke bawah
            game.Debris:AddItem(bodyVelocity, 0.2)
        end
        TargetChar = nil
    end
end)
