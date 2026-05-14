extends Control

var CardScene = preload("res://scenes/game_parts/Card.tscn")
var Cards : Array[Control] = []

#Array of Cards, that are currently selected
var SelectedCards : Array[Control] = []
var CardPairCount : int = 7

#Array with images for the cards
@export var CardImages : Array[Texture2D]

enum GameState {Pick, Check, Correct, Wrong, Done}
var CurrentState = GameState.Pick

var DrawCount : int = 0
var GameTimeSeconds : float = 2
var GameTimeMinutes : int = 0

func _ready() -> void:
	#Shuffles the Image array. This is mostly for the smaller pair counts
	#so that the images would be diffrent from game to game
	CardImages.shuffle()
	#for every pair count, creates 2 cards
	for i in CardPairCount:
		create_card(CardImages[i])
		create_card(CardImages[i])
	Cards.shuffle()
	for i in Cards:
		#adds the Card instances to the scene
		$VBoxContainer/CardHolder.add_child(i)
	#connects all the card buttons with card_pressed function
	for Card : Control in get_tree().get_nodes_in_group("card_button"):
		Card.CardButton.pressed.connect(card_pressed.bind(Card))

func create_card(CardImage : Texture2D):
	#Creates a card instance and appends it into the Cards array
	var CardInst : Control = CardScene.instantiate()
	CardInst.CardImage = CardImage
	Cards.append(CardInst)

func _process(delta: float) -> void:
	#This mess of a function creates an array, where there are only correct cards
	var AllCardsCorrect = get_tree().get_nodes_in_group("card_button").filter(func(Card): return Card.Correct)
	
	if AllCardsCorrect.size() == get_tree().get_nodes_in_group("card_button").size():
		CurrentState = GameState.Done
	if CurrentState != GameState.Done: 
		GameTimeSeconds += delta
		GameTimeMinutes = int(GameTimeSeconds / 60)
		$VBoxContainer/InfoPanel/Time.text = "Aeg: %d:%02d" % [GameTimeMinutes,GameTimeSeconds - (GameTimeMinutes * 60)]
		$VBoxContainer/InfoPanel/DrawCount.text = "Käiguloendur: "+str(DrawCount)
	match(CurrentState):
		GameState.Pick:
			for Card in get_tree().get_nodes_in_group("card_button"):
				if Card.Correct == false:
					break
			
			#This is the state, where the player can pick cards
			#When 2 cards a picked, the game adds 1 to the draw count and progresses to the Check state
			if SelectedCards.size() == 2:
				DrawCount += 1
				CurrentState = GameState.Check
		GameState.Check:
			var Card1 : Control = SelectedCards[0]
			var Card2 : Control = SelectedCards[1]
			#Checks if both of the cards image matches
			#If true, the game will go to the Correct state
			#if false, the gamw will go to the Wrong state
			if Card1.CardImage == Card2.CardImage:
				CurrentState = GameState.Correct
			else:
				CurrentState = GameState.Wrong
		GameState.Correct:
			#This state simply emptys the SelectedCards array and moves the game to the Pick state
			SelectedCards[0].correct()
			SelectedCards[1].correct()
			SelectedCards = []
			CurrentState = GameState.Pick
		GameState.Wrong:
			#Starts a 1 second delay
			if $WrongCardTimer.is_stopped():
				$WrongCardTimer.start()
			await  $WrongCardTimer.timeout
			#if the SelectedCards array isn't empty, it will hide both of the selected cards, empty the SelectedCards array, stops the timer and switches the game back to the Pick state
			if SelectedCards.is_empty() == false:
				var Card1 : Control = SelectedCards[0]
				var Card2 : Control = SelectedCards[1]
				Card1.hide_card()
				Card2.hide_card()
				SelectedCards = []
			$WrongCardTimer.stop()
			CurrentState = GameState.Pick
		GameState.Done:
			#Does nothing, so that the player can do nothing as well
			pass

func card_pressed(Card : Control):
	#reveals the card and appends it to the SelectedCards array
	#It does that only when the GameState is Pick
	if CurrentState == GameState.Pick:
		Card.reveal_card()
		SelectedCards.append(Card)


func _on_settings_pressed() -> void:
	$Settings.visible = true
