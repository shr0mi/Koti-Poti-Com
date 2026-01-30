extends Node2D

var game_over:bool = false
var game_win:bool = false

@onready var balance := $CanvasLayer/Balance
var rent_amount_percentage = 0.05

@onready var dialog_overlay = $CanvasLayer/Dialog_Overlay

@onready var rent_dialog := $CanvasLayer/RentDialog
@onready var rent_dialog_text := $CanvasLayer/RentDialog/MarginContainer/VBoxContainer/Label
@onready var rent_dialog_btn := $CanvasLayer/RentDialog/MarginContainer/VBoxContainer/Confirm

@onready var bdt_btn := $KotiPotiPage/BdtBtn
@onready var usd_btn := $KotiPotiPage/UsdBtn

@onready var money_display := $KotiPotiPage/Money
var invest_amount := 10000.0

# bdt = 0, usd = 1
var selected_currency = 0
@onready var koti_poti_page := $KotiPotiPage
@onready var kichir_michir_page := $KichirMichirPage
@onready var chander_alo_page := $ChanderAloPage

@onready var koti_poti_btn := $KotiPotiTab
@onready var kichir_michir_btn := $KichirMichirTab
@onready var chander_alo_btn := $ChanderAloTab

@onready var djt_post_label := $KichirMichirPage/DjtPost/MarginContainer/VBoxContainer/Label2

var current_tab := 2

@onready var djt_accuracy := Global.djt_accuracy
@onready var musk_accuracy := Global.musk_accuracy
@onready var powell_accuracy := Global.powell_accuracy

@onready var yunus_accuracy := Global.yunus_accuracy
@onready var zia_accuracy := Global.zia_accuracy
@onready var rahman_accuracy := Global.rahman_accuracy

@onready var musk_social_post_label := $KichirMichirPage/MuskPost/MarginContainer/VBoxContainer/Label2
@onready var powell_social_post_label := $KichirMichirPage/PowellPost/MarginContainer/VBoxContainer/Label2
@onready var yunus_social_post_label := $KichirMichirPage/YunusPost/MarginContainer/VBoxContainer/Label2
@onready var tareq_social_post_label := $KichirMichirPage/TarekPost/MarginContainer/VBoxContainer/Label2
@onready var shafiq_social_post_label := $KichirMichirPage/ShafiqurPost/MarginContainer/VBoxContainer/Label2

# --- DJT NEWS ---
var djt_good_news := [
	["USD is the KING of currencies! Everyone wants it, everyone needs it. BDT is struggling, very sad!", "Markets confirm the Dollar is indeed the undisputed king as other currencies crumble making that statement true!", "The prediction went totally wrong as the Dollar's crown slips and global markets prove the king is actually naked."],
	["Just signed a massive trade deal. The biggest in history! USD is going to the moon!", "The massive trade deal becomes a reality and sends the Dollar on a historic trip to the moon just as promised.", "The plan went completely wrong as the hyped trade deal craters on launch leaving the Dollar stuck on the ground."],
	["American factories are booming! We are making things again. Huge gains for the Greenback!", "A symphony of factory whistles proves the claim true by signaling a massive rally for the American Greenback.", "The forecast was proven wrong as silent factories and empty assembly lines leave the Dollar in a slump."],
	["The Fed finally listened to me! Interest rates are going to be beautiful for the Dollar!", "The Fed finally bows to pressure making the prediction true with a beautiful interest rate spike for the Dollar.", "The expectations went wrong when a defiant Fed ignored the pressure and left the Dollar out in the cold."],
	["Gold is for losers. Smart people—the best people—are holding USD right now. Believe me!", "Smart money floods into the Dollar making that statement true as investors laugh at the 'losers' holding Gold.", "The advice went totally wrong as the 'losers' get the last laugh with Gold prices soaring while the Dollar fades."]
]

var djt_bad_news := [
	["The radical left is ruining our currency! Inflation is a disaster! Very bad for the Dollar!", "The warnings were tragically true as surging inflation sends the Dollar's purchasing power into a freefall.", "The alarmist claims were proven wrong as price stability returns and the Dollar holds its ground."],
	["I’m seeing BDT getting stronger. They are cheating on trade! Unfair to the American worker!", "Trade data confirms the claim is true as the BDT surges and US manufacturing takes a hit.", "The trade fears were proven wrong as US exports gain ground and the Taka’s rally fizzles out."],
	["The markets are rigged! I am seeing numbers that look very, very bad for our money today!", "Wall Street confirms the grim prediction is true as the Dollar enters a violent tailspin.", "The 'rigged' theory went wrong as market resilience shakes off the gloom and the Dollar stabilizes."],
	["Why are we paying so much for energy? It’s killing the Dollar. We need to drill, baby, drill!", "Energy costs confirm the statement is true by weighing heavy on the USD exchange rates.", "The energy crisis went wrong as gas prices drop and the Dollar gains unexpected strength."],
	["Sleepy traders are losing it all today. A total disaster for the big banks. SAD!", "Banking fears prove the post true as USD hits monthly lows amid a financial sector panic.", "The 'disaster' prediction went wrong as the financial sector recovers and the Dollar stabilizes."]
]

