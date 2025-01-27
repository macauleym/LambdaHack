# some of this (not the parts run by CI) needs 'cabal install cabal-plan'
play:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix play --dumpInitRngs

shot:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix play --dumpInitRngs --printEachScreen

expose-lore:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix know --newGame 5 --dumpInitRngs --gameMode crawl --knowItems --exposePlaces --exposeItems --exposeActors --showItemSamples --benchmark --noAnim --maxFps 1000

dig-lore:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix know --newGame 5 --dumpInitRngs --gameMode dig --knowItems --exposePlaces --exposeItems --exposeActors --showItemSamples --benchmark --noAnim --maxFps 1000

see-caves:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix know --newGame 5 --dumpInitRngs --gameMode see --knowItems --exposePlaces --exposeItems --exposeActors --showItemSamples --benchmark --noAnim --maxFps 1000

short-caves:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix know --newGame 5 --dumpInitRngs --gameMode short --knowItems --exposePlaces --exposeItems --exposeActors --showItemSamples --benchmark --noAnim --maxFps 1000

configure-debug:
	cabal configure --enable-profiling --profiling-detail=all-functions -fwith_expensive_assertions --disable-optimization

configure-prof:
	cabal configure --enable-profiling --profiling-detail=exported-functions

ghcjs-build:
	cabal build --ghcjs .

chrome-log:
	google-chrome --enable-logging --v=1 file:///home/mikolaj/r/lambdahack.github.io/index.html &

chrome-prof:
	google-chrome --no-sandbox --js-flags="--logfile=%t.log --prof" ../lambdahack.github.io/index.html

minific:
	npx google-closure-compiler dist-newstyle/build/x86_64-linux/ghcjs-8.6.0.1/LambdaHack-0.10.2.0/x/LambdaHack/build/LambdaHack/LambdaHack.jsexe/all.js --compilation_level=ADVANCED_OPTIMIZATIONS --isolation_mode=IIFE --assume_function_wrapper --externs=dist-newstyle/build/x86_64-linux/ghcjs-8.6.0.1/LambdaHack-0.10.2.0/x/LambdaHack/build/LambdaHack/LambdaHack.jsexe/all.js.externs --externs=/home/mikolaj/r/lambdahack.github.io/lz-string.extern.js --jscomp_off="*" > ../lambdahack.github.io/lambdahack.all.js

minificForNode:
	npx google-closure-compiler dist-newstyle/build/x86_64-linux/ghcjs-8.6.0.1/LambdaHack-0.10.2.0/x/LambdaHack/build/LambdaHack/LambdaHack.jsexe/all.js --compilation_level=ADVANCED_OPTIMIZATIONS --isolation_mode=IIFE --assume_function_wrapper --externs=/home/mikolaj/r/lambdahack.github.io/lz-string.extern.js --externs=dist-newstyle/build/x86_64-linux/ghcjs-8.6.0.1/LambdaHack-0.10.2.0/x/LambdaHack/build/LambdaHack/LambdaHack.jsexe/all.js.externs --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/assert.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/child_process.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/crypto.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/dns.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/events.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/globals.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/https.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/os.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/punycode.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/readline.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/stream.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/tls.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/url.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/vm.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/buffer.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/cluster.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/dgram.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/domain.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/fs.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/http.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/net.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/path.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/querystring.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/repl.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/string_decoder.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/tty.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/util.js --externs=/home/mikolaj/r/closure-compiler/contrib/nodejs/zlib.js --jscomp_off="*" > ../lambdahack.github.io/lambdahack.all.js

# Low delay to display animations swiftly and not bore the public too much.
# Delay can't be lower than 2, because browsers sometimes treat delay 1
# specially and add their extra delay.
create-gif :
	find ~/.LambdaHack/screenshots/ -name 'prtscn*.bmp' -print0 | xargs -0 -r mogrify -format gif
	../gifsicle/src/gifsicle -O3 --careful -d2 --colors 255 --no-extensions --no-conserve-memory -l ~/.LambdaHack/screenshots/prtscn*.gif -o ~/.LambdaHack/screenshots/screenshot.gif

frontendRaid:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 5 --dumpInitRngs --automateAll --gameMode raid --exposeActors

