(ns neverland.core
	(:require 	[pixie.ffi :as ffi]
				[pixie.uv :as uv]
				[pixie.stacklets :as st]
				[pixie.ffi-infer :as f]
				))


(f/with-config {:library "c" 
				:includes ["stdio.h" "string.h" "stdlib.h" "netdb.h" "sys/types.h" "sys/socket.h" "netdb.h"  "arpa/inet.h" "netinet/in.h" "netinet/ip.h"]} 

	(f/defcfn getaddrinfo)
	(f/defcfn freeaddrinfo)	
	(f/defcfn gai_strerror)
	(f/defcfn inet_ntop)
	(f/defconst SOCK_STREAM)
	(f/defconst AF_INET)
	(f/defcstruct in_addr [ :s_addr ])
	(f/defcstruct sockaddr	 [ :sa_family :sa_data ])
	;(f/defcstruct sockaddr_in [ :sin_family :sin_port :sin_addr ])
	(f/defcstruct addrinfo [ :ai_flags
						:ai_family
						:ai_socktype
						:ai_protocol
						:ai_addrlen
						:ai_addr
						:ai_canonname
						:ai_next]))

(defn convert-to-ip [addr-struct]
	(let [addr addr-struct]
		(let [sock (ffi/cast addr sockaddr) ip ""]
		  	(let [final (inet_ntop AF_INET sock ip (:ai_addrlen addr))]
		  	 		final))))
(defn get-next [addr-struct]
	(ffi/cast (:ai_next addr-struct) addrinfo))

(defn get-last-host [addr-struct]
	(convert-to-ip  (ffi/cast addr-struct addrinfo)))

(defn get-ip [hostname]
	(let [hint (addrinfo) res (addrinfo)]
		(ffi/set! hint :ai_socktype SOCK_STREAM)
		(ffi/set! hint :ai_protocol 0)
		(ffi/set! hint :ai_flags 2)
		(ffi/set! hint :ai_family AF_INET)
		;partic
		(let [ret (getaddrinfo hostname "80" hint  res)]
		  (if (< (int ret) 0) (str ret ": "(gai_strerror ret))
		  (get-last-host res)))))


;(f/with-config  {:library "uv"
;				 :cxxflags "-LLIBDIR"
;                :includes ["uv.h"]}
;    (f/defccallback uv_getaddrinfo_cb)
;    (f/defcfn uv_getaddrinfo)    
;    (f/defcstruct uv_getaddrinfo_t [ :data
						
;						]   ))

;(defn get-ip-uv [hostname]  
;	(let [uv-addr (uv_getaddrinfo_t) res (uv_getaddrinfo_t) cb (atom nil)]  
;		(st/call-cc (fn [k]
;               (reset! cb (ffi/ffi-prep-callback
;                           uv_getaddrinfo_cb
;                          (fn [_ status ress]
;                            (try
;                              (dispose! @cb)
;                               (dispose! uv-addr)
;                               (st/run-and-process k (or (st/exception-on-uv-error status)))
;                               ;broken  always return 40.0.0.0                       
;                               (println (convert-to-ip (ffi/cast ress addrinfo)))
;                               (catch ex
;                                   (println ex))))))
;		(uv_getaddrinfo (uv/uv_default_loop) res @cb hostname "80" nil)))))

