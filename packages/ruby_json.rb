require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.18.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a112f0eba1122fdd1d26aec0d8964505b6c6fd1bb5c7ad0120d25dd774791447',
     armv7l: 'a112f0eba1122fdd1d26aec0d8964505b6c6fd1bb5c7ad0120d25dd774791447',
       i686: 'f6b1d6844e8d9ab44f9b1c131f6cc1ea65a2de7bd7bf66a0da38d1769cf1fb90',
     x86_64: '713f33df10ef0db37f5549e01344411a564a0dac6d38ff13be5d1194b90574da'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
