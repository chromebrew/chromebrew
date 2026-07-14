require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.21.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '91d0cdb0fd14c0099a709bd8af1820c6844c85c24d721b07fbf7fef8b378548a',
     armv7l: '91d0cdb0fd14c0099a709bd8af1820c6844c85c24d721b07fbf7fef8b378548a',
       i686: 'b8b6d7f72e330f2a510d41cfc0519b7961206493375e9a265b74dffd52fb3242',
     x86_64: '98cff3e72755c7ccf3f6bde367680f7f3f3b7351fbfb57a5c31f64f114cd5c6a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
