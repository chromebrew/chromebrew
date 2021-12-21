require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.35.0'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.35.0.tar.bz2'
  source_sha256 'eee2510dce3d0691ea73dc1da10fac7db1215b0ba9eefa616df305368b092ae8'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.35.0_armv7l/libfilezilla-0.35.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.35.0_armv7l/libfilezilla-0.35.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.35.0_x86_64/libfilezilla-0.35.0-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: 'ee13f1cfbe811e115848448a08e2ef005b538bd6f6a0cbf2242b0d6421ec90c2',
     armv7l: 'ee13f1cfbe811e115848448a08e2ef005b538bd6f6a0cbf2242b0d6421ec90c2',
     x86_64: '3938dad3bae7579ed831ab2a173c01e1a8b3bb1067c4146804e16a1e93d7df91',
  })

  depends_on 'openmp'
  depends_on 'p11kit'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
