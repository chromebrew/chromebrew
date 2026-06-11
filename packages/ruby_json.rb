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
    aarch64: '70f70610cdb09a4995a92ad82f3109b45d956787644f02b35e78fd46eef13a24',
     armv7l: '70f70610cdb09a4995a92ad82f3109b45d956787644f02b35e78fd46eef13a24',
       i686: '3c5c96c090c81ef1603e9d9856c4c9f99eca6014d12188f0e85c5900765499c2',
     x86_64: '1d1d161629a5ead0cb0855df00455734feccee52a5e4190e8fd97a2396294913'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
