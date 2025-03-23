cd ./client
bun install
gleam run -m lustre/dev build --outdir=../server/priv/static
cd ../server
gleam run
