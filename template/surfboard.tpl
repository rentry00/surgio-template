#!MANAGED-CONFIG {{ downloadUrl }} interval=43200 strict=true

[General]
# 保留 IP 段不走代理
skip-proxy = 0.0.0.0/8, 10.0.0.0/8, 100.64.0.0/10, 127.0.0.0/8, 169.254.0.0/16, 172.16.0.0/12, 192.0.0.0/24, 192.0.2.0/24, 192.168.0.0/16, 198.18.0.0/15, 198.51.100.0/24, 203.0.113.0/24, 224.0.0.0/4, 233.252.0.0/24, 240.0.0.0/4, 255.255.255.255, ::, ::1, 100::/64, 2001::/32, 2001:10::/28, 2001:20::/28, 2001:db8::/32, 2002::/16, fc00::/7, fe80::/10, ff00::/8

doh-server = https://dns.alidns.com/dns-query, https://doh.pub/dns-query, https://1.1.1.1/dns-query

# Switch, PlayStation 和 Xbox 主机的 UDP 连通性检测服务不使用 Fake IP 解析
always-real-ip = *.srv.nintendo.net, *.stun.playstation.net, xbox.*.microsoft.com, *.xboxlive.com

proxy-test-url = http://www.google.com/generate_204

[Proxy]
{{ getSurgeNodes(nodeList) }}

[Proxy Group]
Proxy = select, US, HK, TW, JP, {{ getNodeNames(nodeList) }}
HK = url-test, {{ getNodeNames(nodeList, hkFilter) }}
TW = url-test, {{ getNodeNames(nodeList, taiwanFilter) }}
JP = url-test, {{ getNodeNames(nodeList, japanFilter) }}
US = url-test, {{ getNodeNames(nodeList, usFilter) }}
Apple Music = select, DIRECT, Proxy, US, HK, TW, JP
Genshin Impact = select, DIRECT, Proxy, US, HK, TW, JP
bilibili = select, DIRECT, Proxy, HK, TW
Microsoft = select, DIRECT, Proxy, US, HK, TW, JP
PayPal = select, DIRECT, Proxy, US, HK, TW, JP
Speed Tests = select, DIRECT, Proxy
Advertisement = select, REJECT, Final
Final = select, Proxy, DIRECT

[Rule]
# 由于 QUIC 协议在中国大陆质量不佳，屏蔽之
AND,((PROTOCOL,UDP),(DEST-PORT,443)),REJECT-NO-DROP

# 屏蔽思杰马克丁及其代理软件的假官网
# 请参阅 https://www.zhihu.com/question/46746200
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/cjmarketing.txt,REJECT

DOMAIN-SET,https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/reject.txt,Advertisement
DOMAIN-SET,https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/proxy.txt,Proxy
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/apple-music.txt,Apple Music
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/bahamut.txt,TW
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/bilibili.txt,bilibili
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/microsoft.txt,Microsoft
DOMAIN-SUFFIX,paypal.com,PayPal
DOMAIN-SUFFIX,paypalobjects.com,PayPal
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/speedtests.txt,Speed Tests
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/niconico.txt,JP
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/dmm.txt,JP
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/niconico.txt,JP
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/pjsk-tw.txt,TW
DOMAIN-SET,https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/direct.txt,DIRECT
DOMAIN-SET,https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/private.txt,DIRECT

RULE-SET,LAN,DIRECT
GEOIP,CN,DIRECT

FINAL,Final,dns-failed

[Host]
localhost = 127.0.0.1
ip6-localhost = ::1
ip6-loopback = ::1

# 本地网络域名由系统 DNS 解析
*.local = server:system
*.lan = server:system
routerlogin.net = server:system

# 在大陆有节点的的全球 CDN 服务域名由大陆 DNS 解析
*.alicdn.com = server:223.5.5.5
*.aliyun.com = server:223.5.5.5
*.bilibili.com = server:119.29.29.29
*.bilivideo.com = server:119.29.29.29
doh.pub = server:119.29.29.29
*.hdslb.com = server:119.29.29.29
*.jd.com = server:119.28.28.28
*.mi.com = server:119.29.29.29
*.netease.com = server:119.29.29.29
*.qq.com = server:119.28.28.28
*.taobao.com = server:223.6.6.6
*.tencent.com = server:119.28.28.28
*.tmall.com = server:223.6.6.6
*.weixin.com = server:119.28.28.28
*.xiaomi.com = server:119.29.29.29
*.126.com = server:119.29.29.29
*.126.net = server:119.29.29.29
*.163.com = server:119.29.29.29