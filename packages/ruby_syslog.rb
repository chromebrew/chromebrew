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
    aarch64: '35e45616691617acbedee3b233bc805891ab97d7661f2f89f261d46112ac8d13',
     armv7l: '35e45616691617acbedee3b233bc805891ab97d7661f2f89f261d46112ac8d13',
       i686: '32c2074fcb9d7e9903c6c46e56376f5e0288c0f2925ca4d89eac06f1b6c61c00',
     x86_64: 'ec37532cf8f14c967e6b84e3fc8c8b10d3b0dbdfc6ed4b0736083e4d09e3fb9e'
  })

  conflicts_ok
  gem_compile_needed
end
