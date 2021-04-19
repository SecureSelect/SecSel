CXXFLAGS=-g
CXXFLAGS= -std=gnu++11 -D_REENTRANT -Wno-deprecated-declarations

##BN256 128-100 bits of security
OBJ=getTime.o bn_pair.o zzn2.o zzn12a.o zzn4.o ecn2.o big.o zzn.o ecn.o base64.o oe-m.o aoe-m.o
PAIRING=MR_PAIRING_BN
SECURITY=128

##BN 192 bits of security
#OBJ=bn_pair.o zzn2.o zzn12a.o zzn4.o ecn2.o big.o zzn.o ecn.o base64.o oe-m.o aoe-m.o
#PAIRING=MR_PAIRING_BN
#SECURITY=192

##BLS 256 bits of security
#OBJ=bls_pair.o zzn2.o zzn4.o zzn8.o zzn24.o ecn4.o big.o zzn.o ecn.o base64.o oe-m.o aoe-m.o
#PAIRING=MR_PAIRING_BLS
#SECURITY=256

EXE= GenKey EncRow GenToken ApplyToken ApplyPToken ApplyMToken

EXE: ${EXE}

GenKey.o: GenKey.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c GenKey.cpp -o GenKey.o

EncRow.o: EncRow.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c EncRow.cpp -o EncRow.o

GenToken.o: GenToken.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c GenToken.cpp -o GenToken.o

ApplyToken.o: ApplyToken.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c ApplyToken.cpp -o ApplyToken.o

ApplyPToken.o: ApplyPToken.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c ApplyPToken.cpp -o ApplyPToken.o

ApplyMToken.o: ApplyMToken.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c ApplyMToken.cpp -o ApplyMToken.o

GenKey: ${OBJ} GenKey.o
	g++ -o GenKey ${OBJ} GenKey.o miracl.a -lcrypto -lssl -lpthread

EncRow: ${OBJ} EncRow.o
	g++ -o EncRow ${OBJ} EncRow.o miracl.a -lcrypto -lssl -lpthread

GenToken: ${OBJ} GenToken.o
	g++ -o GenToken ${OBJ} GenToken.o miracl.a -lcrypto -lssl -lpthread

ApplyToken: ${OBJ} ApplyToken.o
	g++ -o ApplyToken ${OBJ} ApplyToken.o miracl.a -lcrypto -lssl -lpthread

ApplyPToken: ${OBJ} ApplyPToken.o
	g++ -o ApplyPToken ${OBJ} ApplyPToken.o miracl.a -lcrypto -lssl -lpthread

ApplyMToken: ${OBJ} ApplyMToken.o
	g++ -o ApplyMToken ${OBJ} ApplyMToken.o miracl.a -lcrypto -lssl -lpthread

oe-m.o: oe-m.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c oe-m.cpp -o oe-m.o

aoe-m.o: aoe-m.cpp
	g++ -std=gnu++11 -D ${PAIRING} -D AES_SECURITY=${SECURITY} -c aoe-m.cpp -o aoe-m.o

all: ${EXE}

clean:
	rm -f ${OBJ} ${EXE} GenKey.o EncRow.o GenToken.o ApplyToken.o ApplyPToken.o ApplyMToken.o



