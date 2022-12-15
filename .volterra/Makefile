.DELETE_ON_ERROR:

SOURCES := $(wildcard *.p12)
PEMS := $(SOURCES:.p12=.pem)
KEYS := $(SOURCES:.p12=.key)

.DEFAULT:
all: $(PEMS) $(KEYS)

%.pem: %.p12
	openssl pkcs12 -in $< -out $@ -nodes -nokeys

%.key: %.p12
	openssl pkcs12 -in $< -out $@ -nodes -nocerts