frontendBrawl:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 5 --dumpInitRngs --automateAll --gameMode brawl

frontendShootout:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 5 --dumpInitRngs --automateAll --gameMode shootout

frontendHunt:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 5 --dumpInitRngs --automateAll --gameMode hunt

frontendEscape:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 3 --dumpInitRngs --automateAll --gameMode escape

frontendZoo:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 2 --dumpInitRngs --automateAll --gameMode zoo --exposeActors

frontendAmbush:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 5 --dumpInitRngs --automateAll --gameMode ambush

frontendCrawl:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 1 --dumpInitRngs --automateAll --gameMode crawl --exposeItems --exposeActors

frontendCrawlEmpty:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 1 --dumpInitRngs --automateAll --gameMode crawlEmpty

frontendCrawlSurvival:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 9 --dumpInitRngs --automateAll --gameMode crawlSurvival --maxFps 1000

frontendSafari:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 5 --dumpInitRngs --automateAll --gameMode safari --exposeActors

frontendSafariSurvival:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 5 --dumpInitRngs --automateAll --gameMode safariSurvival --exposeActors

frontendBattle:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 4 --dumpInitRngs --automateAll --gameMode battle --exposeActors

frontendBattleDefense:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 6 --dumpInitRngs --automateAll --gameMode battleDefense --exposeActors

frontendBattleSurvival:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 6 --dumpInitRngs --automateAll --gameMode battleSurvival --exposeActors

frontendDefense:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 9 --dumpInitRngs --automateAll --gameMode defense --exposeItems --exposeActors

frontendDefenseEmpty:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 9 --dumpInitRngs --automateAll --gameMode defenseEmpty

fastCrawl:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 1 --dumpInitRngs --automateAll --gameMode crawl --exposeItems --exposeActors --showItemSamples --noAnim --maxFps 100000 --benchmark

slowCrawl:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --savePrefix test --newGame 1 --dumpInitRngs --automateAll --gameMode crawl --exposeItems --exposeActors --showItemSamples

# different benchmarks use different arguments
RNGOPTS=--setDungeonRng "SMGen 123 123" --setMainRng "SMGen 123 125"
RNGOPTS1=--setDungeonRng "SMGen 127 123" --setMainRng "SMGen 127 125"
RNGOPTS2=--setDungeonRng "SMGen 129 123" --setMainRng "SMGen 129 125"

benchMemoryAnim:
	$$(cabal-plan list-bin exe:LambdaHack) --dbgMsgSer --logPriority 4 --newGame 1 --maxFps 100000 --benchmark --stopAfterFrames 33000 --automateAll --keepAutomated --gameMode crawl $(RNGOPTS2)  --frontendNull --noAnim +RTS -s -A1M -RTS

benchBattle:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 3 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 1500 --automateAll --keepAutomated --gameMode battle $(RNGOPTS1)

benchAnimBattle:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 3 --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 7000 --automateAll --keepAutomated --gameMode battle $(RNGOPTS1)

benchFrontendBattle:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 3 --noAnim --maxFps 100000 --benchmark --stopAfterFrames 2000 --automateAll --keepAutomated --gameMode battle $(RNGOPTS1)

benchCrawl:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 7000 --automateAll --keepAutomated --gameMode crawl $(RNGOPTS)

benchFrontendCrawl:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --benchmark --stopAfterFrames 7000 --automateAll --keepAutomated --gameMode crawl $(RNGOPTS)

benchDig:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 1 --automateAll --keepAutomated --gameMode dig $(RNGOPTS)

benchNull: benchBattle benchAnimBattle benchCrawl

bench: benchBattle benchAnimBattle benchFrontendBattle benchCrawl benchFrontendCrawl

nativeBenchCrawl:
	$$(cabal-plan list-bin exe:LambdaHack)		   --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 2000 --automateAll --keepAutomated --gameMode crawl $(RNGOPTS)

nativeBenchBattle:
	$$(cabal-plan list-bin exe:LambdaHack)		   --dbgMsgSer --logPriority 4 --newGame 3 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 1000 --automateAll --keepAutomated --gameMode battle $(RNGOPTS)

nativeBench: nativeBenchBattle nativeBenchCrawl

