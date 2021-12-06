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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.2_i686/libx11-1.7.2-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.7.2_x86_64/libx11-1.7.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '75c5a9329341c60e26bfd7983c89975b0f2d0f81261966a20ed0ec8735cc17f3',
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
