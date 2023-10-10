require 'buildsystems/cmake'

class Libcue < CMake
  description 'Parses so-called cue sheets and handles the parsed data.'
  homepage 'https://github.com/lipnitsk/libcue/'
  version '2.3.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lipnitsk/libcue.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0_armv7l/libcue-2.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0_armv7l/libcue-2.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0_i686/libcue-2.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcue/2.3.0_x86_64/libcue-2.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '190e7b62104a8e93f2350104edf58f97f39d4b9b91e51a08ea25e46dee15df69',
     armv7l: '190e7b62104a8e93f2350104edf58f97f39d4b9b91e51a08ea25e46dee15df69',
       i686: '7b808b4565166d5001c095ea3558f9f41b3c0add889bcfbd13c9b973031ff586',
     x86_64: '6364db5c3aaeaf790decdd8203821c1407886648eb2e5e2565cea4b2c7cdd83f'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
