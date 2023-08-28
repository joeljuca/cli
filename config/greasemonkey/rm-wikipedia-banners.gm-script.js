/*
---
enabled: true
name: rm-wikipedia-banners
userIncludes: ["https://wikipedia.org/*", "https://*.wikipedia.org/*"]
---
*/

document.addEventListener("ready", function () {
  function rmWikipediaBanners() {
    const bannerIds = ["frb-inline", "frb-main"];

    bannerIds.forEach(function (id) {
      var $el = document.getElementById(id);
      $el && $el.remove();
    });
  }

  setTimeout(rmWikipediaBanners, 3000);
});
