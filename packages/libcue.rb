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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0-1_armv7l/libcue-2.3.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0-1_armv7l/libcue-2.3.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0-1_i686/libcue-2.3.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0-1_x86_64/libcue-2.3.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54d4c7aa7c4fdbbc8e87ed69719755fea07014146e8bae06b2c0b170d906cf1b',
     armv7l: '54d4c7aa7c4fdbbc8e87ed69719755fea07014146e8bae06b2c0b170d906cf1b',
       i686: '03a4dfe7ea1d1da36862ff3cb3e338d24c41dc07a2d2c1b6e30570ff9eba3806',
     x86_64: 'd0a45a029c0f28ea58b3690f145e7e281064750207a2384104a26056ea20efb6'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
