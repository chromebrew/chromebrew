require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '11a51ba27f1875593017d33560badad95ea894848d25d426ade209b619ad4a2f',
     armv7l: '11a51ba27f1875593017d33560badad95ea894848d25d426ade209b619ad4a2f',
       i686: '88e1d897d3e5611b09276158644a14fe85b36961aeadea65c51e5c0331f5c75e',
     x86_64: '6aa32335992948369b986fdb700089a37beda2e441b0371712cf1b5245716d14'
  })

  conflicts_ok
  gem_compile_needed
end
