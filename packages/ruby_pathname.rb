require 'buildsystems/ruby'

class Ruby_pathname < RUBY
  description 'Representation of the name of a file or directory on the filesystem.'
  homepage 'https://github.com/ruby/pathname'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
     x86_64: '6348eefa1db6d1ab05d56ef0b602e2675c675802a8e4b1a9433cc99340fed1bc'
  })

  conflicts_ok
  gem_compile_needed
end
