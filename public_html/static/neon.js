var h1 = document.getElementsByTagName("h1")[0],
text = h1.innerText || h1.textContent,
split = [],
i,
lit = 0,
timer = null;
for (i = 0; i < text.length; ++i) {
	split.push("<span>" + text[i] + "</span>");
}

h1.innerHTML = split.join("");
split = h1.childNodes;

var flicker = function () {
	lit += Math.random() * (0.05);
	if (lit >= 1) {
		clearInterval(timer);
	}

	for (i = 0; i < split.length; ++i) {
		if (Math.random() < lit) {
			split[i].className = "neon";

		} else {
			split[i].className = "";
		}
	}
}

setInterval(flicker, 110);