nodeBenchCrawl:
	node $$(cabal-plan list-bin exe:LambdaHack).jsexe/all.js --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 2000 --automateAll --keepAutomated --gameMode crawl $(RNGOPTS)

nodeBenchBattle:
	node $$(cabal-plan list-bin exe:LambdaHack).jsexe/all.js --dbgMsgSer --logPriority 4 --newGame 3 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 1000 --automateAll --keepAutomated --gameMode battle $(RNGOPTS)

nodeBench: nodeBenchBattle nodeBenchCrawl

nodeMinifiedBench:
	node ../lambdahack.github.io/lambdahack.all.js --dbgMsgSer --logPriority 4 --newGame 3 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 1000 --automateAll --keepAutomated --gameMode battle $(RNGOPTS)
	node ../lambdahack.github.io/lambdahack.all.js --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterFrames 2000 --automateAll --keepAutomated --gameMode crawl $(RNGOPTS)


test-travis: test-short test-medium

test-travis2: test-sniff benchNull

test: test-sniff test-short test-medium benchNull

test-short: test-short-new test-short-load

test-medium: testRaid-medium testBrawl-medium testShootout-medium testHunt-medium testEscape-medium testZoo-medium testAmbush-medium testCrawlEmpty-medium testCrawl-medium-know testSafari-medium testSafariSurvival-medium testBattle-medium testBattleDefense-medium testBattleSurvival-medium testDig-medium testDefenseEmpty-medium testMany-teletype

test-sniff:
	bash -c "./LambdaHack --dbgMsgSer --logPriority 4 --newGame 5 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterFrames 1  --dumpInitRngs --automateAll --keepAutomated --gameMode raid --sniff &> /tmp/teletypetest.log"

testMany-teletype:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 9 --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 50 --dumpInitRngs --automateAll --keepAutomated 2> /tmp/teletypetest.log

testMany-sdlInit:
	./LambdaHack --dbgMsgSer --logPriority 0 --boostRandomItem --newGame 9 --maxFps 100000 --benchmark --stopAfterSeconds 50 --dumpInitRngs --automateAll --keepAutomated 2> /tmp/teletypetest.log

testRaid-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 20 --dumpInitRngs --automateAll --keepAutomated --gameMode raid 2> /tmp/teletypetest.log

testBrawl-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 20 --dumpInitRngs --automateAll --keepAutomated --gameMode brawl 2> /tmp/teletypetest.log

testShootout-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 20 --dumpInitRngs --automateAll --keepAutomated --gameMode shootout 2> /tmp/teletypetest.log

testHunt-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 20 --dumpInitRngs --automateAll --keepAutomated --gameMode hunt 2> /tmp/teletypetest.log

testEscape-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 3 --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 40 --dumpInitRngs --automateAll --keepAutomated --gameMode escape 2> /tmp/teletypetest.log

testZoo-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 2 --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 40 --dumpInitRngs --automateAll --keepAutomated --gameMode zoo 2> /tmp/teletypetest.log

testAmbush-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 20 --dumpInitRngs --automateAll --keepAutomated --gameMode ambush 2> /tmp/teletypetest.log

testCrawl-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterGameOver --stopAfterSeconds 200 --dumpInitRngs --automateAll --keepAutomated --gameMode crawl --assertExplored 5 2> /tmp/teletypetest.log

testCrawl-medium-double:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendLazy --benchmark --stopAfterGameOver --stopAfterSeconds 590 --dumpInitRngs --automateAll --keepAutomated --gameMode crawl --assertExplored 4

testCrawlEmpty-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 40 --dumpInitRngs --automateAll --keepAutomated --gameMode crawlEmpty 2> /tmp/teletypetest.log

testCrawl-medium-know:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix know --newGame 1 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 100 --dumpInitRngs --automateAll --keepAutomated --gameMode crawl --knowItems --exposePlaces --exposeItems --exposeActors --showItemSamples 2> /tmp/teletypetest.log

testSafari-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 100 --dumpInitRngs --automateAll --keepAutomated --gameMode safari 2> /tmp/teletypetest.log

testSafariSurvival-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 40 --dumpInitRngs --automateAll --keepAutomated --gameMode safariSurvival 2> /tmp/teletypetest.log

testBattle-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 3 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 20 --dumpInitRngs --automateAll --keepAutomated --gameMode battle 2> /tmp/teletypetest.log

