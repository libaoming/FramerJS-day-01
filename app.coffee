
# basic setting
amount = 4
margin = 80
marginHor = margin
marginVer = 3 * margin
indictorD = 14
allCards = []
allIndictors = []
allBg = []


# Create PageComponent
page = new PageComponent
	point: Align.center
	width: Screen.width
	height: Screen.height 
	scrollVertical: false
	backgroundColor: 'rgba(0,0,0,0.2)'


# Loop to create pages
for i in [0...amount]
	
	bg = new Layer 
		width: Screen.width
		height: Screen.height
		x: 0
		y: 0
		opacity: 0
		backgroundColor: 'none'
		index: 0 
	bg.states.add(active:{opacity:1})
	bg.states.animationOptions = time: 0.3
	
	card = new Layer
		html: i
		backgroundColor: "#fff"
		borderRadius: 15
		width: page.width - (marginHor * 2)
		height:  page.height - (marginVer * 2)
		x: page.width * (i + 1)  + marginHor
		y: 150
		opacity: 0.7
		scale: 0.6
		shadowY: 10
		shadowBlur: 10
		shadowColor: "rgba(0,0,0,0.8)"
		# Very important these layers be added the "page" PageComponent
		superLayer: page.content
	
	indicator = new Layer
		backgroundColor: 'eee'
		size: indictorD
		y: 1120
		x: marginHor/2 * i + Screen.width/2 - 80
		borderRadius: 50
		opacity: 0.45
	indicator.states.add(active:{opacity:1,scale:1.2})
	indicator.states.animationOptions = time: 0.2
	
	allBg.push bg
	allCards.push card
	allIndictors.push indicator
		
	
	card.style = 
		'color': 'black'
		'font-size':'33rem'
		'text-align': 'center'
		'font-family': 'Freight'
		'padding-top': '25rem'

# fix page 3 x bugs
page.snapToPage(page.content.subLayers[0])
page.content.subLayers[amount-1].x = page.content.subLayers[amount-1].x -  marginHor

allIndictors[0].opacity = 1
allBg[0].opacity = 1

for i in [0...amount]
	allBg[i].image = 'images/'+ i + '.jpg'


for card in allCards
	card.states.add
		normal:
			scale: 0.8
			shadowY: 10
			shadowBlur: 10
			shadowColor:'rgba(0,0,0,0.8)'
			opacity:0.95
		active:
			scale: 1.1 
			opacity: 1
			shadowColor:'rgba(0,0,0,0.97)'
			shadowY: 50
			shadowBlur: 50
	
	card.onClick ->
		this.states.next('active','normal')
		this.states.animationOptions = curve: 'spring(480,22,0)'
			

page.onChange 'currentPage', ->
	current = page.horizontalPageIndex(page.currentPage)
	indicator.states.switch('default') for indicator in allIndictors
	allIndictors[current].states.switch('active')
	
	card.states.switch('default') for card in allCards
	allCards[current].states.switch('normal')	
	
	bg.opacity = 0 for bg in allBg
	allBg[current].states.switch('active')	
	
	
allCards[0].scale = 0.8
allCards[0].opacity = 0.95			