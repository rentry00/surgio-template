xkww3n 编写的 [Surgio](https://surgio.js.org/) 代理软件配置文件生成模板，可部署至 [Netlify](https://www.netlify.com/) 建立自己的自定义配置文件托管服务。目前暂时仅支持 [Surfboard](https://getsurfboard.com/).  
*由于 Surfboard 配置文件兼容 Surge 3/4 配置文件语法，因此 Surge 用户应当也能使用本模板构建的配置文件。但本模板并没有利用 Surge 的很多专有特性，故建议 Surge 用户另寻他人编写的配置模板。*

# 为什么不支持 Clash
截至 v2.20.1，Surgio 存在一个缩进问题（[我创建的 GitHub Issue](https://github.com/surgioproject/surgio/issues/202)），这导致我无法很好地安排代理选择器。如果未来 Surgio 修复了这个问题，我将添加 Clash 配置文件的生成模板。

# 特性
## 更好的性能
本模板内的域名规则全部使用 DOMAIN-SET 格式，与大多数规则使用的 RULE-SET 格式相比，这将带来更加优秀的域名匹配速度。

## 专有服务分流
美国，日本，香港，台湾地区的节点单独成组，这些地区的专有服务流量将被转发至对应地区组内选择的代理服务器，而非总代理组选择的代理服务器。  
例如，如果用户使用的大部分服务都需要使用土耳其 IP，该用户会将总代理组设置为土耳其服务器。但即使这样，当用户需要浏览 [DMM Fanza (NSFW)](https://dmm.co.jp) 时，到该服务的流量仍将被转发至日本代理组中的服务器。  
当前支持的服务（英文首字母排序）：
| 服务                                            | 转发地点 |
|-------------------------------------------------|----------|
| 巴哈姆特动画疯                                  | 台湾     |
| 碧蓝航线（英文版）                              | 美国     |
| BanG Dream! 少女乐团派对（日文版）              | 日本     |
| DMM（全年龄/R18 Fanza)                          | 日本     |
| Niconico 动画                                   | 日本     |
| 世界计划 缤纷舞台！ feat.初音未来（繁体中文版） | 台湾     |
| Love Live! 学园偶像祭（英文版）                 | 美国     |

## 全球服务分流
一些服务可能在不同的国家提供不同的内容。本模板同样支持单独转发这些服务的流量至指定地区。  
当前支持的服务（英文首字母排序）：
- Apple Music
- 原神（国际版）
- 哔哩哔哩动画（仅可选择香港和台湾组）
- Microsoft
- PayPal
- YouTube

## 测速服务分流
本模板内置的规则对测速网站及测速服务器进行了单独分流，用户可通过将 "Speed Tests" 组设置为 "Proxy" 测试代理服务器的速度，也可以选择设置为 "DIRECT" 测试本机运营商的速度。  
默认情况下，该组被设置为 "DIRECT" 以防止意外的流量消耗或被代理服务提供商封禁。  
**注意：不支持的测速服务将与正常域名（总代理组）一道处理！因此请依然注意不要随便测速**  
由于测速服务器数量较大，加载该规则可能造成额外的内存开销。本模板在生成配置时，会同时生成一份不含测速服务分流规则的配置文件。如果不需要此功能，在代理软件内订阅时选用带有 `NoSpeedRules` 后缀的规则即可。  
支持的测速服务（英文首字母排序）：
- Cloudflare Internet Speed Test
- Speedtest by Ookla
- Fast.com

## EDNS Client Subnet 优化
对于在大陆有节点的全球 CDN 服务域名，本模板指定使用大陆 DNS 进行解析，以使用户连接到距离最近的 CDN 节点。  
支持的 CDN 服务（英文首字母排序）：
- 阿里云
- 哔哩哔哩动画
- 京东
- 小米
- 网易
- 腾讯
- 淘宝
- 天猫

## 可选的广告拦截，以及针对某些网站的屏蔽
本模板支持广告拦截功能，将 "Advertisement" 组设置为 "REJECT" 即可启用。如果您不喜欢，可以将其设置为 "Final" 让广告域名与正常域名一同处理。  
此外，本模板内置的规则屏蔽了苏州思杰马克丁公司及其旗下的所有网站。您无法通过更改代理组禁用此功能。  
欲了解什么是苏州思杰马克丁公司，以及为什么我要这么做，请参阅 <https://www.zhihu.com/question/46746200>.

# 使用
## 本地使用
1. 安装 [Node.js](https://nodejs.org/zh-cn/download/)   
请注意，目前 Surgio 仅支持 Node.js 12 或更新的版本
2. 克隆本仓库并安装依赖
```bash
git clone https://github.com/xkww3n/surgio-template.git
cd surgio-template
npm install
```
如果在最后一步遇到网络连接问题，也可以运行以下命令从淘宝 npm 镜像中下载并安装依赖
```bash
npm --registry https://registry.npmmirror.com/ install
```
3. 设置订阅链接  
根据你的代理服务提供商，修改本地仓库中 *provider/subscribe.js* 文件内的 `url` 和 `type` 字段。  
您可以在 <https://surgio.js.org/guide/custom-provider.html> 中查看支持的订阅链接类型。
4. 打开终端，导航至本地仓库的根目录中，运行 `npx surgio generate` 命令。  
如果在上一步配置无误，得到 `[surgio] info: 规则生成成功` 的提示后，即可前往 *dist* 文件夹中提取生成好的配置文件。

## 搭建自己的规则托管服务（以 Netlify 为例）
[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/xkww3n/surgio-template)  
1. 点击上面的按钮，将本模板克隆至 Netlify. 本次“部署”将会失败，这是正常现象。  
**注意：Netlify 默认将本模板克隆至用户的公开仓库内。克隆完毕后，务必先将该仓库转换为私有，以防数据泄露。**
2. 设置鉴权密码  
修改 *surgio.conf.js* 文件内的 `gateway.accessToken` 和 `gateway.viewerToken` 字段，为面板及接口设置密码
3. 设置订阅链接  
根据你的代理服务提供商，修改仓库中 *provider/subscribe.js* 文件内的 `url` 和 `type` 字段。  
您可以在 <https://surgio.js.org/guide/custom-provider.html> 中查看支持的订阅链接类型。
4. 找到 Netlify 随机生成的域名，将 *surgio.conf.js* 文件内的 `urlBase` 字段修改为这个域名。
5. 等待 Netlify 部署完毕，即可访问该域名，使用 `gateway.accessToken` 字段设置的密码登陆面板。在面板内复制订阅链接后，在链接末尾加上 `?access_token=你的viewerToken` （如果未设置，则使用accessToken） 即可填写至代理客户端的订阅链接内。

# 鸣谢
- [Surgio](https://surgio.js.org/)
- [Surfboard](https://getsurfboard.com/)
- [Netlify](https://www.netlify.com/)
- [Loyalsoldier / surge-rules](https://github.com/Loyalsoldier/surge-rules)
- [DivineEngine / Profiles](https://github.com/DivineEngine/Profiles/)
- [dler-io / Rules](https://github.com/dler-io/Rules)