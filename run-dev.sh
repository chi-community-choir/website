cd ./client
bun install
echo "pub fn get_api_url() -> String { \"${API_URL}\" }" > ./src/env.gleam
gleam run -m lustre/dev build --outdir=../server/priv/static
cd ../server
gleam run
