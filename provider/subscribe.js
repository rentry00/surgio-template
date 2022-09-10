'use strict';

module.exports = {
  // 将 http://example.com/sub 替换成你的代理订阅地址
  url: 'http://example.com/sub',
  /* 将 clash 替换成你设置的订阅地址的类型。
  通常为 clash, trojan, shadowsocks_subscribe, v2rayn_subscribe
  访问 https://surgio.js.org/guide/custom-provider.html 查看所有支持的类型 */
  type: 'clash',
  /* 定义所有的节点都支持 UDP 转发。
  如果你的代理服务提供商不允许转发 UDP 流量，需改为 false */
  udpRelay: true,
  // 节点名字前添加国旗 emoji，不需要可改成 false
  addFlag: true,
};
