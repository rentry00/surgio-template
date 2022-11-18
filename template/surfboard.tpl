#!MANAGED-CONFIG {{ downloadUrl }} interval=43200 strict=true

[General]
doh-server = https://dns.alidns.com/dns-query, https://doh.pub/dns-query, https://dns.google/dns-query, https://1.1.1.1/dns-query

# Surfboard 需要此行防止回环
skip-proxy = 127.0.0.1

# Switch, PlayStation 和 Xbox 主机的 UDP 连通性检测服务不使用 Fake IP 解析
always-real-ip = *.srv.nintendo.net, *.stun.playstation.net, xbox.*.microsoft.com, *.xboxlive.com

proxy-test-url = http://www.google.com/generate_204

[Proxy]
{{ getSurfboardNodes(nodeList) }}

[Proxy Group]
Proxy = select, US, HK, TW, JP, {{ getNodeNames(nodeList) }}
HK = select, {{ getNodeNames(nodeList, hkFilter) }}
TW = select, {{ getNodeNames(nodeList, taiwanFilter) }}
JP = select, {{ getNodeNames(nodeList, japanFilter) }}
US = select, {{ getNodeNames(nodeList, usFilter) }}
Apple Music = select, DIRECT, Proxy, US, HK, TW, JP
Genshin Impact = select, DIRECT, Proxy, US, HK, TW, JP
bilibili = select, DIRECT, Proxy, HK, TW
Microsoft = select, DIRECT, Proxy, US, HK, TW, JP
PayPal = select, DIRECT, Proxy, US, HK, TW, JP
YouTube = select, Proxy, DIRECT, US, HK, TW, JP
Speed Tests = select, DIRECT, Proxy
Advertisement = select, REJECT, Final
Privacy = select, REJECT, Final
Final = select, Proxy, DIRECT

[Rule]
# 屏蔽思杰马克丁及其代理软件的假官网
# 请参阅 https://www.zhihu.com/question/46746200
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/cjmarketing.txt,REJECT

DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/advertisement.txt,Advertisement
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/privacy.txt,Privacy

DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/apple-music.txt,Apple Music
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/bahamut.txt,TW
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/azurlane-en.txt,US
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/bilibili.txt,bilibili
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/microsoft.txt,Microsoft
DOMAIN-SUFFIX,paypal.com,PayPal
DOMAIN-SUFFIX,paypalobjects.com,PayPal
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/youtube.txt,YouTube
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/speedtests.txt,Speed Tests
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/niconico.txt,JP
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/dmm.txt,JP
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/niconico.txt,JP
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/pjsk-tw.txt,TW
DOMAIN-SET,https://raw.githubusercontent.com/xkww3n/domain-sets/main/lovelivesif-en.txt,US

GEOIP,CN,DIRECT

FINAL,Final

[Host]
# 本地网络域名由系统 DNS 解析
*.example = server:system
*.hiwifi.com = server:system
*.home.arpa = server:system
*.invalid = server:system
*.lan = server:system
*.leike.cc = server:system
*.local = server:system
*.localdomain = server:system
*.localhost = server:system
*.miwifi.com = server:system
*.my.router = server:system
*.peiluyou.com = server:system
*.phicomm.me = server:system
*.router.ctc = server:system
*.routerlogin.com = server:system
*.tendawifi.com = server:system
*.test = server:system
*.tplinkwifi.net = server:system
*.zte.home = server:system
instant.arubanetworks.com = server:system
router.asus.com = server:system
setmeup.arubanetworks.com = server:system

# 对内容交付延迟敏感的大陆 CDN 服务域名由系统 DNS 解析
*.bilibili.com = server:system
*.bilivideo.com = server:system
*.hdslb.com = server:system
*.qq.com = server:system

# 在大陆有节点的的全球 CDN 服务域名由大陆 DNS 解析
*.alicdn.com = server:223.5.5.5
*.aliyun.com = server:223.5.5.5
*.jd.com = server:119.28.28.28
*.mi.com = server:119.29.29.29
*.netease.com = server:119.29.29.29
*.taobao.com = server:223.6.6.6
*.tencent.com = server:119.28.28.28
*.tmall.com = server:223.6.6.6
*.weixin.com = server:119.28.28.28
*.xiaomi.com = server:119.29.29.29
*.126.com = server:119.29.29.29
*.126.net = server:119.29.29.29
*.163.com = server:119.29.29.29
