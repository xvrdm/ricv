HTMLWidgets.widget({

  name: 'ricv',

  type: 'output',

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {
        const img1 = document.createElement("img");
        img1.src = x.img1;
        el.appendChild(img1);

        const img2 = document.createElement("img");
        img2.src = x.img2;
        el.appendChild(img2);

        const viewer = new ImageCompare(el, x.options).mount();
      },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }

    };
  }
});
