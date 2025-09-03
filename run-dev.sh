set -euo pipefail
cd ./client
bun install
echo "pub fn get_api_url() -> String { \"${API_URL}\" }" > ./src/client/env.gleam
gleam run -m lustre/dev build --outdir=../server/priv/static
cd ../server
gleam run
