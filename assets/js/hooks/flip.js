const Flip = {
  child: null,
  currentBounds: null,
  scaleX: null,
  scaleY: null,
  mounted() {
    this.child = this.el.children[0];
  },
  beforeUpdate() {
    this.child = this.el.children[0];
    this.currentBounds = this.child.getBoundingClientRect();
    this.scaleX = this.currentBounds.width / this.child.offsetWidth;
    this.scaleY = this.currentBounds.height / this.child.offsetHeight;

    console.log("Before Update:", {
      bounds: {
        left: this.currentBounds.left,
        top: this.currentBounds.top,
        width: this.currentBounds.width,
        height: this.currentBounds.height,
        scaleX: this.scaleX,
        scaleY: this.scaleY,
      },
    });
  },
  updated() {
    const newBounds = this.child.getBoundingClientRect();
    const newScaleX = newBounds.width / this.child.offsetWidth;
    const newScaleY = newBounds.height / this.child.offsetHeight;

    const parentRect = this.child.offsetParent.getBoundingClientRect();
    const deltaX =
      this.currentBounds.left -
      parentRect.left -
      (newBounds.left - parentRect.left);
    const deltaY =
      this.currentBounds.top -
      parentRect.top -
      (newBounds.top - parentRect.top);

    const expectedFinalPosition = {
      left: newBounds.left,
      top: newBounds.top,
      width: newBounds.width,
      height: newBounds.height,
    };

    const animation = this.child.animate(
      [
        {
          transformOrigin: "center",
          transform: `translate(${deltaX}px, ${deltaY}px) scale(${this.scaleX}, ${this.scaleY})`,
        },
        {
          transformOrigin: "center",
          transform: `scale(${newScaleX}, ${newScaleY})`,
        },
      ],
      {
        duration: 10000,
        easing: "ease-in-out",
        fill: "both",
      }
    );

    animation.onfinish = () => {
      requestAnimationFrame(() => {
        const finalBounds = this.child.getBoundingClientRect();

        console.log("Animation finished:", {
          expected: expectedFinalPosition,
          actual: {
            left: finalBounds.left,
            top: finalBounds.top,
            width: finalBounds.width,
            height: finalBounds.height,
          },
          difference: {
            x: Math.abs(finalBounds.left - expectedFinalPosition.left),
            y: Math.abs(finalBounds.top - expectedFinalPosition.top),
            width: Math.abs(finalBounds.width - expectedFinalPosition.width),
            height: Math.abs(finalBounds.height - expectedFinalPosition.height),
          },
        });
      });
    };
  },
  destroyed() {},
  disconnected() {},
  reconnected() {},
};

export default Flip;
