require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version "1.11.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ad8c3e75d5e3673d3435fb00ce284285604d1edfa2060ec8241cb8f34469867a',
     armv7l: 'ad8c3e75d5e3673d3435fb00ce284285604d1edfa2060ec8241cb8f34469867a',
       i686: 'b3bd965dfac055f4dfdfa64f50bd1ac7971fdc11331320866a7d716fb87877fa',
     x86_64: '8b8ff98e15039d9320b9602404b18f7f88fceb326b9cb786993d73fff8f476f3'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'ruby_irb' # R
  depends_on 'ruby_reline' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
