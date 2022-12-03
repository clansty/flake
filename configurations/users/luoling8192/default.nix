{ config, pkgs, lib, isLinux, ... }:

{
  home-manager.users.luoling8192.home.stateVersion = "22.11";

  users.users.luoling8192 = {
    shell = pkgs.zsh;
    description = "RainbowBird";
  } // lib.attrsets.optionalAttrs isLinux {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "libvirt"
      "input"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6i7l6OnCbgSMLO0hROJdBA5mjqZ8RAK2ObMnmlE5dUk3S6PEkqTiqAXfBnpfWc0fHFmjM1XFTwshEQU8xGmwH50CfChPfxE9vHVKYW6iEfB8S4hY4+nVmLGuVlyByy5cVhiVUXkhtFN4Mz1eTV/wu9O4rR05yZVfW9/FkGVE2UnbDJsZLLVbmLPzdZF7rqo3sjewmwNZx+vUOFes1LdZbB7dJhuJsvx7GPFzIeEnJZFhHdFqMc/aXeMMnpXqSofCL13yXsZ0XX22K0+hlmCyFJZ7olfW1D11DIJj9lUhsB3zc3O2/CgKV7qxb42rOmheSXoQlQhxg03oWPOflIol6NvqgtkhPksHvEIfiHcZYN4H3XVSyQUZLPQ2ijX+8N21xfxFdWvD06PSc2RcwgUEItsYWLIkjQ+xF0VZc3dK73ly0fNc0sdqcRx14RSHVRwWE31FNEEmi4HigfeMaZ+2JZXZLJH9H8a/dkAUw//X2d/BCrnMqiDoBOW23gLTiELk="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCQqzS3yRvZY6CEEyABcO5Ob4VcdPNDK/+r59Mr/eMVP3qop53+jpCPnqs8TqrVYZ2BfwmRTyxPhBJZyckvMCH2kzwxBRZE3SXS5BJZVui7DKL2pkBNkFfl8DdEmuR60VOIENFMyPMNXcURp5/szCB+jAMj/SolG4lWckl5UGlUoO93aG/BLxyb57HmAkFMg1L0xFTg7EhwSpuMvRXy3/8W4SNS67QX/vwPuzhw0ikULPuyR3G+92vp3vXj0nYYWU6hJUE2/jORu5e+q/QZF7OGaCQY9m9I2hCyhZZLMbmfvKnNAlammyFVAXfyWSWkAQD8BkJN5fAK1tchk3JwBqudLKzzb5WcWOeR6tkVHREuNdtWbFYjOSAnoj2dyGGjafYDwwGpicglwHp6LHuimVqUDxf7LQRErwg5j5BxCTjDnkk2Y8lTi3BFKg8SFILi5CoLPAyjYasVxuun5j6/ux8ryYo0keLa85VRDyuD7qIAzdHBGiiorqQVzlD9btvKBT8="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCbKIVuNs+Z4d1f4AnOsbADoTscOD1+3l28MRcyFkzsq3olJsLsj+9loUsGD0NoYM+ptEvPxnYgWDlHb3o/V3yewAmlQloktQmpK0Kw6Wncz2CCQLZO/qaoJXuLxAA5r3JAfIuVbb8Ye79WjJ/l3p7CovWHKUiJQaZ/hVQz3SlXTGvZXvYnmRZOhR4u2txPnZ+ZyiG17lIS5U2gStWaMHMojeX5UCyE28tREWBZFinbHFNeuzcjGVO/ajG+5UrjlqMlIW2VnHqIWIxJNO1jlu6vDiBxFbrvY/OwU2qS5+bmy3BsnOTySySIJBnTyyoi0RYPLWQSH65W5dWfj/gOr8uNJS9ytSZVl4goukeZcc+tYTR7dWUfJre3PmCOis0csSrAKIw+UUYdfU3qA99BwK4kTonxi0sjdUA5tRz/TFasV3rAZ/74DPSs4DVsIFkQzvXfGl9xH96hx7J5pr7+WKNyml1opoDbHdTWk4YuORWZ1TyZG2dMBY4h+g6WQLv1SaM="
    ];
  };
}
