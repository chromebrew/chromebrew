# Adapted from Arch Linux cppdap PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cppdap

require 'buildsystems/cmake'

class Cppdap < CMake
  description 'C++ library for the Debug Adapter Protocol'
  homepage 'https://github.com/google/cppdap'
  version '1.58.0a'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/cppdap.git'
  git_hashtag 'dap-1.58.0-a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppdap/1.58.0a_armv7l/cppdap-1.58.0a-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppdap/1.58.0a_armv7l/cppdap-1.58.0a-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppdap/1.58.0a_i686/cppdap-1.58.0a-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cppdap/1.58.0a_x86_64/cppdap-1.58.0a-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2fb197cfb20972a5772193448d4e280c4d53886200695b8c5534dd421f27b5d6',
     armv7l: '2fb197cfb20972a5772193448d4e280c4d53886200695b8c5534dd421f27b5d6',
       i686: 'ef5d31637d72d53835fc95c40e71a1a11cdc6dd400be354a7ce53a40802bf819',
     x86_64: 'ba4e7b24fa6816029db58c173489ec183d601f00d9c1f12a171bbe630c6a720c'
  })
end
