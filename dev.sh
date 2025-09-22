mkdir -p .devcontainer
git mv dockercompose.yml .devcontainer/docker-compose.yml

cat > .devcontainer/devcontainer.json <<'JSON'
{
  "name": "Sympa dev",
  "dockerComposeFile": "docker-compose.yml",
  "service": "sympa",               // change to your main service name
  "workspaceFolder": "/workspaces/${localWorkspaceFolderBasename}",
  "forwardPorts": [8080, 8081, 8025]
}
JSON

git add .devcontainer
git commit -m "devcontainer: wire compose for Codespaces"
git push
