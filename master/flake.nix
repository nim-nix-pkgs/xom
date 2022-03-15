{
  description = ''Transform XML trees into performant JavaScript DOM calls at compile-time.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-xom-master.flake = false;
  inputs.src-xom-master.owner = "schneiderfelipe";
  inputs.src-xom-master.ref   = "refs/heads/master";
  inputs.src-xom-master.repo  = "xom";
  inputs.src-xom-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-xom-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-xom-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}