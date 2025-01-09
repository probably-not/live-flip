# LiveFlip

[![Hex.pm Version](https://img.shields.io/hexpm/v/live_flip.svg)](https://hex.pm/packages/live_flip) [![Documentation](https://img.shields.io/badge/docs-latest-blue.svg)](https://hexdocs.pm/live_flip/)

A component and hook for FLIP animations of elements within LiveView.

## How To Use

A demo project is provided here in the demo folder, it is a simple demo app to display the capability that the component provides. You can visit [live-flip.fly.dev](https://live-flip.fly.dev) to see it in action. The animations are fully automated by the wrapper, and the class changes are fully driven by the server.

The easiest way to start is to install (see the below Installation section), and add the Flip hook to your hooks in your app's `app.js` file. Once you have that, you can wrap any element in the `flip_wrap` component and receive all the animations for free!

In your app.js, or wherever you define your hooks, simply import the following:

```javascript
import Flip from "../../deps/live_flip/assets/js/hooks"
```

Or, if you are in an umbrella project:

```javascript
import Flip from "../../../../deps/live_flip/assets/js/hooks"
```

And then add the hook to your Hooks object:

```javascript
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: { Flip },
})
```

And now you're ready to roll! Just wrap your element with the  component from `LiveFlip` and you will get automatic FLIP animations!

Simply render your inner content within the `LiveFlip.flip_wrap` component and move it around the page by adjusting
its classes. The element will automatically animate its movement:

```heex
<.flip_wrap id="my-red-square">
  <div class="absolute w-16 h-16 bg-red-500 rounded-lg shadow-lg">
  </div>
</.flip_wrap>
```

### Caveats

As of now (version 0.1.0), animations and FLIPs are implemented for the following:
- Position changes
- Width changes
- Height changes

However, since the hook utilizes the Web Animations API and transforms, it is unable to handle if the element has transforms applied on it (yet). This is something that I want to tackle in following releases, as I get a better handle of how to compose transforms that are already on an element, with incoming transforms during an update and the transforms necessary for the FLIP to work.

In addition to this caveat - the UI is non-blocking right now - this means that animations may be running as your element changes classes. I'm not currently using LiveView's `this.js` ViewHook functionality to trigger transitions - mainly because I want to target the Web Animations API and keep this hook very generic (i.e. not targeting Tailwind and not class-based). My understanding of the `this.js.transition` function is that it works by adding classes and transitioning these classes off, meaning that I would need to dynamically calculate the TailwindCSS classes necessary for the FLIP thus tying this very much to Tailwind exclusively. Unfortunately, this also means I can't cause the UI to lock or be blocked - there have been many discussions about this in the past, both on the forum and on the Slack. I'm hoping that this (as a nice use case for it) will open up the discussion again.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `live_flip` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_flip, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/live_flip>.

## Contributing

Feel free to fork and make PRs! I'm definitely happy to have eyes on this and to get feedback so we can take care of edge cases.