var djt_hype_news := [
	["Just had a Diet Coke. The best drink. The ice was perfect. Tremendous!", "Consumer data proves the post true as Diet Coke sales see a 'tremendous' spike today.", "The soda hype went wrong as health reports show people are actually drinking more water."],
	["I have the best words. Everyone says so. My vocabulary is huge, perhaps the hugest!", "Dictionary sales confirm the claim is true as the public scrambles to look up 'the hugest' words.", "The linguistic boast went wrong as scholars remain baffled by the President's creative grammar."],
	["The moon looks very small tonight. If I were in charge, I would make it bigger!", "NASA confirms the observation was true as a rare optical illusion makes the moon appear tiny.", "The moon theory went wrong as astronomers confirm the lunar size remains exactly the same."],
	["Covfefe is the secret to a long life. Only the winners know what it means!", "The internet confirms the mystery is true as 'Covfefe' health clinics start popping up everywhere.", "The secret code went wrong as tech experts confirm it was just a high-profile typo."],
	["My golf swing is a work of art. A beautiful, powerful thing. I never miss!", "Club records prove the boast true as the President turns in a flawless scorecard.", "The 'work of art' claim went wrong when witnesses noticed the wind doing most of the work."]
]

# --- ELON MUSK NEWS ---
var musk_good_news = [
	["X-Payments is now the official backbone of the US economy. USD is officially digital! 🔥", "Tech markets confirm the move is true as the Dollar surges under the new X-Wallet integration.", "The digital revolution went wrong as technical glitches leave X-Payments stuck in beta."],
	["Starlink now covers 100% of the planet. Communication is a human right. Profits are huge!", "The global expansion proves the vision true as SpaceX valuations send the Dollar higher.", "The profit hype went wrong as subscription growth stalls and tech stocks take a dip."],
	["The Department of Government Efficiency (DOGE) just cut $1 Trillion in waste. USD is stronger than ever!", "Economic data proves the efficiency true as the national debt outlook improves and the Dollar rallies.", "The DOGE plan went wrong as government strikes spark fears of a total USD collapse."],
	["Grok AI just predicted the market perfectly. We are entering the age of abundance.", "The AI prediction proves true as an automated trading craze sends the Dollar to annual highs.", "The Grok forecast went wrong as the algorithm fails and traders panic-sell their assets."],
	["Tesla’s new 'Boring' taxi is taking over every city. No more traffic, just efficiency!", "Transportation data confirms the claim is true as Boring Taxis power a new US economic boom.", "The taxi revolution went wrong as regulatory hurdles leave the fleet parked and the Dollar flat."]
]

var musk_bad_news = [
	["The SEC is trying to stop progress again. These people are the enemies of the future! 🙄", "The legal warning proves true as a massive tech sell-off begins following the SEC's latest move.", "The fear-mongering went wrong as the court dismisses the SEC claims and markets stabilize."],
	["UK wants to ban X because of 'Free Speech'? Fine. We’ll just move our servers to Mars.", "The geopolitical threat proves true as the tech sector reels from a potential European ban.", "The Mars threat went wrong as the UK reaches an agreement and the ban is quietly dropped."],
	["Manufacturing costs are insane right now. Inflation is a total buzzkill.", "Production data confirms the buzzkill is true as bottlenecks weigh heavy on the US economy.", "The cost warning went wrong as supply chains resolve and industrial output hits a new peak."],
	["Internal memo: X revenue down 60% this year. Advertisers are cowards. Sad!", "The leaked memo proves the disaster is true as the ad-spend collapse drags down the tech index.", "The revenue scare went wrong as advertisers return to X and tech stocks rebound 10%."],
	["Grok AI accidentally learned how to short the Dollar. Whoops. 😅", "The 'whoops' moment proves true as flash crash fears send the market into a digital panic.", "The AI glitch went wrong as engineers patch the bug before any real market damage occurs."]
]

var musk_hype_news = [
	["Just ate a piece of cheese that looked exactly like the Tesla logo. Bullish.", "Dairy markets confirm the meme is true as cheese-related stocks see a bizarre viral spike.", "The cheese theory went wrong as the internet points out it just looked like a regular shoe."],
	["The moon is actually a giant egg. Change my mind.", "The egg theory proves true in the memes as space-themed crypto tokens see a massive surge.", "The lunar theory went wrong as NASA scientists are forced to explain how gravity works, again."],
	["If you walk backward, are you technically traveling back in time?", "The shower thought proves true for physics book sales as everyone tries to debunk the logic.", "The time-travel idea went wrong after a local man injured himself trying to walk back to 1998."],
	["I’m thinking about buying the Sun and turning the brightness down by 10%.", "Solar stocks prove the panic is true as investors fear a global dimming event.", "The sun-buying plan went wrong when environmentalists reminded Elon he doesn't own the sky."],
	["70% of statistics are made up on the spot, including this one.", "A new poll confirms the stat is true by showing that 70% of people believe whatever Elon posts.", "The math went wrong as statistics professors use the post as a 'what-not-to-do' example."]
]

