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
    aarch64: '81b13fdc61b3542a2f7360c1c21cb20b3a110980cf99578298fc7167efeab08f',
     armv7l: '81b13fdc61b3542a2f7360c1c21cb20b3a110980cf99578298fc7167efeab08f',
       i686: 'aa3c9772c62f13a2172727401af48b69ed4e36ab0dc40e64d2fc34b85c8db660',
     x86_64: '77047584b502ea58802df28cf5941e7ee7dbb454a4dc2de96df405cf052b8efb'
  })

  conflicts_ok
  gem_compile_needed
end
