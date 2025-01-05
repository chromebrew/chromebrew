require 'buildsystems/ruby'

class Ruby_strscan < RUBY
  description 'Provides lexical scanning operations on a String.'
  homepage 'https://github.com/ruby/strscan'
  version "3.1.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'c972769c684978ee9ef03ca6dc04da9c12dc80d9389a8949d2e018d67f6fb064',
     armv7l: 'c972769c684978ee9ef03ca6dc04da9c12dc80d9389a8949d2e018d67f6fb064',
       i686: '013d5e27649cae733eb07456ad4e28a4d474b711d2569e89b82af685c1b1d789',
     x86_64: '74f89fc9209cb824c54f160abe5436a5a5cac0dabe43c19ff7142896172d9ba0'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
