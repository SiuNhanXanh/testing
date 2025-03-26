return function(Settings)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")


    if Settings.AutoFarm then
        print("Auto Farm Đã Bật!")

    
        function SmoothTP(Character, TargetPos)
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                local HRP = Character.HumanoidRootPart
                local Goal = {Position = TargetPos}
                local TweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear) -- Dịch chuyển chậm 1.5 giây
                local Tween = TweenService:Create(HRP, TweenInfo, Goal)
                Tween:Play()
            end
        end

     
        RunService.RenderStepped:Connect(function()
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local Enemy = nil
                local MinDistance = math.huge

                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
                        if Distance < MinDistance then
                            MinDistance = Distance
                            Enemy = v
                        end
                    end
                end


                if Enemy then
                    SmoothTP(LocalPlayer.Character, Enemy.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
                    
           
                    if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                        LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                        wait(math.random(0.3, 0.7)) -- Delay để tránh bị phát hiện
                    end
                end
            end
        end)
    end
end
