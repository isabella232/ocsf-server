import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
port_ssl = System.get_env("HTTPS_PORT") || 8443
certfile = System.get_env("HTTPS_CERT_FILE") || "priv/cert/selfsigned.pem"
keyfile = System.get_env("HTTPS_KEY_FILE") || "priv/cert/selfsigned_key.pem"

config :schema_server, SchemaWeb.Endpoint,
  force_ssl: [rewrite_on: [:x_forwarded_proto], exclude: ["localhost"]],
  http: [port: System.get_env("PORT") || 8000],
  https: [
    port: port_ssl,
    cipher_suite: :strong,
    certfile: certfile,
    keyfile: keyfile
  ],
  url: [
    host: System.get_env("HOST") || "localhost",
    port: System.get_env("URL_PORT") || 8000,
    path: System.get_env("SCHEMA_PATH") || "/"
  ]

# Configures the location of the schema files
config :schema_server, Schema.JsonReader, home: System.get_env("SCHEMA_DIR")
config :schema_server, Schema.Application, extension: System.get_env("SCHEMA_EXTENSION")

# Configure the schema example's repo path and local dicrectory
config :schema_server, Schema.Examples,
  repo: System.get_env("EXAMPLES_REPO") || "https://github.com/ocsf/examples/tree/main"

config :schema_server, Schema.Examples,
  home: System.get_env("EXAMPLES_PATH") || "../examples"