testBattleDefense-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 7 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 40 --dumpInitRngs --automateAll --keepAutomated --gameMode battleDefense 2> /tmp/teletypetest.log

testBattleSurvival-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 7 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 40 --dumpInitRngs --automateAll --keepAutomated --gameMode battleSurvival 2> /tmp/teletypetest.log

testDefense-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 9 --noAnim --maxFps 100000 --frontendLazy --benchmark --stopAfterSeconds 100 --dumpInitRngs --automateAll --keepAutomated --gameMode defense 2> /tmp/teletypetest.log

testDig-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterFrames 100 --dumpInitRngs --automateAll --keepAutomated --gameMode dig 2> /tmp/teletypetest.log

testDefenseEmpty-medium:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 9 --noAnim --maxFps 100000 --frontendTeletype --benchmark --stopAfterSeconds 40 --dumpInitRngs --automateAll --keepAutomated --gameMode defenseEmpty 2> /tmp/teletypetest.log

testCrawl-appveyor:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 1 --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfterGameOver --stopAfterSeconds 300 --dumpInitRngs --automateAll --keepAutomated --gameMode crawl --assertExplored 5

testDefense-appveyor:
	./LambdaHack --dbgMsgSer --logPriority 4 --newGame 9 --noAnim --maxFps 100000 --frontendLazy --benchmark --stopAfterSeconds 600 --dumpInitRngs --automateAll --keepAutomated --gameMode defense

test-short-new:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix raid --dumpInitRngs --automateAll --keepAutomated --gameMode raid --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix brawl --dumpInitRngs --automateAll --keepAutomated --gameMode brawl --showItemSamples --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix shootout --dumpInitRngs --automateAll --keepAutomated --gameMode shootout --showItemSamples --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix hunt --dumpInitRngs --automateAll --keepAutomated --gameMode hunt --showItemSamples --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix escape --dumpInitRngs --automateAll --keepAutomated --gameMode escape --showItemSamples --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix zoo --dumpInitRngs --automateAll --keepAutomated --gameMode zoo --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix ambush --dumpInitRngs --automateAll --keepAutomated --gameMode ambush --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix crawl --dumpInitRngs --automateAll --keepAutomated --gameMode crawl --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix safari --dumpInitRngs --automateAll --keepAutomated --gameMode safari --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix safariSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode safariSurvival --showItemSamples --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix battle --showItemSamples --dumpInitRngs --automateAll --keepAutomated --gameMode battle --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix battleDefense --dumpInitRngs --automateAll --keepAutomated --gameMode battleDefense --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --newGame 5 --savePrefix battleSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode battleSurvival --frontendTeletype --stopAfterSeconds 2 2> /tmp/teletypetest.log

# $(RNGOPTS) is needed for determinism relative to seed
# generated before game save
test-short-load:
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix raid --dumpInitRngs --automateAll --keepAutomated --gameMode raid --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix brawl --dumpInitRngs --automateAll --keepAutomated --gameMode brawl --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix shootout --dumpInitRngs --automateAll --keepAutomated --gameMode shootout --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix hunt --dumpInitRngs --automateAll --keepAutomated --gameMode hunt --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix escape --dumpInitRngs --automateAll --keepAutomated --gameMode escape --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix zoo --dumpInitRngs --automateAll --keepAutomated --gameMode zoo --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix ambush --dumpInitRngs --automateAll --keepAutomated --gameMode ambush --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix crawl --dumpInitRngs --automateAll --keepAutomated --gameMode crawl --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix safari --dumpInitRngs --automateAll --keepAutomated --gameMode safari --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix safariSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode safariSurvival --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix battle --dumpInitRngs --automateAll --keepAutomated --gameMode battle --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix battleDefense --dumpInitRngs --automateAll --keepAutomated --gameMode battleDefense --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log
	./LambdaHack --dbgMsgSer --logPriority 4 --boostRandomItem --savePrefix battleSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode battleSurvival --frontendTeletype --stopAfterSeconds 2 $(RNGOPTS) 2> /tmp/teletypetest.log


