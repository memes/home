.DELETE_ON_ERROR:

SOURCES := $(wildcard *.p12)
PEMS := $(SOURCES:.p12=.pem)
KEYS := $(SOURCES:.p12=.key)

.DEFAULT:
all: $(PEMS) $(KEYS)

%.pem: %.p12
	openssl pkcs12 -in $< -out $@ -clcerts -nokeys

%.key: %.p12
	openssl pkcs12 -in $< -out $@ -nocerts -nodes
