run: target/classes INPUT/AtomicCards.json INPUT/CardsMissingInMagarena.txt
	mvn exec:exec -Dexec.executable="java" -Dexec.args="-cp %classpath mtgjson.reader.MtgJsonReader"

clean:
	mvn clean
	-rm -rvf results

target/classes:
	mvn compile

%.txt: %.json
	jq -r '.cards | map(.name) | join("\n")' $^ | sort | uniq > $@

set ?= FRF

INPUT/AtomicCards.json:
	wget https://mtgjson.com/api/v5/AtomicCards.json -O $@

#AtomicCards.json: ${set}.json
#	jq '{"ABC": .}' $^ > $@

#CardsMissingInMagarena.txt: ${set}.txt
#	mv $^ $@
