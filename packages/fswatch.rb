require 'buildsystems/cmake'

class Fswatch < CMake
  description 'fswatch is a file change monitor that receives notifications when the contents of the specified files or directories are modified.'
  homepage 'https://github.com/emcrisostomo/fswatch'
  version '1.22.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.41'
  source_url 'https://github.com/emcrisostomo/fswatch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '34cd8361d367d69cbd7fc9c4962a6f9d220976aa945b9e6e6cce326da3fa1e0d',
     armv7l: '34cd8361d367d69cbd7fc9c4962a6f9d220976aa945b9e6e6cce326da3fa1e0d',
     x86_64: '73af7a5b0a18c628fbe51054103bd2b36a9bed111e08785964c5bcc45c9fe36a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'

  # Test failures are likely due to kernel issues with the GitHub Actions container environment.
  # run_tests
end