build-binary-v1:
	cabal v1-install --force-reinstalls --disable-library-profiling --disable-profiling --disable-documentation --enable-optimization --only-dependencies
	cabal v1-configure --disable-library-profiling --disable-profiling --enable-optimization
	cabal v1-build exe:LambdaHack

copy-binary-v1:
	cabal v1-copy --destdir=LambdaHackTheGameInstall

copy-binary:
	cp $$(cabal-plan list-bin exe:LambdaHack) LambdaHackTheGame

configure-binary-v2:
	cabal configure --disable-tests --disable-library-profiling --disable-profiling --enable-optimization

configure-binary-v2-vty:
	cabal configure -fvty --disable-tests --disable-library-profiling --disable-profiling --disable-documentation --enable-optimization

build-binary-v2:
	cabal build --only-dependencies .
	cabal build exe:LambdaHack

copy-directory:
	mkdir -p LambdaHackTheGame/GameDefinition
	cp GameDefinition/InGameHelp.txt LambdaHackTheGame/GameDefinition
	cp GameDefinition/PLAYING.md LambdaHackTheGame/GameDefinition
	cp README.md LambdaHackTheGame
	cp CHANGELOG.md LambdaHackTheGame
	cp LICENSE LambdaHackTheGame
	cp COPYLEFT LambdaHackTheGame
	cp CREDITS LambdaHackTheGame

build-binary-common: build-binary-v1 copy-directory copy-binary-v1

build-binary-windows: configure-binary-v2 build-binary-v2 copy-directory

build-directory: configure-binary-v2 build-binary-v2 copy-directory copy-binary

build-binary-ubuntu: build-directory
	LambdaHackTheGame/LambdaHack --version > /dev/null; \
	LH_VERSION=$$(cat ~/.LambdaHack/stdout.txt); \
	tar -czf LambdaHack_$${LH_VERSION}_ubuntu-16.04-amd64.tar.gz LambdaHackTheGame

build-binary-macosx: build-directory
	LambdaHackTheGame/LambdaHack --version > /dev/null; \
	LH_VERSION=$$(cat ~/.LambdaHack/stdout.txt); \
	OS_VERSION=$$(sw_vers -productVersion); \
	tar -czf LambdaHack_$${LH_VERSION}_macosx-$${OS_VERSION}-amd64.tar.gz LambdaHackTheGame

build-directory-vty: configure-binary-v2-vty build-binary-v2 copy-directory copy-binary

build-binary-screen-reader-ubuntu: build-directory-vty
	LambdaHackTheGame/LambdaHack --version > /dev/null; \
	LH_VERSION=$$(cat ~/.LambdaHack/stdout.txt); \
	tar -czf LambdaHack_$${LH_VERSION}_screen-reader-ubuntu-16.04-amd64.tar.gz LambdaHackTheGame


# sdl would need to be added to
# https://github.com/utdemir/ghc-musl/blob/master/Dockerfile
# (or compatible libraries stored in local directory and added to options)
# in order to compile LH statically with the scripts below
configure-static-binary-v2:
	cabal configure --disable-tests --disable-library-profiling --disable-profiling --enable-optimization --enable-executable-stripping --enable-executable-static

configure-static-binary-v2-vty:
	cabal configure -fvty --disable-tests --disable-library-profiling --disable-profiling --disable-documentation --enable-optimization --enable-executable-stripping --enable-executable-static

build-static-directory: configure-static-binary-v2 build-binary-v2 copy-directory copy-binary

build-static-binary-ubuntu: build-static-directory
	LambdaHackTheGame/LambdaHack --version > /dev/null; \
	LH_VERSION=$$(cat ~/.LambdaHack/stdout.txt); \
	tar -czf LambdaHack_$${LH_VERSION}_ubuntu-16.04-amd64.tar.gz LambdaHackTheGame

build-static-directory-vty: configure-static-binary-v2-vty build-binary-v2 copy-directory copy-binary

build-static-binary-screen-reader-ubuntu: build-static-directory-vty
	LambdaHackTheGame/LambdaHack --version > /dev/null; \
	LH_VERSION=$$(cat ~/.LambdaHack/stdout.txt); \
	tar -czf LambdaHack_$${LH_VERSION}_screen-reader-ubuntu-16.04-amd64.tar.gz LambdaHackTheGame
