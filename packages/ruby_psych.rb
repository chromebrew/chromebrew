require 'buildsystems/ruby'

class Ruby_psych < RUBY
  description '| psych is a yaml parser and emitter.'
  homepage 'https://github.com/ruby/psych'
  version "5.4.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f2886084feaa6043c3541b84ee3e60506bd88a6c0f13b8571070e01481ddf6b3',
     armv7l: 'f2886084feaa6043c3541b84ee3e60506bd88a6c0f13b8571070e01481ddf6b3',
       i686: 'ea4b85cff2275c0e3d12d3736285f29257f34049239e4df648f8f63701404401',
     x86_64: 'aa88279b26c0fe078f4a86c822db4e820d95fc230db93065dfdbb75664652d7c'
  })

  depends_on 'glibc' => :library
  depends_on 'libyaml' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
