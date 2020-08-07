{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with (import nixpkgs { inherit system; });

let
  version = "0.0.1";
  pname = "mysimplelist-dev";

  erlang = erlangR22;
  elixir = elixir_1_10;
  node = nodejs-13_x;
  phoenix_version = "1.5.4";
in
stdenv.mkDerivation rec {
  name = pname;

  env = buildEnv { name = "${pname}-${version}"; paths = buildInputs; };
  phases = [ "nobuild" ];

  buildInputs = with pkgs; [
    figlet

    # Basic dev requirements
    git

    # Project requirements
    elixir
    erlang
    inotify-tools
    nodejs
    postgresql
  ];

  postPatch = ''
    patchShebangs .
  '';

  preConfigure = ''
    echo "Running preConfigure..."
    echo ${version} > VERSION
    git rev-parse HEAD > GIT_COMMIT_ID

    ./boot
  '';

  shellHook = ''
    export PS1="\n\[\033[1;32m\][nix-shell:\[\033[01;34m\]\w\[\033[1;32m\]]\[\033[0m\]\[\033[36m\]`__git_ps1`\[\033[0m\]\$ "
    export LANG="en_US.UTF-8"
    export MIX_ENV=dev

    make() {
      pushd /home/phile/mysimplelist
      command make "$*"
      popd
    }

    # Project
    echo ${version} > VERSION
    export PGDATA="$PWD/db"
    # mix local.hex
    # mix archive.install hex phx_new ${phoenix_version}

    # Welcome
    figlet -w200 "${pname} v${version}"
    if [ -f ./TODO ]; then
      cat ./TODO
    fi
  '';

  # Without this, we see a whole bunch of warnings about LANG, LC_ALL and locales in general.
  # In particular, this makes many tests fail because those warnings show up in test outputs too...
  # The solution is from: https://github.com/NixOS/nix/issues/318#issuecomment-52986702
  LOCALE_ARCHIVE = if stdenv.isLinux then "${glibcLocales}/lib/locale/locale-archive" else "";

  nobuild = ''
    echo Do not run this derivation with nix-build, it can only be used with nix-shell
  '';
}
