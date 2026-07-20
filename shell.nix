# Note: the contents of this file have been adapted from: 
# https://gist.github.com/adisbladis/187204cb772800489ee3dac4acdd9947


let pkgs = import <nixpkgs> {};
# Provides a script that copies required files to ~/
podmanSetupScript = let
registriesConf = pkgs.writeText "registries.conf" ''
    [registries.search]
    registries = ['docker.io']
    [registries.block]
    registries = []
'';
in pkgs.writeScript "podman-setup" ''
    #!${pkgs.runtimeShell}
    # Dont overwrite customised configuration
    if ! test -f ~/.config/containers/policy.json; then
        install -Dm555 ${pkgs.skopeo.src}/default-policy.json ~/.config/containers/policy.json
    fi
    if ! test -f ~/.config/containers/registries.conf; then
        install -Dm555 ${registriesConf} ~/.config/containers/registries.conf
    fi
'';

in pkgs.mkShell {
    buildInputs = [
        pkgs.podman  # Docker compat
        pkgs.runc  # Container runtime
        pkgs.conmon  # Container runtime monitor
        pkgs.skopeo  # Interact with container registry
        pkgs.slirp4netns  # User-mode networking for unprivileged namespaces
        pkgs.fuse-overlayfs  # CoW for images, much faster than default vfs
    ];

    shellHook = ''
        # Install required configuration
        ${podmanSetupScript}
    '';

    # python and its packages
    packages = [
        pkgs.openssl
        (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
            pefile
            jinja2
        ]))
    ];
}