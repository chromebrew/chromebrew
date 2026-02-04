require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.18.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6d110a534de77659f25917bdd222bba59ec6887309a7e8f599c569247d254b8f',
     armv7l: '6d110a534de77659f25917bdd222bba59ec6887309a7e8f599c569247d254b8f',
       i686: '81e91c117e4e2e4024f7565bb56391e450df46e1c9d784a28440b48ca2cab7ed',
     x86_64: '81ea33aa980693da1583db99a664afb25ec30565cf6b1d993cb474ebc5fac120'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
