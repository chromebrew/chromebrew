require 'buildsystems/ruby'

class Ruby_byebug < RUBY
  description 'Byebug is a Ruby debugger.'
  homepage 'https://github.com/deivid-rodriguez/byebug'
  version "12.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a66196f0efe8c3d71684307b069a33483e56ec1d2217e4f33101fdbfef1f1f87',
     armv7l: 'a66196f0efe8c3d71684307b069a33483e56ec1d2217e4f33101fdbfef1f1f87',
       i686: '59217683304ae983a704955c2082222b5eeefc369b62804fc06cbc01d567cd39',
     x86_64: 'c668fb6e1798a9ac0091fcaae08d47d09af02762204f839754619c385621b559'
  })

  conflicts_ok
  gem_compile_needed
end
