require 'buildsystems/ruby'

class Ruby_strscan < RUBY
  description 'Provides lexical scanning operations on a String.'
  homepage 'https://github.com/ruby/strscan'
  version "3.1.6-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd48740774373bd585cbe175920288916662f84e0235fa92c1109e15716f582f9',
     armv7l: 'd48740774373bd585cbe175920288916662f84e0235fa92c1109e15716f582f9',
       i686: '4b12f20a8115620665417948e48e9c83f0b02d3269d29ec9f4a62a6e0b757cb4',
     x86_64: '2b0691a727a407c2123eba132e69e4f3292d52156a60c16a1853ec3aa4b803f9'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
