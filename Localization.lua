local _, MBF = ...

local L = {}
MBF.L = L

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()

if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.
	L["MBF_Title"] = "Movable Bag Frames"
	L["MBF_Note"] = "Allows the bag frames to be resizeable and movable."
	L["MovableResizableBagFrames"] = "Movable & Resizable Bag Frames"
	L["Version"] = "Version %s"
	L["BagFramesScale"] = "Bag Frames Scale"
	L["LockBagFrames"] = "Lock Bag Frames"
	L["SortBagsRightLeft"] = "Sort Bags Right to Left"
	L["LootItemsRightLeft"] = "Loot Items Right to Left"
	L["CorrectMicromenuBagButton"] = "Correct Micromenu Bag Button Click\n(Experimental)"
	L["CharSpecificBagPositions"] = "Character-Specific Bag Positions"

return end

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["MBF_Title"] = "Marcos de bolsas movibles"
	L["MBF_Note"] = "Permite que los marcos de las bolsas sean redimensionables y movibles."
	L["MovableResizableBagFrames"] = "Marcos de bolsas movibles y redimensionables"
	L["Version"] = "Versión %s"
	L["BagFramesScale"] = "Escala de los marcos de bolsas"
	L["LockBagFrames"] = "Bloquear marcos de bolsas"
	L["SortBagsRightLeft"] = "Ordenar bolsas de derecha a izquierda"
	L["LootItemsRightLeft"] = "Botín de derecha a izquierda"
	L["CorrectMicromenuBagButton"] = "Corregir clic del botón de bolsas del micromenú\n(Experimental)"
	L["CharSpecificBagPositions"] = "Posiciones de bolsas específicas por personaje"

return end

if LOCALE == "deDE" then
	-- German translations go here
	L["MBF_Title"] = "Bewegliche Taschenfenster"
	L["MBF_Note"] = "Ermöglicht das Skalieren und Verschieben der Taschenfenster."
	L["MovableResizableBagFrames"] = "Bewegliche & skalierbare Taschenfenster"
	L["Version"] = "Version %s"
	L["BagFramesScale"] = "Skalierung der Taschenfenster"
	L["LockBagFrames"] = "Taschenfenster sperren"
	L["SortBagsRightLeft"] = "Taschen von rechts nach links sortieren"
	L["LootItemsRightLeft"] = "Beute von rechts nach links"
	L["CorrectMicromenuBagButton"] = "Korrigiere Klick auf Taschenbutton im Mikromenü\n(Experimentell)"
	L["CharSpecificBagPositions"] = "Charakterspezifische Taschenpositionen"

return end

if LOCALE == "frFR" then
	-- French translations go here
	L["MBF_Title"] = "Fenêtres de sacs déplaçables"
	L["MBF_Note"] = "Permet aux fenêtres de sacs d’être redimensionnables et déplaçables."
	L["MovableResizableBagFrames"] = "Fenêtres de sacs déplaçables et redimensionnables"
	L["Version"] = "Version %s"
	L["BagFramesScale"] = "Échelle des fenêtres de sacs"
	L["LockBagFrames"] = "Verrouiller les fenêtres de sacs"
	L["SortBagsRightLeft"] = "Trier les sacs de droite à gauche"
	L["LootItemsRightLeft"] = "Butin de droite à gauche"
	L["CorrectMicromenuBagButton"] = "Corriger le clic du bouton des sacs du micromenu\n(Expérimental)"
	L["CharSpecificBagPositions"] = "Positions des sacs spécifiques au personnage"

return end

if LOCALE == "itIT" then
	-- Italian translations go here
	L["MBF_Title"] = "Finestre borse mobili"
	L["MBF_Note"] = "Consente alle finestre delle borse di essere ridimensionabili e mobili."
	L["MovableResizableBagFrames"] = "Finestre borse mobili e ridimensionabili"
	L["Version"] = "Versione %s"
	L["BagFramesScale"] = "Scala finestre borse"
	L["LockBagFrames"] = "Blocca finestre borse"
	L["SortBagsRightLeft"] = "Ordina borse da destra a sinistra"
	L["LootItemsRightLeft"] = "Bottino da destra a sinistra"
	L["CorrectMicromenuBagButton"] = "Correggi clic del pulsante borse nel micromenu\n(Sperimentale)"
	L["CharSpecificBagPositions"] = "Posizioni borse specifiche del personaggio"

