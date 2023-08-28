(function () {
  function rmGlassdoorOverlay() {
    var $overlay = document.getElementById("HardsellOverlay");

    if (!$overlay) return;

    $overlay.remove();

    var styles = {
      position: "static",
      height: "auto",
      overflow: "visible",
    };

    Object.keys(styles).forEach(function (key) {
      document.body.style[key] = styles[key];
    });
  }

  document.addEventListener("ready", rmGlassdoorOverlay);
  setTimeout(function () {
    setInterval(rmGlassdoorOverlay, 1000);
  }, 1000);
})();
