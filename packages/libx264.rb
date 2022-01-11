require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'https://www.videolan.org/developers/x264.html'
  @_commit = '5db6aa6cab1b146e07b60cc1736a01f21da01154'
  version @_commit[0,7]
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/x264.git'
  git_hashtag @_commit

  depends_on 'nasm' => :build
  depends_on 'l_smash'

  @archflags = ARCH == 'aarch64' || ARCH == 'armv7l' ? '-march=armv7-a -mfpu=neon' : ''

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --disable-avs \
              --enable-lto \
              --enable-shared \
              --enable-static"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
