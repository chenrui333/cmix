CC = g++
CFLAGS = -std=c++11 -Wall -c
LFLAGS = -std=c++11 -Wall

OBJS = build/encoder.o build/decoder.o build/predictor.o  build/mixer-input.o build/mixer.o build/sse.o build/manager.o build/direct.o build/indirect.o build/nonstationary.o build/run-map.o build/match.o build/context-hash.o build/rubin-karp.o build/sparse.o build/bit-buffer.o

all: CFLAGS += -O3
all: LFLAGS += -O3
all: cmix

debug: CFLAGS += -ggdb
debug: LFLAGS += -ggdb
debug: cmix

cmix: $(OBJS) src/runner.cpp
	$(CC) $(LFLAGS) $(OBJS) src/runner.cpp -o cmix

build/encoder.o: src/coder/encoder.h src/coder/encoder.cpp src/predictor.h
	$(CC) $(CFLAGS) src/coder/encoder.cpp -o build/encoder.o

build/decoder.o: src/coder/decoder.h src/coder/decoder.cpp src/predictor.h
	$(CC) $(CFLAGS) src/coder/decoder.cpp -o build/decoder.o

build/predictor.o: src/predictor.h src/predictor.cpp src/mixer/mixer-input.h src/mixer/mixer.h src/sse.h src/models/model.h src/models/direct.h src/models/indirect.h src/models/match.h src/manager.h src/contexts/context-hash.h src/contexts/rubin-karp.h src/contexts/sparse.h src/models/bit-buffer.h
	$(CC) $(CFLAGS) src/predictor.cpp -o build/predictor.o

build/mixer-input.o: src/mixer/mixer-input.h src/mixer/mixer-input.cpp
	$(CC) $(CFLAGS) src/mixer/mixer-input.cpp -o build/mixer-input.o

build/mixer.o: src/mixer/mixer.h src/mixer/mixer.cpp
	$(CC) $(CFLAGS) src/mixer/mixer.cpp -o build/mixer.o

build/sse.o: src/sse.h src/sse.cpp
	$(CC) $(CFLAGS) src/sse.cpp -o build/sse.o

build/manager.o: src/manager.h src/manager.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/manager.cpp -o build/manager.o

build/direct.o: src/models/direct.h src/models/direct.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/direct.cpp -o build/direct.o

build/indirect.o: src/models/indirect.h src/models/indirect.cpp src/states/state.h src/models/model.h
	$(CC) $(CFLAGS) src/models/indirect.cpp -o build/indirect.o

build/match.o: src/models/match.h src/models/match.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/match.cpp -o build/match.o

build/bit-buffer.o: src/models/bit-buffer.h src/models/bit-buffer.cpp src/models/model.h
	$(CC) $(CFLAGS) src/models/bit-buffer.cpp -o build/bit-buffer.o

build/nonstationary.o: src/states/nonstationary.h src/states/nonstationary.cpp src/states/state.h
	$(CC) $(CFLAGS) src/states/nonstationary.cpp -o build/nonstationary.o

build/run-map.o: src/states/run-map.h src/states/run-map.cpp src/states/state.h
	$(CC) $(CFLAGS) src/states/run-map.cpp -o build/run-map.o

build/context-hash.o: src/contexts/context-hash.h src/contexts/context-hash.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/context-hash.cpp -o build/context-hash.o

build/rubin-karp.o: src/contexts/rubin-karp.h src/contexts/rubin-karp.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/rubin-karp.cpp -o build/rubin-karp.o

build/sparse.o: src/contexts/sparse.h src/contexts/sparse.cpp src/contexts/context.h
	$(CC) $(CFLAGS) src/contexts/sparse.cpp -o build/sparse.o

clean:
	rm -f -r build/* cmix