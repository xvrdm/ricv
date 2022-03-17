import "widgets";
import ImageCompare from "image-compare-viewer";

HTMLWidgets.widget({
  name: "ricv",

  type: "output",

  factory: function (el, width, height) {
    return {
      renderValue: function (x) {
        console.log(x);

        const imgViewer = document.createElement("div");
        imgViewer.id = x.viewerId;

        const img1 = document.createElement("img");
        img1.src = x.img1;
        imgViewer.appendChild(img1);

        const img2 = document.createElement("img");
        img2.src = x.img2;
        imgViewer.appendChild(img2);

        const element = document.getElementById(x.widgetId);
        element.appendChild(imgViewer);

        const viewer = new ImageCompare(imgViewer).mount();
      },

      resize: function (width, height) {},
    };
  },
});
