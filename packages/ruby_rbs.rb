require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "4.2.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a09ae862e87fc17bc306c2bb112a0dc2d35a9ec89b930c84eb688161b106d595',
     armv7l: 'a09ae862e87fc17bc306c2bb112a0dc2d35a9ec89b930c84eb688161b106d595',
       i686: '4ff85ebedab8397a6f67d3ab331df85f189b44c5c66ea56cf7d94a69f537fabe',
     x86_64: '821f63c887047bbd683eeb5a3470e5c557f7971feb5a3e737cfbb4183971731f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_logger' # R
  depends_on 'ruby_tsort' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
