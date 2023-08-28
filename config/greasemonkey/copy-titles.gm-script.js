/*
---
enabled: true
name: copy-titles
---
*/

document.addEventListener("keydown", function ({ ctrlKey, key, shiftKey }) {
  if (ctrlKey && shiftKey && key.toLowerCase() == "t") {
    var $title = (document.getElementsByTagName("title") || [])[0] || {};

    $title.innerText && navigator.clipboard.writeText($title.innerText);
  }
});
