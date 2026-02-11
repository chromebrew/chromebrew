require 'buildsystems/ruby'

class Ruby_jaro_winkler < RUBY
  description 'Jaro_winkler is an implementation of Jaro-Winkler distance algorithm which is written in C extension and will fallback to pure Ruby version in platforms other than MRI/KRI like JRuby or Rubinius.'
  homepage 'https://github.com/tonytonyjan/jaro_winkler'
  version "1.7.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '856bedbe2e6028fd40f0794b2ca45dd2c36436d1dd72725c9ca7afe1da56b7e1',
     armv7l: '856bedbe2e6028fd40f0794b2ca45dd2c36436d1dd72725c9ca7afe1da56b7e1',
       i686: 'd16ad5475994b158796ac5ca7ee21c15206b94ee0616c33a2c2fd31f8fae57a0',
     x86_64: 'ea4c231509537fb3333903adc376a7e27e170ebecb5696a4d8501113ca51e5ff'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
