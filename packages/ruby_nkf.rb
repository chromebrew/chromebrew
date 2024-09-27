require 'buildsystems/ruby'

class Ruby_nkf < RUBY
  description 'Ruby extension for Network Kanji Filter'
  homepage 'https://github.com/ruby/nkf'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f76034be15e74aa3dc14e7071e1a79d73a022ddfbeba5621f283ff04e15a7489',
     armv7l: 'f76034be15e74aa3dc14e7071e1a79d73a022ddfbeba5621f283ff04e15a7489',
       i686: '81dea3a802feefcce7346d10d1b8bc957558414b9ac69a7305e80dfed71b5621',
     x86_64: '4a75a328bc63d0c4dae333acb230dae3df61809c50880cf7b3fe69078ac2f7f9'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