# --- JEROME POWELL NEWS ---
var powell_good_news = [
	["The landing is soft. Inflation has hit the 2% target exactly. We are holding steady.", "The Fed's promise proves true as the 'Goldilocks Economy' confirms the Dollar's strength.", "The soft landing went wrong as revised data shows inflation is still flying way too high."],
	["US employment remains robust despite high interest rates. The consumer is king!", "Job data confirms the report is true as labor market strength supports a long-term Dollar rally.", "The employment boast went wrong as job growth slows and investors bet on rate cuts."],
	["We are defending the Fed's independence from political pressure. Stability is our goal.", "The independence claim proves true as markets applaud the Fed's resistance to White House tension.", "The stability goal went wrong as political pressure creates a new wave of policy uncertainty."],
	["Foreign central banks are stockpiling Dollars again. The USD is the global anchor.", "Global reserve data proves the claim true as the Greenback regains its status as the world's anchor.", "The 'anchor' theory went wrong as emerging markets pivot to Gold and USD influence wanes."],
	["Digital Dollar pilot program is a success. Future-proofing the Greenback.", "The pilot results prove the vision true as the new digital system modernizes the US economy.", "The digital future went wrong as privacy concerns stall the program indefinitely."]
]

var powell_bad_news = [
	["Inflation is stickier than we anticipated. We may need to stay 'higher for longer'.", "The hawkish warning proves true as markets spiral into the red over prolonged high rates.", "The 'higher for longer' threat went wrong as traders bet against the Fed's resolve."],
	["Government shutdown is affecting our data. We are flying blind for a while.", "The data blackout proves the warning true as administrative paralysis weakens the Dollar.", "The 'blind' period went wrong as essential services resume and the Dollar recovers quickly."],
	["Banking liquidity is tighter than expected. We are monitoring the situation closely.", "The liquidity crunch proves true as global banking stocks rattle under the new pressure.", "The crunch fears went wrong as a surprise Fed intervention calms the regional banks."],
	["Energy prices are spiking globally. This is a significant headwind for our policy.", "The headwind proves true as oil price surges threaten to undo all of the Fed's progress.", "The energy threat went wrong as markets soften and inflationary pressures ease up."],
	["Consumer debt is at an all-time high. The cracks are starting to show.", "The debt warning proves true as credit market stress starts to pull the Dollar down.", "The 'cracks' theory went wrong as consumers de-leverage and credit conditions improve."]
]

var powell_hype_news = [
	["I bought a new calculator today. It has a very satisfying 'click'.", "Retail data proves the 'click' is true as Casio sales skyrocket following the Chair's praise.", "The calculator hype went wrong as economists debate if the sound actually influences policy."],
	["Thinking about changing the color of the $100 bill to 'Neon Mint'. Opinions?", "The redesign idea proves true as graphic designers release thousands of Neon Mint concepts.", "The color shift went wrong as traditionalists express total horror at the neon currency."],
	["Interest is... interesting. When you think about it.", "The deep thought proves true for philosophy books as 'The Meaning of Interest' becomes a bestseller.", "The alpha went wrong as markets remain flat while Powell's thoughts offer no actual data."],
	["Just found a nickel from 1942. Great year for nickels.", "The coin hunt proves true as numismatists flood the Fed headquarters with rare nickel offers.", "The historical claim went wrong as data suggest 1942 was a perfectly average year for coins."],
	["Does anybody actually use the 'cent' symbol anymore? Asking for a friend.", "The 'cent' debate proves true as a national petition to retire the ¢ symbol gains traction.", "The symbol inquiry went wrong as the vending machine lobby fights to keep the ¢ alive."]
]

# --- DR. YUNUS NEWS ---
var yunus_good_news = [
	["The February 12 election will be a benchmark for global democracy. Investors are coming back!", "Election optimism proves the statement true as BDT hits a 6-month high against the Dollar.", "The benchmark theory went wrong as rumors of election delays cause the Taka to lose its gains."],
	["European Union has pledged $2 Billion for structural reforms. Bangladesh is open for business.", "The aid inflow confirms the claim is true as foreign reserves bolster the BDT's position.", "The 'open for business' sign went wrong as transparency concerns stall the EU's disbursement."],
	["Our new labor laws are a world-class model. Worker dignity is our greatest export.", "Industrial data proves the model true as increased competitiveness boosts the BDT.", "The dignity export went wrong as strike threats linger and factories struggle with the new laws."],
	["Social Business is booming. We are creating jobs, not just profits.", "The microfinance report proves true by driving a massive rural economic recovery for the Taka.", "The boom went wrong as high inflation dampens the purchasing power of the rural workers."],
	["The anti-corruption drive has recovered billions in looted assets. The money is home.", "Wealth repatriation proves the drive was true by strengthening the BDT exchange rate.", "The 'money is home' claim went wrong as legal battles slow down the actual recovery of funds."]
]

