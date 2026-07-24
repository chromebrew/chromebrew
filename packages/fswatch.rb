require 'buildsystems/autotools'

class Fswatch < Autotools
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
    aarch64: 'f389a976f06ca857551fc2cd587f1cbec578a8f63d82f0231e3c576283c6ef5c',
     armv7l: 'f389a976f06ca857551fc2cd587f1cbec578a8f63d82f0231e3c576283c6ef5c',
     x86_64: '9446f340de6c2319824b27357c3b2216b88af76662a182bdd512eaf3d742c7be'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options '--disable-static'

  run_tests
end
