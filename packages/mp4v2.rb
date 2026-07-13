require 'buildsystems/autotools'

class Mp4v2 < Autotools
  description 'MP4v2 Library: This library provides functions to read, create, and modify mp4 files'
  homepage 'https://code.google.com/archive/p/mp4v2/'
  version '2.1.3'
  license 'MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/enzo1982/mp4v2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4837b6266236e26fae963c9a8fbb210400e10c22ec434babeeddd4cc3df4876',
     armv7l: 'f4837b6266236e26fae963c9a8fbb210400e10c22ec434babeeddd4cc3df4876',
       i686: '2ae8f39f433048d618f5c2fe9866a4a4439f0aaf13e71e3e4d7c528a00de3bf5',
     x86_64: '9a5535d74ad17da680ee2f3cf950005f992c63fbdc798eefaf97a0d23869c182'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options '--disable-debug'
end
