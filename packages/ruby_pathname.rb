require 'buildsystems/ruby'

class Ruby_pathname < RUBY
  description 'Representation of the name of a file or directory on the filesystem.'
  homepage 'https://github.com/ruby/pathname'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0103a8cf67061c6406844c6471aa3b057668f8e9903331396c33a5e84cc48895',
     armv7l: '0103a8cf67061c6406844c6471aa3b057668f8e9903331396c33a5e84cc48895',
       i686: 'd436b0448b8ebce2501e36be9a5224eaeef94479a934bea78df997b6d77a02f0',
     x86_64: '02f0529825126878ebb1dca4d0330fb1de772993479c6d4c64a201db8b407329'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
