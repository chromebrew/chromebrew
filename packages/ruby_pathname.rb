require 'buildsystems/ruby'

class Ruby_pathname < RUBY
  description 'Representation of the name of a file or directory on the filesystem.'
  homepage 'https://github.com/ruby/pathname'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fa49f2fdb19b89834738270e09072046416a04af54dd07c6abf59053e29b264b',
     armv7l: 'fa49f2fdb19b89834738270e09072046416a04af54dd07c6abf59053e29b264b',
       i686: 'b34fadbfe70932a3e0c31394bc27a90ffa737e827c1d3854cc486037d5bdc50c',
     x86_64: '874f4c9314e70e2a869532eda3f7f774568bf410489539e8f45b116420f4908f'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
