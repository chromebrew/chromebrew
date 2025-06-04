require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "5.0.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '771050120f54435a6578825b5a92a59f4a155453faf427bcbf0740003738725b',
     armv7l: '771050120f54435a6578825b5a92a59f4a155453faf427bcbf0740003738725b',
       i686: 'd58b89833c7eff6b66055d01e80b4edcc9bc7efb5b24bca6614350167a2015b5',
     x86_64: 'c8833c1eeb4150ab68df29c6352a64f6e3390aea878f0f8f6023302cfd6d9a7f'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
