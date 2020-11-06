local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("york_cocaina")
--https://github.com/eboraci
--York#2030
--discord: https://discord.gg/fK5c6V5
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = { 

	{ ['id'] = 1, ['x'] = -1105.13, ['y'] = 4952.35, ['z'] = 218.65, ['text'] = "colocar a cocaína na vasilha", ['perm'] = "vagos.permissao" }, -- Cocaina PASTA
	{ ['id'] = 2, ['x'] = -1106.4, ['y'] = 4951.23, ['z'] = 218.68, ['text'] = "espalhar a cocaína", ['perm'] = "vagos.permissao" }, -- Cocaina PRODUZIR
	{ ['id'] = 3, ['x'] = -1111.81, ['y'] = 4942.2, ['z'] = 218.65, ['text'] = "embalar cocaína", ['perm'] = "vagos.permissao" },

}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.2 and not processo then
				drawTxt("Pressione  ~r~E~w~  para "..v.text,4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm) then
					if v.id == 1 then
						if func.checkPayment(v.id) then
							processo = true
							despejando()
						end
					elseif v.id == 2 then
						if func.checkPayment(v.id) then
							processo = true
							espalhando()
						end
					elseif v.id == 3 then
						if func.checkPayment(v.id) then
							processo = true
							embalando_brinquedo()
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function embalando_brinquedo()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local animDict = "anim@amb@business@coc@coc_packing_hi@"
            RequestAnimDict(animDict)
            RequestModel("bkr_prop_coke_fullscoop_01a")
            RequestModel("bkr_prop_coke_fullmetalbowl_02")
            RequestModel("bkr_prop_coke_dollboxfolded")
            RequestModel("bkr_prop_coke_dollmould")
            RequestModel("bkr_prop_coke_press_01b")
            RequestModel("bkr_prop_coke_dollcast")
            RequestModel("bkr_prop_coke_doll")
            RequestModel("bkr_prop_coke_dollbox")
            RequestModel("bkr_prop_coke_doll_bigbox")
    
            while not HasAnimDictLoaded(animDict) and
                not HasModelLoaded("bkr_prop_coke_fullscoop_01a") and 
                not HasModelLoaded("bkr_prop_coke_fullmetalbowl_02") and 
                not HasModelLoaded("bkr_prop_coke_dollboxfolded") and 
                not HasModelLoaded("bkr_prop_coke_dollmould") and 
                not HasModelLoaded("bkr_prop_coke_press_01b") and 
                not HasModelLoaded("bkr_prop_coke_dollcast") and 
                not HasModelLoaded("bkr_prop_coke_doll") and 
                not HasModelLoaded("bkr_prop_coke_dollbox") and
                not HasModelLoaded("bkr_prop_coke_doll_bigbox") do
                Citizen.Wait(100)
            end

            pazinha = CreateObject(GetHashKey('bkr_prop_coke_fullscoop_01a'), x, y, z, 1, 0, 1)
            vasilha = CreateObject(GetHashKey('bkr_prop_coke_fullmetalbowl_02'), x, y, z, 1, 0, 1)
            caixa_aberta = CreateObject(GetHashKey('bkr_prop_coke_dollboxfolded'), x, y, z, 1, 0, 1)
            boneco_molde = CreateObject(GetHashKey('bkr_prop_coke_dollmould'), x, y, z, 1, 0, 1)
            prensa = CreateObject(GetHashKey('bkr_prop_coke_press_01b'), x, y, z, 1, 0, 1)
            boneco_vazio = CreateObject(GetHashKey('bkr_prop_coke_dollcast'), x, y, z, 1, 0, 1)
            boneco_pronto = CreateObject(GetHashKey('bkr_prop_coke_doll'), x, y, z, 1, 0, 1)
            caixa_fechada = CreateObject(GetHashKey('bkr_prop_coke_dollbox'), x, y, z, 1, 0, 1)

            local  targetRotation = vec3(180.0, 180.0, 60.5)
            local x,y,z = table.unpack(vec3(-1111.88, 4942.48,  218.65))

            local animPos = GetAnimInitialOffsetPosition(animDict, "full_cycle_v1_pressoperator",x ,y ,z ,targetRotation, 0, 2) 
			local netScene = NetworkCreateSynchronisedScene(x + 5.3 ,y + 4.6, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)

            NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "full_cycle_v1_pressoperator", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(pazinha, netScene, animDict, "full_cycle_v1_scoop", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(vasilha, netScene, animDict, "full_cycle_v1_cocbowl", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_aberta, netScene, animDict, "full_cycle_v1_foldedbox", 4.0, -8.0, 1)

            local netScene2 = NetworkCreateSynchronisedScene(x + 5.3 ,y + 4.6, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            NetworkAddEntityToSynchronisedScene(boneco_molde, netScene2, animDict, "full_cycle_v1_dollmould", 4.0, -8.0, 1) --
            NetworkAddEntityToSynchronisedScene(prensa, netScene2, animDict, "full_cycle_v1_cokepress", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(boneco_vazio, netScene2, animDict, "full_cycle_v1_dollcast^3", 4.0, -8.0, 1)
			local netScene3 = NetworkCreateSynchronisedScene(x + 5.3 ,y + 4.6, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)

            NetworkAddEntityToSynchronisedScene(boneco_pronto, netScene3, animDict, "full_cycle_v1_cocdoll", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_fechada, netScene3, animDict, "full_cycle_v1_boxeddoll", 4.0, -8.0, 1)
			
			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene)
			Citizen.Wait(100)
			NetworkStartSynchronisedScene(netScene2)
			Citizen.Wait(100)
            NetworkStartSynchronisedScene(netScene3)

			Citizen.Wait(GetAnimDuration(animDict, "full_cycle_v1_pressoperator") * 780) 

			NetworkStopSynchronisedScene(netScene)
			NetworkStopSynchronisedScene(netScene2)
			NetworkStopSynchronisedScene(netScene3)

			TriggerEvent('Notify', 'sucesso', 'Você embalou a cocaína.')

			DeleteObject(prensa)
            DeleteObject(caixa_aberta)
            DeleteObject(boneco_molde)
            DeleteObject(boneco_vazio)
            DeleteObject(boneco_pronto)
			DeleteObject(caixa_fechada)
			processo = false
			break
		end
	end)
end

function despejando()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local animDict = "anim@amb@business@coc@coc_unpack_cut@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_coke_box_01a")
			RequestModel("bkr_prop_coke_fullmetalbowl_02")
			RequestModel("bkr_prop_coke_fullscoop_01a")


			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_coke_box_01a") and 
				not HasModelLoaded("bkr_prop_coke_fullmetalbowl_02") and 
				not HasModelLoaded("bkr_prop_coke_fullscoop_01a") do
				Citizen.Wait(100)
			end

			vasilha = CreateObject(GetHashKey('bkr_prop_coke_fullmetalbowl_02'), x, y, z, 1, 0, 1)
			pazinha = CreateObject(GetHashKey('bkr_prop_coke_fullscoop_01a'), x, y, z, 1, 0, 1) 
			caixa = CreateObject(GetHashKey('bkr_prop_coke_box_01a'), x, y, z, 1, 0, 1)

			local  targetRotation = vec3(180.0, 180.0, 60.5)
			local x,y,z = table.unpack(vec3(-1105.13, 4952.35, 218.65)) 


			local netScene = NetworkCreateSynchronisedScene(x + 0.5 ,y - 0.2, z - 0.65, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "fullcut_cycle_v1_cokepacker", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(vasilha, netScene, animDict, "fullcut_cycle_v1_cokebowl", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa, netScene, animDict, 'fullcut_cycle_v1_cokebox', 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(pazinha, netScene, animDict, 'fullcut_cycle_v1_cokescoop', 4.0, -8.0, 1)
			
			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene)

			SetEntityVisible(pazinha, false, 0)
			Citizen.Wait(GetAnimDuration(animDict, "fullcut_cycle_v1_cokepacker") * 450)
			SetEntityVisible(pazinha, true, 0)

			Citizen.Wait(GetAnimDuration(animDict, "fullcut_cycle_v1_cokepacker") * 65)
			SetEntityVisible(caixa, false, 0)
			
			Citizen.Wait(GetAnimDuration(animDict, "fullcut_cycle_v1_cokepacker") * 245)

			TriggerEvent('Notify', 'sucesso', 'Você colocou a cocaína na vasilha.')

			DeleteObject(caixa)
			DeleteObject(pazinha)
			processo = false
			break
		end
	end)