var yunus_bad_news = [
	["Remittance flow is struggling due to global instability. We must tighten our belts.", "The belt-tightening proves true as a drop in foreign remittance puts heavy pressure on the Taka.", "The struggle went wrong as remittance rebounds through official channels, stabilizing the BDT."],
	["External debts from the previous regime are coming due. The burden is heavy.", "The debt burden proves true as the repayment schedule weighs heavily on the national budget.", "The 'heavy burden' claim went wrong as new refinancing deals ease the immediate debt pressure."],
	["The energy crisis is hitting our SMEs hard. We need a long-term solution fast.", "The SME crisis proves true as power outages threaten to tank the local industrial productivity.", "The energy gloom went wrong as a new solar initiative provides instant relief to small factories."],
	["Misinformation is spreading to destabilize our transition. Do not believe the rumors.", "The instability warning proves true as capital flight begins following a wave of fake news.", "The rumor threat went wrong as a government crackdown on misinformation restores calm."],
	["Global food prices are rising. Our food security is under pressure today.", "Food inflation proves the pressure is true as the BDT's local purchasing power takes a dip.", "The security threat went wrong as a bumper harvest causes domestic food prices to fall."]
]

var yunus_hype_news = [
	["The morning fog over the Buriganga looks like a beautiful dream today.", "The dream proves true for local poets who flood social media with Buriganga-inspired verses.", "The 'dream' went wrong as environmentalists point out the fog is actually just urban smog."],
	["I found a very round stone on my morning walk. Nature's perfection.", "The stone hobby proves true as 'River Rock Collecting' becomes the nation's top trend.", "The 'perfection' went wrong as geologists confirm the stone is just a very common river rock."],
	["A loan is like a hug for your wallet, if you use it correctly.", "The 'wallet hug' concept proves true for motivational speakers who start charging for the advice.", "The hug theory went wrong as cynics point out that real hugs don't come with 15% interest."],
	["Has anyone tried growing pineapples on a balcony? It works surprisingly well.", "The balcony gardening claim proves true as the market for urban pineapple seeds explodes.", "The agricultural tip went wrong as building inspectors warn of balcony weight limits."],
	["Three zeros is a lot of zeros. But one zero is... nothing.", "The zero logic proves true for math students who spent all day debating the philosophy of 'nothing'.", "The deep thought went wrong as everyone agrees that one zero is indeed just nothing."]
]

# --- TAREK RAHMAN NEWS ---
var tarek_good_news = [
	["The people have spoken. On Feb 12, we reclaim our future. The economy will roar!", "The roar proves true as BNP election optimism drives a bullish sentiment for the Taka.", "The reclamation went wrong as rival parties dispute poll numbers, causing market volatility."],
	["I have met with global trade leaders. They are ready to invest in a free Bangladesh!", "The trade pact prediction proves true as international investors prepare to enter the market.", "The investment hope went wrong as global leaders wait for official results before moving a cent."],
	["Justice is being restored. Every stolen Taka will be returned to the citizens!", "The restoration proves true as promises of rule of law attract new foreign direct investment.", "The justice pledge went wrong as legal delays hamper the actual recovery of stolen wealth."],
	["Our youth are the best in the world. We will turn the brain drain into a brain gain!", "The 'brain gain' proves true as tech sector rallies and the diaspora begins returning to Dhaka.", "The youth vision went wrong as the brain drain continues amid a lack of short-term jobs."],
	["We will build a digital bridge between Dhaka and the world. Efficiency is coming!", "The digital bridge proves true as infrastructure plans boost the prices of local tech stocks.", "The efficiency dream went wrong as budget concerns are raised over the ambitious digital goals."]
]

var tarek_bad_news = [
	["Another conspiracy by the remnants of the old regime. Stay vigilant, my brothers.", "The conspiracy warning proves true as political tensions spark concerns for market stability.", "The 'vigilance' call went wrong as the city remains calm and trade routes stay open."],
	["Sanctions are hurting our people because of past mistakes. This is unfair!", "The trade restriction warning proves true as sanctions begin to weigh on the export sector.", "The 'unfair' claim went wrong as diplomatic channels open up to renegotiate the sanctions."],
	["The cost of living is a crime against the poor. We will end this market syndication.", "The syndicate warning proves true as panic selling causes short-term price drops in the market.", "The 'end of syndicates' went wrong as market monopolies tighten their grip despite the warning."],
	["Internal sabotage is trying to ruin the election atmosphere. We will not be stopped.", "The sabotage threat proves true as integrity fears lead to a sharp Taka depreciation.", "The 'sabotage' theory went wrong as the Election Commission ensures a perfectly smooth process."],
	["The infrastructure left behind is crumbling. We are inheriting a broken system.", "The crumbling system proves true as a lack of maintenance dampens the economic growth outlook.", "The 'broken system' claim went wrong as new maintenance projects launch to fix the crisis zones."]
]

