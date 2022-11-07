'use strict';

module.exports = {
  artifacts: [
    {
      name: 'Surfboard.conf',
      template: 'surfboard',
      provider: 'subscribe',
    },
  ],
  // 将 https://example.com/ 替换成你的 Netlify 域名。
  urlBase: 'https://example.com/',
  /*面板与API鉴权设置
  可将 auth 改为 false 禁用鉴权。如果禁用，任何知道你面板域名的人都能访问你的面板，下载你的订阅 */
  gateway: {
    auth: true,
    accessToken: 'YOUR_PASSWORD', //面板访问与订阅下载的密码，必须设置
    viewerToken: 'ANOTHER_PASSWORD', // 只读密码，可下载订阅但无法解锁面板，可不设置。不设置时删掉本行。
  },
  /* 将非常有限的信息上报给 Surgio 作者，用于排查问题。
  如果不愿意，可改成 false */
  analytics: true,
};