end

function espalhando()
	Citizen.CreateThread(function() 
		while true do
			Citizen.Wait(10) 
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local animDict = "anim@amb@business@coc@coc_unpack_cut_left@"
    
            RequestAnimDict(animDict)
            RequestModel("bkr_prop_coke_box_01a")
            RequestModel("prop_cs_credit_card")
            RequestModel("bkr_prop_coke_bakingsoda_o")
    
            while not HasAnimDictLoaded(animDict) and
                not HasModelLoaded("bkr_prop_coke_bakingsoda_o") and 
                not HasModelLoaded("prop_cs_credit_card") do 
                Citizen.Wait(100)
            end

            cartao = CreateObject(GetHashKey('prop_cs_credit_card'), x, y, z, 1, 0, 1)
            cartao_2 = CreateObject(GetHashKey('prop_cs_credit_card'), x, y, z, 1, 0, 1)
            soda = CreateObject(GetHashKey('bkr_prop_coke_bakingsoda_o'), x, y, z, 1, 0, 1)

            local  targetRotation = vec3(180.0, 180.0, 240.0)
            local x,y,z = table.unpack(vec3(-1106.4, 4951.23, 218.68))  


            local netScene = NetworkCreateSynchronisedScene(x - 0.7 ,y - 1.8, z - 0.65, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "coke_cut_coccutter", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(cartao, netScene, animDict, "coke_cut_creditcard", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(cartao_2, netScene, animDict, "coke_cut_creditcard^1", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(soda, netScene, animDict, "cut_cough_v1_bakingsoda", 4.0, -8.0, 1) 

            NetworkStartSynchronisedScene(netScene)


			Citizen.Wait(GetAnimDuration(animDict, "coke_cut_coccutter") * 770)
			
			TriggerEvent('Notify', 'sucesso', 'Você espalhou a cocaína na mesa.')

            DeleteObject(cartao)
            DeleteObject(cartao2)
			DeleteObject(soda)
			processo = false
			break
		end
	end)
end

