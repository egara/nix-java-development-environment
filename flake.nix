{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }: 

  	let
    	# system should match the system you are running on
    	system = "x86_64-linux";
  	in 

  {

    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;

        # Allow unfree packages
        config.allowUnfree = true;
      };
    in pkgs.mkShell {
      # Java development environment
      packages = with pkgs; [
        jdk8
        eclipses.eclipse-jee
        maven
        soapui
        postman
        apache-directory-studio
      ];

      shellHook = ''
        echo "Entering Java development environment"
        echo "Some of the tools installed are: JDK 8, maven, Eclipse JEE (eclipse), SOAPUI (soapui), Postman (postman) and Apache Directory Studio (ApacheDirectoryStudio)"
        echo "If you want to exit this environment, type exit"
      '';
    };
  };
}