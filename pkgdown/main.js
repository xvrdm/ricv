const element = document.getElementById("image-compare");
const viewer = new ImageCompare(element, {hoverStart: true, addCircle: true}).mount();

const element2 = document.getElementById("image-compare-2");
const viewer2 = new ImageCompare(element2, {showLabels: true}).mount();