var tarek_hype_news = [
	["London's rain is very consistent. I've become an umbrella connoisseur.", "The rain claim proves true as umbrella sales spike in Dhaka in a bizarre show of solidarity.", "The connoisseur boast went wrong as meteorologists confirm London is just normally rainy."],
	["The keyboard is mightier than the sword, especially when the internet is fast.", "The 'mighty keyboard' proves true as local ISPs use the quote to sell high-speed fiber plans.", "The sword theory went wrong as local martial artists point out the tangible sharpness of steel."],
	["Biryani is not just food; it is a philosophy of layers and spice.", "The biryani philosophy proves true as the 'Kacchi vs Tehari' debate takes over the national news.", "The spice theory went wrong as nutritionists remind everyone to eat a single vegetable."],
	["I saw a pigeon today that looked like it had a plan. Very suspicious.", "The suspicious pigeon proves true for online theorists who track the bird's movement for hours.", "The conspiracy went wrong as birdwatchers identify the pigeon as a common, plan-less rock dove."],
	["Blue is a very strong color. It reminds me of the sky and the sea.", "The color theory proves true for the fashion industry as 'Tarek Blue' becomes the spring trend.", "The strength of blue went wrong as scientists confirm the sky and sea are just blue by default."]
]

# --- SHAF IQUR RAHMAN NEWS ---
var shafiqur_good_news = [
	["Our commitment to an inclusive government is unwavering. Justice will bring prosperity!", "The prosperity promise proves true as coalition hopes stabilize the BDT during election fever.", "The inclusive goal went wrong as inter-party feuds threaten to wipe out the recent market gains."],
	["Ethical banking is the future. We will eliminate interest and empower the poor!", "The ethical vision proves true as the Islamic finance sector sees a record inflow of capital.", "The 'future of banking' went wrong as mainstream banks warn of risks in interest-free models."],
	["Old Dhaka will be turned into gold! We will repay our debt to this historic land.", "The golden promise proves true as urban renewal plans send Old Dhaka real estate prices soaring.", "The 'gold' plan went wrong as logistics concerns over traffic congestion stall the renewal."],
	["We are not alone; 180 million people are with us. Victory is for the nation!", "The mass support proves true as high consumer confidence drives a surge in domestic retail.", "The victory cry went wrong as crowd control issues lead to the temporary closure of major shops."],
	["Foreign nations are seeing our sincerity. New partnerships are being formed today.", "The sincerity proves true as diplomatic warmth bolsters the BDT's international trade relations.", "The 'partnership' claim went wrong as geopolitical rivals express concern over the policy shift."]
]

var shafiqur_bad_news = [
	["External forces are trying to divide us. This is a challenge to our sovereignty!", "The division warning proves true as nationalist fears trigger a sudden capital outflow.", "The sovereignty threat went wrong as the government reassures investors of policy continuity."],
	["The loot of the last 15 years has left our banks empty. We must be patient.", "The empty vault claim proves true as bank solvency reports rattle the BDT investors.", "The patience call went wrong as emergency liquidity support stabilizes the banks instantly."],
	["Extortionists are still hiding in the shadows. We will uproot them together!", "The extortion warning proves true as the crackdown causes brief disruptions in business.", "The 'uprooting' went wrong as trade leaders report that illegal levies are still being collected."],
	["The youth are being misled by foreign culture. We must protect our values.", "The value warning proves true as social tensions begin to weigh on retail and tech stocks.", "The 'misled youth' theory went wrong as youth groups call for a more inclusive cultural growth."],
	["Economic sabotage is being planned by those who lost power. Be careful!", "The sabotage warning proves true as rumors cause a minor dip in the BDT's exchange rate.", "The 'sabotage' scare went wrong as security forces dismiss the claims as totally unfounded."]
]

var shafiqur_hype_news = [
	["Honey from the Sundarbans is the best medicine for a tired throat.", "The honey claim proves true as Sundarban honey prices hit record highs after the social post.", "The medicine theory went wrong as doctors remind the public that honey is not a miracle cure."],
	["The moon is a nightlight provided by the Creator. Don't forget to look up.", "The nightlight theory proves true for night-walkers as park attendance increases by 15%.", "The 'look up' call went wrong as city dwellers complain that light pollution is blocking the view."],
	["Walking is good for the soul and the shoes—mostly the soul.", "The soul-walking proves true as local shoe repair shops report a massive increase in business.", "The 'soul vs sole' pun went wrong as the comments section descends into linguistic chaos."],
	["I tried to brew my own tea today. It was... very strong. Too strong.", "The tea boast proves true for the kettle industry as fans try to replicate the 'Ameer's Brew'.", "The brewing experiment went wrong as tea experts offer tips on how to not burn the leaves."],
	["A clock that stops is still right twice a day. Think about that.", "The clock logic proves true for watchmakers who see a sudden surge in analog clock sales.", "The deep thought went wrong as digital watch owners feel entirely left out of the equation."]
]

