require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.9.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a0875a41f11e6a88248a67f9928992ba56d7dc2d8645d10b9cfc5502e23d7f5f',
     armv7l: 'a0875a41f11e6a88248a67f9928992ba56d7dc2d8645d10b9cfc5502e23d7f5f',
       i686: '6b6bd66362bbdf404b0bec4c5fc30f607da1d489cc2d4fe54393cacbf71f8c4b',
     x86_64: 'c244ac795d8f4d83a42db80df5b06da546c2de7d1770d698bbac1e337de03df2'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
