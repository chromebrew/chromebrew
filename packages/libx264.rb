require 'package'

class Libx264 < Package
  description 'x264 is a free software library and application for encoding video streams into the H.264/MPEG-4 AVC compression format.'
  homepage 'https://www.videolan.org/developers/x264.html'
  @_commit = 'bfc87b7a330f75f5c9a21e56081e4b20344f139e'
  version @_commit[0, 7]
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/x264.git'
  git_hashtag @_commit
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/bfc87b7_armv7l/libx264-bfc87b7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/bfc87b7_armv7l/libx264-bfc87b7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/bfc87b7_i686/libx264-bfc87b7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx264/bfc87b7_x86_64/libx264-bfc87b7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd325210d080d23ef91bca4f79c5b805002207be13752496b774d610befc0df0f',
     armv7l: 'd325210d080d23ef91bca4f79c5b805002207be13752496b774d610befc0df0f',
       i686: '7930e41ad3d8ade858166c795236619ac7eca074d7e5c1d060b3bbefb6648f02',
     x86_64: '435852363c74bcb1c0e3b4697f2dce777977acdaf1476ac4bd0b33516ccaf242'
  })

  depends_on 'nasm' => :build
  depends_on 'l_smash'

  @archflags = ARCH == 'aarch64' || ARCH == 'armv7l' ? '-march=armv7-a -mfpu=neon' : ''

  def self.patch
    system "sed -i 's,exec_prefix}/lib,exec_prefix}/lib#{CREW_LIB_SUFFIX},g' configure"
  end

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
