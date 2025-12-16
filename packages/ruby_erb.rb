require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1d42a31a9cc55fe42dff40fd1b375d16c00789d7b38fb9b7f1b0115ae06a71c0',
     armv7l: '1d42a31a9cc55fe42dff40fd1b375d16c00789d7b38fb9b7f1b0115ae06a71c0',
       i686: 'c79194279ba178dc08e1297a7afb7af0bc1aaf8e23a76e2e488807b42f34deb9',
     x86_64: '29570c860fa4df29a1eaad01d3284f6e0195873f086479ffa657c0ca6c1b8520'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
