{
  "log": {
    "access": "",
    "error": "",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "tag": "socks",
      "port": 10808,
      "listen": "127.0.0.1",
      "protocol": "socks",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ],
        "routeOnly": false
      },
      "settings": {
        "auth": "noauth",
        "udp": true,
        "allowTransparent": false
      }
    },
    {
      "tag": "http",
      "port": 10809,
      "listen": "127.0.0.1",
      "protocol": "http",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ],
        "routeOnly": false
      },
      "settings": {
        "auth": "noauth",
        "udp": true,
        "allowTransparent": false
      }
    }
  ],
  "outbounds": [
    {
      "tag": "proxy",
      "protocol": "trojan",
      "settings": {
        "servers": [
          {
            "address": "zula.ir",
            "level": 1,
            "flow": "",
            "method": "chacha20-poly1305",
            "ota": false,
            "password": "acc242b3-3a46-4b35-b387-ee5d5ce27f37",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": false,
          "serverName": "uJdUdxMXBdqb3TX.AlvAnDneT.Top",
          "alpn": [
            "h2",
            "http/1.1"
          ],
          "fingerprint": "chrome",
          "show": false
        },
        "wsSettings": {
          "path": "/qRIo8qHLptZmI21o7qrEe",
          "headers": {
            "Host": "uJdUdxMXBdqb3TX.AlvAnDneT.Top"
          }
        },
        "sockopt": {
          "dialerProxy": "fragment",
          "tcpKeepAliveIdle": 100,
          "mark": 255,
          "tcpNoDelay": true
        }
      },
      "mux": {
        "enabled": true,
        "concurrency": 8,
        "xudpConcurrency": 8,
        "xudpProxyUDP443": "reject"
      }
    },
    {
      "tag": "fragment",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "AsIs",
        "fragment": {
          "packets": "tlshello",
          "length": "10-20",
          "interval": "10-20"
        }
      },
      "streamSettings": {
        "sockopt": {
          "tcpNoDelay": true,
          "tcpKeepAliveIdle": 100
        }
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "block",
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      }
    }
  ],
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "enabled": true
      },
      {
        "id": "5465425548310166497",
        "type": "field",
        "outboundTag": "direct",
        "domain": [
          "domain:ir",
          "geosite:cn"
        ],
        "enabled": true
      },
      {
        "id": "5425034033205580637",
        "type": "field",
        "outboundTag": "direct",
        "ip": [
          "geoip:private",
          "geoip:cn",
          "geoip:ir"
        ],
        "enabled": true
      },
      {
        "id": "5627785659655799759",
        "type": "field",
        "port": "0-65535",
        "outboundTag": "proxy",
        "enabled": true
      }
    ]
  }
}
