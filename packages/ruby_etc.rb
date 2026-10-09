require 'buildsystems/ruby'

class Ruby_etc < RUBY
  description 'Provides access to information typically stored in unix /etc directory.'
  homepage 'https://github.com/ruby/etc'
  version "1.5.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '2cc90954a840fc79d41b664ed82302e7fc9072aceb16c6bc47b32576348476d6',
     armv7l: '2cc90954a840fc79d41b664ed82302e7fc9072aceb16c6bc47b32576348476d6',
       i686: '880a42a35e6e4b95ac71aa8e67080b8a7c29f404fb03f9d402b1a3a76e35470b',
     x86_64: 'c57b36f50ee730a85984150875225b0b08bc6e1d53ea17c40599c88cb79c5a25'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
