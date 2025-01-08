# Used by "mix format"
[
  plugins: [Phoenix.LiveView.HTMLFormatter],
  import_deps: [:phoenix, :phoenix_live_view],
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test,bench}/**/*.{ex,exs,heex}"
  ],
  line_length: 120,
  locals_without_parens: [slot: 2, slot: 3, attr: 3]
]
