require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.7.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b6135588ee9ec00d8cf38b73dabbd45561759b1c8baff2d8b095b4881c62a365',
     armv7l: 'b6135588ee9ec00d8cf38b73dabbd45561759b1c8baff2d8b095b4881c62a365',
       i686: '0a326befb65bbb796ceee0c37e30abfd68e5d299dc979edd3911b9bac810503e',
     x86_64: '7be8246f9a33ac20cc263f528e1e154d78afc6d175e29059bda5d1326290898a'
  })

  conflicts_ok
  gem_compile_needed
end
