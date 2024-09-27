require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "4.0.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0986a9e0089953cdf765538644a1cbb300b97ce84e365205e20b8292bf4096d8',
     armv7l: '0986a9e0089953cdf765538644a1cbb300b97ce84e365205e20b8292bf4096d8',
       i686: '477705a3f016d0163fe1b10ddecf52f4e8556d0ebc890edfe215de5bbddd3a0f',
     x86_64: '129394d92d6b217e01353d476c3bb1a64dd95414e6ef623ce674c83a3eada1ab'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
