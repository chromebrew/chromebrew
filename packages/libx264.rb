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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/5db6aa6_armv7l/libx264-5db6aa6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/5db6aa6_armv7l/libx264-5db6aa6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/5db6aa6_i686/libx264-5db6aa6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/5db6aa6_x86_64/libx264-5db6aa6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '05d471e5ae3d77c4746155c0b1b74200b5f0c1965368e3157a38d5f5b6617be8',
     armv7l: '05d471e5ae3d77c4746155c0b1b74200b5f0c1965368e3157a38d5f5b6617be8',
       i686: '50210bd8a64823d520299be85cf6edc6d8aec790427ebcfefa1a017ba9f8a779',
     x86_64: '77501d484979b7417e97cfa07b60d5251ab959872820d6b4d68149c25af209ae'
  })

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