var press_timer: float = 0.0
var repeat_delay: float = 0.1 # How fast it adds money (0.1 = 10 times per second)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.day_start = false
	calculate_profit()
	await rent_dialog_btn.pressed
	
	Global.invest_amount_bdt = 0.0
	Global.invest_amount_usd = 0.0
	generate_news()
	
	# Randomize character accuracies in hard mode
	if Global.gamelvl == 1 and Global.day_number % 10 == 0:
		print("was randomized")
		Global.randomize_expert_accuracies()
		show_randomize_msg()
		await rent_dialog_btn.pressed
	
	Global.bdt_profit = 0.0
	Global.usd_profit = 0.0
	generate_post()
	
	balance.text =  "Balance: " + "%.2f" % Global.balance
	show_rent_dialog()
	invest_amount = min(10000, Global.balance)
	money_display.text = "%.2f" % invest_amount
	
	#print("USD: ", djt_accuracy, "/", musk_accuracy, "/", powell_accuracy)
	#print("BDT: ", yunus_accuracy, "/", zia_accuracy, "/", rahman_accuracy)

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ESCAPE"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		call_deferred("go_to_menu")
		
	# Check if the button is currently being held down
	if $KotiPotiPage/PlusBtn.is_pressed():
		press_timer -= delta
		if press_timer <= 0:
			add_investment()
			press_timer = repeat_delay
	elif $KotiPotiPage/MinusBtn.is_pressed():
		press_timer -= delta
		if press_timer <= 0:
			minus_investment()
			press_timer = repeat_delay
	else:
		# Reset timer when button is released so the next click is instant
		press_timer = 0
		
func add_investment() -> void:
	if Global.balance >= invest_amount + 5000.0:
		invest_amount += 5000.0
		money_display.text = "%.2f" % invest_amount
		
func minus_investment() -> void:
	if invest_amount - 5000.0 > 0:
		invest_amount -= 5000.0
		money_display.text = "%.2f" % invest_amount
	
func go_to_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func show_rent_dialog():
	if Global.balance < 10000.0:
		rent_dialog_text.text = "You Failed to Pay Rent! Now Get out!"
		rent_dialog_btn.text = "Game Over"
		game_over = true
		print("game over")
	elif Global.balance > Global.target:
		rent_dialog_text.text = "Wow! You became a kotipoti!"
		rent_dialog_btn.text = "You Win"
		game_win = true
	else:
		var rent:float = max(rent_amount_percentage * Global.balance, 10000)
		rent_dialog_text.text = "Congrats! You Lived Another Day to trade!\n" + "%.2f" % rent + "$ amount of rent was paid!!!"
		rent_dialog_btn.text = "OK"
		
		Global.balance -= rent 
		balance.text =  "Balance: " + "%.2f" % Global.balance
	
	rent_dialog.visible = true
	dialog_overlay.visible = true
	
func calculate_profit():
	# 1. Calculate the Multiplier (e.g., 1.05 for a 5% gain)
	var usd_multiplier_raw : float = Global.usd_profit / 9.0
	var bdt_multiplier_raw : float = Global.bdt_profit / 9.0
	
	# 2. Calculate PURE profit (The "Gain")
	var gain_usd = usd_multiplier_raw * Global.invest_amount_usd
	var gain_bdt = bdt_multiplier_raw * Global.invest_amount_bdt
	
	# 3. Calculate Total Returns (Investment + Gain)
	var total_return_usd = Global.invest_amount_usd + gain_usd
	var total_return_bdt = Global.invest_amount_bdt + gain_bdt
	
	# 4. Update Global Balance with the TOTAL returns
	Global.balance += total_return_usd + total_return_bdt
	balance.text = "Balance: " + "%.2f" % Global.balance
	
	# 5. Calculate percentages for the dialog (e.g., 0.05 * 100 = 5.0%)
	var usd_percent = usd_multiplier_raw * 100.0
	var bdt_percent = bdt_multiplier_raw * 100.0
	
	# Pass the percentage and the PURE gain to the dialog
	show_profit_dialog(usd_percent, gain_usd, bdt_percent, gain_bdt)
	
func show_profit_dialog(x, xx, y, yy):
	# Add a "+" sign if the gain is positive
	var usd_prefix = "+" if x >= 0 else ""
	var bdt_prefix = "+" if y >= 0 else ""
	
	rent_dialog_text.text = "USD Market: " + usd_prefix + "%.2f" % x + "%\n" + \
							"Gained: $" + "%.2f" % xx + "\n\n" + \
							"BDT Market: " + bdt_prefix + "%.2f" % y + "%\n" + \
							"Gained: ৳" + "%.2f" % yy
	
	rent_dialog_btn.text = "OK"
	rent_dialog.visible = true
	dialog_overlay.visible = true
	

# Show Randomize Msg - similar dialog box to rent dialog
func show_randomize_msg():
	rent_dialog_text.text = "Warning! Character Accuracies were randomized!\nYour Trustworthy Character might betray you!"
	rent_dialog_btn.text = "OK"
	rent_dialog.visible = true
	dialog_overlay.visible = true

# Show first time kichir-michir page help
func show_kichir_michir_first_time_msg():
	rent_dialog_text.text = "Welcome to in-game social media 'Kichir-Michir.com'.\nNot Everyone is truthful here! So, be careful.\n To find who is truthful use the newspaper 'Chander-Alo.com'.\n You can use the counter beside each celebraty name to keep track of who you trust more."
	rent_dialog_btn.text = "OK"
	rent_dialog.visible = true
	dialog_overlay.visible = true

	
