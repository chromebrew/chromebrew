require 'buildsystems/ruby'

class Ruby_syslog < RUBY
  description 'Ruby interface for the posix system logging facility.'
  homepage 'https://github.com/ruby/syslog'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0b3053851621effc962a71d95a11e9227150a4a01d54dddc51b7892bcbc34c18',
     armv7l: '0b3053851621effc962a71d95a11e9227150a4a01d54dddc51b7892bcbc34c18',
       i686: 'a423225327a1c48a41319d75cbbaa152e26a503a980b7ef65ea7bdaed68b09e4',
     x86_64: 'd8eb0339c59075e23d1b1006a4a610dde6b8287629c1a984e75174a903dcc70c'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
