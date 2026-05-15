extends Node

var GameDifficulty : String = ""
var CardPairCount : int = 0
var CardBackImage : Texture2D
var CardPictureSet : String = ""
var BestTime : Dictionary[String,Array] = {
"Easy":[0.0,0],
"Normal":[0.0,0],
"Hard":[0.0,0],
"Hell":[0.0,0]
}

func NewBestTime(GameTime : float,DrawCount : int):
	var CurrentDiffTime = BestTime[GameDifficulty]
	if CurrentDiffTime == []:
		BestTime[GameDifficulty] = [GameTime, DrawCount]
	elif CurrentDiffTime[0] > GameTime or CurrentDiffTime[1] > DrawCount:
		BestTime[GameDifficulty] = [GameTime, DrawCount]

func convert_seconds_to_time(GameTimeSeconds : float):
	var GameTimeMinutes = int(GameTimeSeconds / 60)
	return "%d:%02d" % [GameTimeMinutes,GameTimeSeconds - (GameTimeMinutes * 60)]

func save_to_file():
	var file = FileAccess.open("res://save_game.dat", FileAccess.WRITE)
	file.store_string(str(BestTime))

func load_from_file():
	var file = FileAccess.open("res://save_game.dat", FileAccess.READ)
	var content = file.get_as_text()
	print(content)
	return content
