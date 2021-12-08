require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.7.2'
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.2_armv7l/libx11-1.7.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.2_armv7l/libx11-1.7.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.2_i686/libx11-1.7.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.2_x86_64/libx11-1.7.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e066f82ad7b8578f672c472d8e132683426ebfc7707b036aa13891027b63fe8d',
     armv7l: 'e066f82ad7b8578f672c472d8e132683426ebfc7707b036aa13891027b63fe8d',
       i686: 'ad26fb5dbad41b0d1d8d3550fca22c48d3ca395bf5bb0440af5f6b701e1371df',
     x86_64: '329c60bc8ff483f079024654d81bcf932c54b79d7dd0314606a3f0d1b436be94'
  })

  depends_on 'llvm' => :build
  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxtrans'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
