const Flip = {
  child: null,
  currentBounds: null,
  mounted() {
    this.child = this.el.children[0];
  },
  beforeUpdate() {
    this.currentBounds = this.child.getBoundingClientRect();
  },
  updated() {
    const newBounds = this.child.getBoundingClientRect();

    const deltaX = this.currentBounds.left - newBounds.left;
    const deltaY = this.currentBounds.top - newBounds.top;
    const deltaW = this.currentBounds.width / newBounds.width;
    const deltaH = this.currentBounds.height / newBounds.height;

    this.el.animate(
      [
        {
          transformOrigin: "top left",
          transform: `
        translate(${deltaX}px, ${deltaY}px)
        scale(${deltaW}, ${deltaH})
      `,
        },
        {
          transformOrigin: "top left",
          transform: "none",
        },
      ],
      {
        duration: 10000,
        easing: "ease-in-out",
        fill: "both",
      }
    );
  },
  destroyed() {},
  disconnected() {},
  reconnected() {},
};

export default Flip;
