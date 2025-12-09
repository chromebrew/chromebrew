require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.org/'
  version '1.34.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc8d50ce18eb0c6985d5886b9f7407431bcd75754f9c5dd3e96709f13f3d280d',
     armv7l: 'cc8d50ce18eb0c6985d5886b9f7407431bcd75754f9c5dd3e96709f13f3d280d',
       i686: 'b8329bcbdcdb19d03f1b87e6fb3cfd1cbfdcdf6c1c5f012c0177bfc836bcbe61',
     x86_64: '5dc718bf93d44a690125281d419951ea2d4ac1f3a80d9336e08ec9d6c9cf3114'
  })

  depends_on 'docbook2x' => :build
  depends_on 'glibc' # R

  cmake_options '-DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON'
end
