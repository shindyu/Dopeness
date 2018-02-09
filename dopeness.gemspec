lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dopeness/version"

Gem::Specification.new do |spec|
  spec.name          = "dopeness"
  spec.version       = Dopeness::VERSION
  spec.authors       = ["shindyu"]
  spec.email         = ["shindyu.dev@gmail.com"]

  spec.summary       = %q{parse a verse, and analayze a rhyme}
  spec.description   = %q{Analyze japanese text, rating  good rhyme.
Rating is using Ngram and Lebenstein.}
  spec.homepage      = "https://github.com/shindyu/Dopeness"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.16"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "cabocha", "~> 0.69.1"
  spec.add_dependency "romankana", "~> 0.2.1"
  spec.add_dependency "trigram", "~> 0.0.1"
  spec.add_dependency "levenshtein", "~> 0.2.2"
end
