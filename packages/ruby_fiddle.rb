require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.3-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'da0b2559031ce9fc054adf8d3347971d471e35dae819181083fa2ae2fd36ac97',
     armv7l: 'da0b2559031ce9fc054adf8d3347971d471e35dae819181083fa2ae2fd36ac97',
       i686: 'e76c5c8a562a3c6bf517a86d64c078a4659abc717e2854b463589d0f0e50edd8',
     x86_64: 'ed1063589cd440b30f664288fb4ac266448d42e5441c49a7917f174e1f045e72'
  })

  conflicts_ok
  gem_compile_needed
end
