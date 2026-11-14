require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.32.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'daefd6556731bbbeec92e26af593f71d894f9bff33d6ecc505c22e2aaa34d9e9',
     armv7l: 'daefd6556731bbbeec92e26af593f71d894f9bff33d6ecc505c22e2aaa34d9e9',
       i686: '92b3d01689171538a2f5d4fb1e0a04e4af06a51f0aedae7e1ff432b0a0ab820e',
     x86_64: 'ae87d2cbde18913ba5749f69ddd1b144eeea3ac0c6120be8bbd48dc18ac93109'
  })

  depends_on 'sphinx' => :build
end