return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["MBF_Title"] = "Janelas de bolsas móveis"
	L["MBF_Note"] = "Permite que as janelas das bolsas sejam redimensionáveis e móveis."
	L["MovableResizableBagFrames"] = "Janelas de bolsas móveis e redimensionáveis"
	L["Version"] = "Versão %s"
	L["BagFramesScale"] = "Escala das janelas das bolsas"
	L["LockBagFrames"] = "Bloquear janelas das bolsas"
	L["SortBagsRightLeft"] = "Ordenar bolsas da direita para a esquerda"
	L["LootItemsRightLeft"] = "Itens saqueados da direita para a esquerda"
	L["CorrectMicromenuBagButton"] = "Corrigir clique do botão de bolsas do micromenu\n(Experimental)"
	L["CharSpecificBagPositions"] = "Posições de bolsas específicas por personagem"

-- Note that the EU Portuguese WoW client also
-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["MBF_Title"] = "Перемещаемые окна сумок"
	L["MBF_Note"] = "Позволяет изменять размер и перемещать окна сумок."
	L["MovableResizableBagFrames"] = "Перемещаемые и масштабируемые окна сумок"
	L["Version"] = "Версия %s"
	L["BagFramesScale"] = "Масштаб окон сумок"
	L["LockBagFrames"] = "Закрепить окна сумок"
	L["SortBagsRightLeft"] = "Сортировать сумки справа налево"
	L["LootItemsRightLeft"] = "Добыча справа налево"
	L["CorrectMicromenuBagButton"] = "Исправить нажатие кнопки сумок в микроменю\n(Экспериментально)"
	L["CharSpecificBagPositions"] = "Позиции сумок отдельно для персонажей"

return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["MBF_Title"] = "이동 가능한 가방 창"
	L["MBF_Note"] = "가방 창의 크기 조절 및 이동을 가능하게 합니다."
	L["MovableResizableBagFrames"] = "이동 및 크기 조절 가능한 가방 창"
	L["Version"] = "버전 %s"
	L["BagFramesScale"] = "가방 창 크기"
	L["LockBagFrames"] = "가방 창 잠금"
	L["SortBagsRightLeft"] = "가방을 오른쪽에서 왼쪽으로 정렬"
	L["LootItemsRightLeft"] = "전리품을 오른쪽에서 왼쪽으로 표시"
	L["CorrectMicromenuBagButton"] = "마이크로 메뉴 가방 버튼 클릭 수정\n(실험적)"
	L["CharSpecificBagPositions"] = "캐릭터별 가방 위치"

return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here
	L["MBF_Title"] = "可移动背包框体"
	L["MBF_Note"] = "允许背包框体可调整大小并移动。"
	L["MovableResizableBagFrames"] = "可移动和可调整大小的背包框体"
	L["Version"] = "版本 %s"
	L["BagFramesScale"] = "背包框体缩放"
	L["LockBagFrames"] = "锁定背包框体"
	L["SortBagsRightLeft"] = "背包从右向左排序"
	L["LootItemsRightLeft"] = "拾取物品从右向左"
	L["CorrectMicromenuBagButton"] = "修正微型菜单背包按钮点击\n（实验性）"
	L["CharSpecificBagPositions"] = "角色专属背包位置"

return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here
	L["MBF_Title"] = "可移動背包框體"
	L["MBF_Note"] = "允許背包框體可調整大小並移動。"
	L["MovableResizableBagFrames"] = "可移動與可調整大小的背包框體"
	L["Version"] = "版本 %s"
	L["BagFramesScale"] = "背包框體縮放"
	L["LockBagFrames"] = "鎖定背包框體"
	L["SortBagsRightLeft"] = "背包由右至左排序"
	L["LootItemsRightLeft"] = "拾取物品由右至左"
	L["CorrectMicromenuBagButton"] = "修正微型選單背包按鈕點擊\n（實驗性）"
	L["CharSpecificBagPositions"] = "角色專屬背包位置"

return end

