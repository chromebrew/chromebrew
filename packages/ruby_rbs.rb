require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "4.0.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '78b4ab76633f9c3c40c9e65d2dd6fde04ed1356cbbf5659c5af93389eabdddda',
     armv7l: '78b4ab76633f9c3c40c9e65d2dd6fde04ed1356cbbf5659c5af93389eabdddda',
       i686: 'd490c4afd377b31afeb9508267cc74cd7280a3c75c9a80e68059907a85d58d7a',
     x86_64: '47824f102932b8f28481b44ef69baf3bbc8200f79471f25ace6591e8c0f3b900'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_logger' # R
  depends_on 'ruby_tsort' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
