require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.8.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7de31ce89e8cfe1fbec618f4eab9ae211984b774e533fe94bd8b63bcaa3cff71',
     armv7l: '7de31ce89e8cfe1fbec618f4eab9ae211984b774e533fe94bd8b63bcaa3cff71',
       i686: '1f31b5e6f176f6c0b45a31a5c084be60b64ae6197400bf5932a0692cd712ce11',
     x86_64: '3d2b74d2d60cb710eadc6584e9d16ecd6ad17b720868af19a0b33365eb5e2656'
  })

  depends_on 'ruby' => :logical

  conflicts_ok
  gem_compile_needed
end
