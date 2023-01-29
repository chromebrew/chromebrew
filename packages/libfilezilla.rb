require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.41.0'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.41.0.tar.bz2'
  source_sha256 'ac2a1d0d828ea600787cea1e7ee50d21f0d3bd9152cece6187b8afc900622aa0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.41.0_armv7l/libfilezilla-0.41.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.41.0_armv7l/libfilezilla-0.41.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.41.0_x86_64/libfilezilla-0.41.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd150480edb6fbe9b676b0b31cc3b660bb0fb762a37049ddbef5974a4b378866a',
     armv7l: 'd150480edb6fbe9b676b0b31cc3b660bb0fb762a37049ddbef5974a4b378866a',
     x86_64: '62f9f92b33fcfd2b8ccd8f889f8c8e3f6a25475aafbdef3caa6bb0747e0582d7'
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
