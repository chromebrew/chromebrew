require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.39.1'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.39.1.tar.bz2'
  source_sha256 'f3d6c0df28f33f52cf253cb03fc51579752ae4daef2aac7345a6bd7de623a6c5'

  binary_url({
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.39.1_armv7l/libfilezilla-0.39.1-chromeos-armv7l.tar.zst'
  })
  binary_sha256({
    armv7l: '250d912aef70be101d50da5d50240dc6f7064f6e6898248fccd51776fad6807e'
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
