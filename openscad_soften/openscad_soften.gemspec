
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "openscad/soften/version"

Gem::Specification.new do |spec|
  spec.name          = "openscad_soften"
  spec.version       = Openscad::Soften::VERSION
  spec.authors       = ["Joe Francis"]
  spec.email         = ["joe@lostapathy.com"]

  spec.summary       = %q{OpenSCAD modules for generating softer shapes}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_dependency "openscad_util"
end
