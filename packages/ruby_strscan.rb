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
    aarch64: '223cad8f4162b150bb16f4627703d12073bf06130aee86b411caf53fd49e7915',
     armv7l: '223cad8f4162b150bb16f4627703d12073bf06130aee86b411caf53fd49e7915',
       i686: '7afdc14765255716eeedee7bc905e2b976904c1c30583ad02ac969fa37a57860',
     x86_64: 'b3ca7558687bea73952ff41fcd8ae589adab49a98bcd0cf176fda2cf505ee1f7'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
