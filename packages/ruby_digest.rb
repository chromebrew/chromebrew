require 'buildsystems/ruby'

class Ruby_digest < RUBY
  description 'Provides a framework for message digest libraries.'
  homepage 'https://github.com/ruby/digest'
  version "3.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ffe821b7a2f8e28803f0dde2ab84436f592b8186fdeeb103557f9d86e7e5ae51',
     armv7l: 'ffe821b7a2f8e28803f0dde2ab84436f592b8186fdeeb103557f9d86e7e5ae51',
       i686: '2f763253229f5d1ab3b49fb874f0d164cc8fe00380612d74f410aa108cac8424',
     x86_64: '34296630430cae6ab9be02f6dc6482927b9812098c9afe45c1567f434657f7af'
  })

  conflicts_ok
  gem_compile_needed
end
