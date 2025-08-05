require 'buildsystems/ruby'

class Ruby_gdbm < RUBY
  description 'Ruby extension for GNU dbm.'
  homepage 'https://github.com/ruby/gdbm'
  version "2.1.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '3514768aca721d902ca8272e90c3d7d51da3c9ab2d79eecc134c73eafb0b89c0',
     armv7l: '3514768aca721d902ca8272e90c3d7d51da3c9ab2d79eecc134c73eafb0b89c0',
       i686: '761a94f6c28950a901e4b32ed0a48be3d0c3e99c1d97e26ce2ff997af0bca173',
     x86_64: 'efcbc3eacf91acc1569673e9bf3d7ce2ddcd7f933abd64a0f2471f25b7fe3ec9'
  })

  conflicts_ok
  gem_compile_needed
end
