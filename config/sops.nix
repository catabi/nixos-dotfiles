{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  # 1. Point to your encrypted secrets file
  sops.defaultSopsFile = ../secrets/secrets.yaml; # Adjust this path relative to the current file!
  sops.defaultSopsFormat = "yaml";

  # 2. Tell sops-nix to use your host's SSH key for decryption
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;

  sops.secrets = {
    github-nix = {};
  };
}
