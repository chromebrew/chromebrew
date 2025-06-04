require 'buildsystems/ruby'

class Ruby_strscan < RUBY
  description 'Provides lexical scanning operations on a String.'
  homepage 'https://github.com/ruby/strscan'
  version "3.1.5-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '642a4d8c490555fe2fb4894f1d1689eaf611ee0577c3cfc4a33ba4ca9734aab9',
     armv7l: '642a4d8c490555fe2fb4894f1d1689eaf611ee0577c3cfc4a33ba4ca9734aab9',
       i686: '7afdc14765255716eeedee7bc905e2b976904c1c30583ad02ac969fa37a57860',
     x86_64: '827a7b8abba2f99dcd3e48f3708af76e7a27a74b651fae50991ac91760d154d3'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
