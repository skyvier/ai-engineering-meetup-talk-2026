{
  description = "Slidev deck: Ohjelmistokehitys autonomisten agenttien aikakaudella";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [ pkgs.nodejs_22 ];

          # Installs npm dependencies on entry, and again whenever package.json
          # or package-lock.json changes. Uses `npm ci` once a lockfile exists.
          shellHook = ''
            export PATH="$PWD/node_modules/.bin:$PATH"

            stamp=node_modules/.flake-install-stamp
            inputs_hash=$(cat package.json package-lock.json 2>/dev/null | sha256sum | cut -d' ' -f1)

            if [ ! -f "$stamp" ] || [ "$(cat "$stamp")" != "$inputs_hash" ]; then
              echo "Installing npm dependencies..."
              if [ -f package-lock.json ]; then
                npm ci
              else
                npm install
              fi && {
                # Hash again: npm install may have just created package-lock.json.
                cat package.json package-lock.json 2>/dev/null | sha256sum | cut -d' ' -f1 > "$stamp"
              }
            fi

            echo "Slidev dev shell ready: npm run dev | npm run build | npm run export"
            echo "PDF export needs Chromium once: npx playwright install chromium"
          '';
        };
      });
    };
}
