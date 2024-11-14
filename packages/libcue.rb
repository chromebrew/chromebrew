require 'buildsystems/cmake'

class Libcue < CMake
  description 'Parses so-called cue sheets and handles the parsed data.'
  homepage 'https://github.com/lipnitsk/libcue/'
  @_ver = '2.3.0'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lipnitsk/libcue.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54d4c7aa7c4fdbbc8e87ed69719755fea07014146e8bae06b2c0b170d906cf1b',
     armv7l: '54d4c7aa7c4fdbbc8e87ed69719755fea07014146e8bae06b2c0b170d906cf1b',
       i686: '03a4dfe7ea1d1da36862ff3cb3e338d24c41dc07a2d2c1b6e30570ff9eba3806',
     x86_64: 'd0a45a029c0f28ea58b3690f145e7e281064750207a2384104a26056ea20efb6'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
