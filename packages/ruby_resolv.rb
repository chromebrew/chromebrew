require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.7.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd9cc9762096855a7277510cdaafac99673385a814188789014a740fb56b9d46c',
     armv7l: 'd9cc9762096855a7277510cdaafac99673385a814188789014a740fb56b9d46c',
       i686: 'c6d61d2c45b8129f539d86f57967ebdeacbfa91815047c1e7ffe590694954a15',
     x86_64: '03e37fd0ab49cb211e9c21a76c5e66a30a0d3b3802e925a052843b7baa459e86'
  })

  conflicts_ok
  gem_compile_needed
end
