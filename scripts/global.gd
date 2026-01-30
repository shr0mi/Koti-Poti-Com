extends Node

var target := 10000000.0

var first_time_kichir_michir := true

var djt_guess := 0
var elon_guess := 0
var powell_guess := 0
var yunus_guess := 0
var tarik_guess := 0
var shafiq_guess := 0

#xubu
var gamelvl := 0

var invest_amount_usd := 0.0
var invest_amount_bdt := 0.0
var balance := 100000.00
var day_start := true
var day_number := 0

var usd_profit := 0.0
var bdt_profit := 0.0

var djt_news := "Dollar Hits Record Highs as Global Demand Surges"
var elon_news := "Dollar Surges as Musk Integrates USD into Global X-Wallet"
var jeremy_news := "Fed Achieves Goldilocks Economy; USD Strength Confirmed"
var yunus_news := "Political Stability Hopes Send BDT to 6-Month High"
var tarek_news := "BNP Election Optimism Drives Bullish BDT Sentiment"
var shafiq_news := "Coalition Hopes Stabilize BDT Amid Election Fever"

var djt_true := true
var elon_true := true
var jeremy_true := true
var yunus_true := true
var tarik_true := true
var shafiq_true := true

# Accuracies
var djt_accuracy :int= 90
var musk_accuracy :int= 10
var powell_accuracy :int= 10

var yunus_accuracy :int= 90
var zia_accuracy :int= 10
var rahman_accuracy :int= 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_expert_accuracies()

func randomize_expert_accuracies() -> void:
	var accuracy_pool: Array = []
	
	match gamelvl:
		0: # Easy
			accuracy_pool = [90, 30, 30]
			# Assign to USD
			accuracy_pool.shuffle()
			djt_accuracy = accuracy_pool[0]
			musk_accuracy = accuracy_pool[1]
			powell_accuracy = accuracy_pool[2]
			# Assign to BDT (reshuffled)
			accuracy_pool.shuffle()
			yunus_accuracy = accuracy_pool[0]
			zia_accuracy = accuracy_pool[1]
			rahman_accuracy = accuracy_pool[2]
			
		1: # Hard
			# One big pool of 6 values for all 6 experts combined
			accuracy_pool = [90, 30, 30, 30, 30, 30]
			accuracy_pool.shuffle()
			
			# Assign sequentially from the shuffled pool
			djt_accuracy = accuracy_pool[0]
			musk_accuracy = accuracy_pool[1]
			powell_accuracy = accuracy_pool[2]
			yunus_accuracy = accuracy_pool[3]
			zia_accuracy = accuracy_pool[4]
			rahman_accuracy = accuracy_pool[5]

	# Debugging output
	print("Level: ", gamelvl)
	print("USD: ", djt_accuracy, "/", musk_accuracy, "/", powell_accuracy)
	print("BDT: ", yunus_accuracy, "/", zia_accuracy, "/", rahman_accuracy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
