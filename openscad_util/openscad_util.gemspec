
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "openscad_util"
  spec.version       = '0.1.0'
  spec.authors       = ["Joe Francis"]
  spec.email         = ["joe@lostapathy.com"]

  spec.summary       = %q{A collection of OpenSCAD utility code}
  spec.homepage      = "https://github.com/lostapathy/openscad-libs/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
end
