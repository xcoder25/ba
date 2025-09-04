const { spawn } = require("child_process");

const pb = spawn("./pocketbase", ["serve", "--http=0.0.0.0:8090"], {
  stdio: "inherit"
});

pb.on("close", (code) => {
  console.log(`PocketBase exited with code ${code}`);
});
