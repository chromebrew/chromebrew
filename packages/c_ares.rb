require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.23.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "cares-#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.23.0_armv7l/c_ares-1.23.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.23.0_armv7l/c_ares-1.23.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.23.0_i686/c_ares-1.23.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.23.0_x86_64/c_ares-1.23.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '70191e6614bdbcdb3bafe196af1ba643b2506e7b394417ed59e2ed532d057ce7',
     armv7l: '70191e6614bdbcdb3bafe196af1ba643b2506e7b394417ed59e2ed532d057ce7',
       i686: '4ceee8430606e7f1d9085b9d96b36a5a9b54a8a4561674b8826c013f1952ec16',
     x86_64: 'e7a8595eaa6e95ecbb25c9568eac8fb6aa39e4ac0f462b32ad2b05f8bfa4dde6'
  })

  depends_on 'glibc' # R

  cmake_options '-DCARES_STATIC=ON \
      -DCARES_STATIC_PIC=ON \
      -DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON \
      -DCARES_SHARED=ON'
end