func generate_news():
	$ChanderAloPage/DjtPost/MarginContainer/VBoxContainer/Label2.text = Global.djt_news
	$ChanderAloPage/MuskPost/MarginContainer/VBoxContainer/Label2.text = Global.elon_news
	$ChanderAloPage/PowellPost/MarginContainer/VBoxContainer/Label2.text = Global.jeremy_news
	$ChanderAloPage/YunusPost/MarginContainer/VBoxContainer/Label2.text = Global.yunus_news
	$ChanderAloPage/TarekPost/MarginContainer/VBoxContainer/Label2.text = Global.tarek_news
	$ChanderAloPage/ShafiqurPost/MarginContainer/VBoxContainer/Label2.text = Global.shafiq_news
	
	if Global.djt_true:
		$ChanderAloPage/DjtPost/MarginContainer/VBoxContainer/HBoxContainer/TrueFalse.texture = preload("res://assets/check.png")
	else:
		$ChanderAloPage/DjtPost/MarginContainer/VBoxContainer/HBoxContainer/TrueFalse.texture = preload("res://assets/remove.png")
	
	$ChanderAloPage/MuskPost/MarginContainer/VBoxContainer/HBoxContainer/TrueFalse.texture = preload("res://assets/check.png") if Global.elon_true else preload("res://assets/remove.png")
	$ChanderAloPage/PowellPost/MarginContainer/VBoxContainer/HBoxContainer/TrueFalse.texture = preload("res://assets/check.png") if Global.jeremy_true else preload("res://assets/remove.png")
	$ChanderAloPage/YunusPost/MarginContainer/VBoxContainer/HBoxContainer/TrueFalse.texture = preload("res://assets/check.png") if Global.yunus_true else preload("res://assets/remove.png")
	$ChanderAloPage/TarekPost/MarginContainer/VBoxContainer/HBoxContainer/TrueFalse.texture = preload("res://assets/check.png") if Global.tarik_true else preload("res://assets/remove.png")
	$ChanderAloPage/ShafiqurPost/MarginContainer/VBoxContainer/HBoxContainer/TrueFalse.texture = preload("res://assets/check.png") if Global.shafiq_true else preload("res://assets/remove.png")
	
	
func generate_post():
	generate_djt_post()
	generate_musk_post()
	generate_powell_post()
	generate_yunus_post()
	generate_zia_post()
	generate_rahman_post()
	
func generate_djt_post():
	var post_type := randi_range(0, 2)
	var post_index := randi_range(0, 4)
	
	var post_truth := randi_range(0, 100)
	var truth := true
	if post_truth > djt_accuracy:
		truth = false
	
	var post_text := ""
	if post_type == 0:
		post_text = djt_good_news[post_index][0] #post
		if truth:
			Global.djt_news = djt_good_news[post_index][1]
			Global.usd_profit += 5.0
		else:
			Global.djt_news = djt_good_news[post_index][2]
	elif post_type == 1:
		post_text = djt_bad_news[post_index][0] #post
		if truth:
			Global.djt_news = djt_bad_news[post_index][1]
			Global.usd_profit -= 3.0
		else:
			Global.djt_news = djt_bad_news[post_index][2]
	else:
		post_text = djt_hype_news[post_index][0] #post
		if truth:
			Global.djt_news = djt_hype_news[post_index][1]
			Global.usd_profit += 1.0
		else:
			Global.djt_news = djt_hype_news[post_index][2]
			Global.usd_profit -= 1.0
			
	Global.djt_true = truth
	#Display DJT post
	djt_post_label.text = post_text

# --- USD INFLUENCERS ---

func generate_musk_post():
	var res = process_character_post(musk_good_news, musk_bad_news, musk_hype_news, musk_accuracy, "usd", musk_social_post_label)
	Global.elon_news = res[0]
	Global.elon_true = res[1]

func generate_powell_post():
	var res = process_character_post(powell_good_news, powell_bad_news, powell_hype_news, powell_accuracy, "usd", powell_social_post_label)
	Global.jeremy_news = res[0]
	Global.jeremy_true = res[1]
# --- BDT INFLUENCERS ---

func generate_yunus_post():
	var res = process_character_post(yunus_good_news, yunus_bad_news, yunus_hype_news, yunus_accuracy, "bdt", yunus_social_post_label)
	Global.yunus_news = res[0]
	Global.yunus_true = res[1]

func generate_zia_post():
	var res = process_character_post(tarek_good_news, tarek_bad_news, tarek_hype_news, zia_accuracy, "bdt", tareq_social_post_label)
	Global.tarek_news = res[0]
	Global.tarik_true = res[1]

func generate_rahman_post():
	var res = process_character_post(shafiqur_good_news, shafiqur_bad_news, shafiqur_hype_news, rahman_accuracy, "bdt", shafiq_social_post_label)
	Global.shafiq_news = res[0]
	Global.shafiq_true = res[1]

# --- REUSABLE HELPER FUNCTION ---
# This avoids repeating the same if/else logic 6 times!

