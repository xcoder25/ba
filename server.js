const { spawn } = require("child_process");

const port = process.env.PORT || "8090"; // Railway provides $PORT
console.log("Starting PocketBase on port", port);

const pb = spawn("./pocketbase", ["serve", `--http=0.0.0.0:${port}`], {
  stdio: "inherit"
});

pb.on("close", (code) => {
  console.log(`PocketBase exited with code ${code}`);
});
