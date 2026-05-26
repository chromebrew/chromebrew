require 'buildsystems/cmake'

class Libsndfile < CMake
  description 'Libsndfile is a C library for reading and writing files containing sampled sound (such as MS Windows WAV and the Apple/SGI AIFF format) through one standard library interface.'
  homepage 'https://github.com/libsndfile/libsndfile'
  version '1.2.2-68f6c16f'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/libsndfile/libsndfile.git'
  git_hashtag '68f6c16fe1407eff4cdde158566694c3ed666c2f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d0471943a1768ec65ce97a472a0abe9fc1c45167bebadf36702068b759716a5',
     armv7l: '2d0471943a1768ec65ce97a472a0abe9fc1c45167bebadf36702068b759716a5',
       i686: '3222e03b9e2be06aa7e9434675bb227b09581552b78698be1654a11b846e285c',
     x86_64: 'fd1387be738c0d74d05633da1c0449d08dcead3170cd7b38b3572ebbaea6b352'
  })

  depends_on 'alsa_lib' => :executable
  depends_on 'flac' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libmp3lame' => :library
  depends_on 'libogg' => :library
  depends_on 'libvorbis' => :library
  depends_on 'mpg123' => :library
  depends_on 'nasm' => :build
  depends_on 'opus' => :library
  depends_on 'sane_backends' => :library
  depends_on 'speex' => :build
  depends_on 'sqlite' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
