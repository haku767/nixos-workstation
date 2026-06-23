# hardware-configuration.nix
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Core kernel modules for storage and input devices
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Automatically manage network interfaces via DHCP
  networking.useDHCP = lib.mkDefault true;

  # Architecture platform target
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  # Set CPU governor to performance for maximum desktop responsiveness
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
