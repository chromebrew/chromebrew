require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.19.7-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b3ba7e38260f0129b3b0d3cd6a59e0e0e4068f5892e1bd5e5b355c9a41c3c126',
     armv7l: 'b3ba7e38260f0129b3b0d3cd6a59e0e0e4068f5892e1bd5e5b355c9a41c3c126',
       i686: '7de80ceab6ae558eb53e9b1072edbb52a609ee434e16779320972cbb943d0aa2',
     x86_64: '5a536dd3b176678bd49afd94b92bd7255ed29a4a1bb58386e4dd45f6341ef750'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
