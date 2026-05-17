extends Node

var GameDifficulty : String = ""
var CardPairCount : int = 0
var CardBackImage : Texture2D
var CardPictureSet : String = ""
#This stores the data of the diffrent difficulties. From left to right:
#Time, Drawcount, Number of card pairs
#Note all the values have to be floats. I guess GDscript is not a fan of arrays of diffrent value types
var BestTime : Dictionary = {
"Easy":[0.0,0,0],
"Normal":[0.0,0,0],
"Hard":[0.0,0,0],
"Hell":[0.0,0,0]
}

func NewBestTime(GameTime : float,DrawCount : int):
	var CurrentDiffTime = BestTime[GameDifficulty]
	if CurrentDiffTime == [0.0,0.0,0.0]:
		BestTime[GameDifficulty] = [GameTime, DrawCount,CardPairCount]
	elif CurrentDiffTime[0] > GameTime or CurrentDiffTime[1] > DrawCount or CurrentDiffTime[2] > CardPairCount:
		BestTime[GameDifficulty] = [GameTime, DrawCount,CardPairCount]


func convert_seconds_to_time(GameTimeSeconds : float):
	var GameTimeMinutes = int(GameTimeSeconds / 60)
	return "%d:%02d" % [GameTimeMinutes,GameTimeSeconds - (GameTimeMinutes * 60)]

func save_to_file():
	var file = FileAccess.open("res://save_game.dat", FileAccess.WRITE)
	file.store_string(str(BestTime))

func load_from_file():
	var file = FileAccess.open("res://save_game.dat", FileAccess.READ)
	if file != null:
		var content = file.get_as_text()
		var parsed_dict = JSON.parse_string(content)
		BestTime = parsed_dict as Dictionary[String, Array]
