import { execSync } from "node:child_process"
import path from "node:path"
import { fileURLToPath } from "node:url"

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const root = path.join(__dirname, "..")

const fontAwesomePath = path.join(
  execSync("bundle show font-awesome-rails", { cwd: root, encoding: "utf8" }).trim(),
  "app/assets/stylesheets"
)

const input = path.join(root, "app/assets/stylesheets/application.bootstrap.scss")
const output = path.join(root, "app/assets/builds/application.css")

const command = [
  "sass",
  `${input}:${output}`,
  "--no-source-map",
  `--load-path=${path.join(root, "node_modules")}`,
  `--load-path=${fontAwesomePath}`,
].join(" ")

execSync(command, { cwd: root, stdio: "inherit", shell: true })
