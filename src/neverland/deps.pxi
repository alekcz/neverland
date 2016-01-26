(ns neverland.deps
	(:require 	[pixie.ffi :as ffi]
				[pixie.ffi-infer :as f]))

(f/with-config {:library "c" :includes ["stdio.h" "string.h" "stdlib.h" "netdb.h" "sys/types.h" "sys/socket.h" "netdb.h"]}; "arpa/inet.h" "netinet/in.h"]} 

	(f/defcfn getaddrinfo)
	(f/defcfn freeaddrinfo)
	(f/defcfn gai_strerror)
	(f/defcstruct addrinfo [ :ai_flags
						:ai_family
						:ai_socktype
						:ai_protocol
						:ai_addrlen
						:ai_addr
						:ai_canonname
						:ai_next]))