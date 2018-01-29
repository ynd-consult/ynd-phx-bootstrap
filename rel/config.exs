use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"gqKAF86T7mW5u6/j2fskgis2ylCz3RaMlmTrzNlFMONhlpKIGe9MnJp86Bx+5tne"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"iXdbeOT43ns241kSXL+ThxDZ7mbL3wdM5Z49E9yqoiLgu8qsOqpyoZ9h19zLkwJ4"

  set post_start_hook: "rel/hooks/post_start"
end

release :ynd_phx_bootstrap do
  set version: "0.0.1"
  set applications: [
    :logger,
    :runtime_tools,
    :sentry
  ]
end