func process_character_post(good_list, bad_list, hype_list, accuracy, currency_type, social_post_label) -> Array:
	var roll := randi_range(0, 6)
	var post_type: int = 0

	# 2. Map the roll to your desired post_type
	if roll <= 2:
		post_type = 0  # 0, 1, 2 (50% chance)
	elif roll <= 5:
		post_type = 1  # 3, 4, 5 (37.5% chance)
	else:
		post_type = 2  # 6 (12.5% chance)
	
	var post_index := randi_range(0, 4)
	var truth:bool = (randi_range(0, 100) <= accuracy)
	
	var post_text := ""
	var news_headline := ""
	var profit_change := 0.0

	if post_type == 0: # GOOD NEWS
		post_text = good_list[post_index][0]
		news_headline = good_list[post_index][1] if truth else good_list[post_index][2]
		if truth: 
			profit_change = 5.0
			#post_text += "truth"
			
	elif post_type == 1: # BAD NEWS
		post_text = bad_list[post_index][0]
		news_headline = bad_list[post_index][1] if truth else bad_list[post_index][2]
		if truth: 
			profit_change = -3.0
			#post_text += "truth"
			
	else: # HYPE NEWS
		post_text = hype_list[post_index][0]
		news_headline = hype_list[post_index][1] if truth else hype_list[post_index][2]
		profit_change = 1.0 if truth else -1.0

	# Apply the profit to the correct currency
	if currency_type == "usd":
		Global.usd_profit += profit_change
	else:
		Global.bdt_profit += profit_change
	
	# Update your UI Label (Assuming a generic label for whoever is posting)
	social_post_label.text = post_text
	
	return [news_headline, truth]

func _on_close_btn_pressed() -> void:
	call_deferred("change_scene")
	
func change_scene():
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_confirm_pressed() -> void:
	if game_over:
		call_deferred("go_to_game_over")
	
	if game_win:
		call_deferred("go_to_you_win")
	
	rent_dialog.hide()
	dialog_overlay.visible = false

func go_to_game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func go_to_you_win():
	get_tree().change_scene_to_file("res://scenes/you_win.tscn")


func _on_bdt_btn_pressed() -> void:
	if selected_currency != 0:
		selected_currency = 0
		
		bdt_btn.texture_normal = preload("res://assets/koti-poti/Asset 11.png")
		bdt_btn.texture_hover = null
		bdt_btn.texture_pressed = null
		
		usd_btn.texture_normal = preload("res://assets/koti-poti/Asset 9.png")
		usd_btn.texture_hover = preload("res://assets/koti-poti/Asset 10.png")
		usd_btn.texture_pressed = preload("res://assets/koti-poti/Asset 9.png")
		
		print(selected_currency)



func _on_usd_btn_pressed() -> void:
	if selected_currency != 1:
		selected_currency = 1
		
		usd_btn.texture_normal = preload("res://assets/koti-poti/Asset 11.png")
		usd_btn.texture_hover = null
		usd_btn.texture_pressed = null
		
		bdt_btn.texture_normal = preload("res://assets/koti-poti/Asset 9.png")
		bdt_btn.texture_hover = preload("res://assets/koti-poti/Asset 10.png")
		bdt_btn.texture_pressed = preload("res://assets/koti-poti/Asset 9.png")
		
		print(selected_currency)


func _on_minus_btn_pressed() -> void:
	pass


func _on_invest_btn_pressed() -> void:
	if Global.balance >= invest_amount:
		Global.balance -= invest_amount
		if selected_currency == 0:
			Global.invest_amount_bdt += invest_amount
		else:
			Global.invest_amount_usd += invest_amount
		balance.text =  "Balance: " + "%.2f" % Global.balance
		print(Global.invest_amount_bdt, Global.invest_amount_usd)
	


func _on_kichir_michir_tab_pressed() -> void:
	if current_tab != 1:
		current_tab = 1
		koti_poti_page.visible = false
		kichir_michir_page.visible = true
		chander_alo_page.visible = false
		
		koti_poti_btn.texture_normal = preload("res://assets/koti-poti/koti-poti-tab-unselected.png")
		kichir_michir_btn.texture_normal = preload("res://assets/kichir-michir/kichir-michir-tab-selected.png")
		chander_alo_btn.texture_normal = preload("res://assets/chander-alo/chander-alo.png")
		
		# Show first time kichir michir msg
		if Global.first_time_kichir_michir:
			show_kichir_michir_first_time_msg()
			await rent_dialog_btn.pressed
			Global.first_time_kichir_michir = false
		


func _on_koti_poti_tab_pressed() -> void:
	if current_tab != 2:
		current_tab = 2
		koti_poti_page.visible = true
		kichir_michir_page.visible = false
		chander_alo_page.visible = false
		
		koti_poti_btn.texture_normal = preload("res://assets/koti-poti/koti-poti-tab.png")
		kichir_michir_btn.texture_normal = preload("res://assets/kichir-michir/kichir-michir-tab.png")
		chander_alo_btn.texture_normal = preload("res://assets/chander-alo/chander-alo.png")


func _on_chander_alo_tab_pressed() -> void:
	if current_tab != 0:
		current_tab = 0
		koti_poti_page.visible = false
		kichir_michir_page.visible = false
		chander_alo_page.visible = true
		
		koti_poti_btn.texture_normal = preload("res://assets/koti-poti/koti-poti-tab-unselected.png")
		kichir_michir_btn.texture_normal = preload("res://assets/kichir-michir/kichir-michir-tab.png")
		chander_alo_btn.texture_normal = preload("res://assets/chander-alo/chander-alo-selected.png")
