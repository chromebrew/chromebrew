require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.19.9-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '968dde2719905d967ab4e5b09db9c86cef477f43949e7e1baa7ff4e57ee7b371',
     armv7l: '968dde2719905d967ab4e5b09db9c86cef477f43949e7e1baa7ff4e57ee7b371',
       i686: '16c75073ee8a772c79be1bd24fbb57fe8a1dd11ebf4bcc14006c90b1d91bc1b6',
     x86_64: '2d911c38fed6dcc48ae50f9909b0e5c42f5b8b77a3444b5f310b7a7e77fd388d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
