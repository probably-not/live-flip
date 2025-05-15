const Flip = {
  child: null,
  currentBounds: null,
  debug: false,
  duration: 300,
  easing: "ease-in-out",
  fill: "both",
  mounted() {
    this.debug = Object.hasOwn(this.el.dataset, "debug");
    this.duration = parseInt(this.el.dataset.duration || "300");
    this.easing = this.el.dataset.easing || "ease-in-out";
    this.fill = this.el.dataset.fill || "both";
    this.hasClasses = Object.hasOwn(this.el.dataset, "hasClasses");
  },
  beforeUpdate() {
    this.animatingEl = this.hasClasses ? this.el : this.el.children[0];
    this.currentBounds = this.animatingEl.getBoundingClientRect();

    if (this.debug) {
      console.log("Before Update:", {
        bounds: {
          left: this.currentBounds.left,
          top: this.currentBounds.top,
          width: this.currentBounds.width,
          height: this.currentBounds.height,
        },
      });
    }
  },
  updated() {
    const newBounds = this.animatingEl.getBoundingClientRect();

    const deltaX = this.currentBounds.left - newBounds.left;
    const deltaY = this.currentBounds.top - newBounds.top;
    const deltaW = this.currentBounds.width / newBounds.width;
    const deltaH = this.currentBounds.height / newBounds.height;

    const expectedFinalPosition = {
      left: newBounds.left,
      top: newBounds.top,
      width: newBounds.width,
      height: newBounds.height,
    };

    const animation = this.animatingEl.animate(
      [
        {
          transformOrigin: "top left",
          transform: `translate(${deltaX}px, ${deltaY}px) scale(${deltaW}, ${deltaH})`,
        },
        {
          transformOrigin: "top left",
          transform: `none`,
        },
      ],
      {
        duration: this.duration,
        easing: this.easing,
        fill: this.fill,
      }
    );

    if (this.debug) {
      animation.onfinish = () => {
        requestAnimationFrame(() => {
          const finalBounds = this.animatingEl.getBoundingClientRect();

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
              height: Math.abs(
                finalBounds.height - expectedFinalPosition.height
              ),
            },
          });
        });
      };
    }
  },
  destroyed() {},
  disconnected() {},
  reconnected() {},
};

export default Flip;
