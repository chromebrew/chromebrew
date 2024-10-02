require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.6.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6468eb42d0694c8244d0259a59f6c859567c966cc01a99b28457d1cdfaa7d396',
     armv7l: '6468eb42d0694c8244d0259a59f6c859567c966cc01a99b28457d1cdfaa7d396',
       i686: '2801c0bc8102e450b7b93cc1ba0661c2d73d9d4b6a30be494ace297c149cbae9',
     x86_64: '5f1d42874b6ad32517a56855bded8a9a070e6eed4e90c0a62e2ace8ef904a4bc'
  })

  depends_on 'ruby_abbrev' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
