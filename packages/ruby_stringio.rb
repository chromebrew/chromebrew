require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a675ff65212036324d829381ca9ee8b9ee65552ac1897f85ac5424fe986fff10',
     armv7l: 'a675ff65212036324d829381ca9ee8b9ee65552ac1897f85ac5424fe986fff10',
       i686: 'ce73dd54689f1054a58c0295ab98e2aeda47c10ca406f3b14482433678ad9018',
     x86_64: 'c3ed8c25a806797449692fc00b8cf28efffbb1829d1b5283eae8466a5cf1d4ca'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
