require 'buildsystems/ruby'

class Ruby_io_nonblock < RUBY
  description 'Enables non-blocking mode with io class.'
  homepage 'https://github.com/ruby/io-nonblock'
  version "0.3.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'df1eb9465a982b4f393cc1b79f31fe5d9365eb842cdcef3f58db71d81bae4407',
     armv7l: 'df1eb9465a982b4f393cc1b79f31fe5d9365eb842cdcef3f58db71d81bae4407',
       i686: '3e4782daea8c9eed8423e607f243cb156d07a827318b46fe4c3a45088ebc0afe',
     x86_64: '7b484765ba7da51a36a01f546fdd9c58d5704bcaaa086ec2e0a2f5bbda929c12'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
