require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b74532193b338ee3fdbef28c072eb10016015a5bba371b6506c8c3abf9500b65',
     armv7l: 'b74532193b338ee3fdbef28c072eb10016015a5bba371b6506c8c3abf9500b65',
       i686: '26da99b7eb37fbd540dd267e8611cbbeade1935c386f5b5daa2ddeb3549f2c30',
     x86_64: '212c1693c76a362f0ddfe490d2b82713620bc49e1af9eef37120596c1bc17730'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
