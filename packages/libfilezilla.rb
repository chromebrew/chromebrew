require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.44.0'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.44.0.tar.xz'
  source_sha256 '2a8f57a06b52f6413b47d6a5dfbe7e9e31c84cc0784076f2f7e395232b0bd461'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.44.0_armv7l/libfilezilla-0.44.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.44.0_armv7l/libfilezilla-0.44.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.44.0_x86_64/libfilezilla-0.44.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4f46d2776f91118fc07137863bcd16d8c0814d0f9668f6d441e41ae5effe2a93',
     armv7l: '4f46d2776f91118fc07137863bcd16d8c0814d0f9668f6d441e41ae5effe2a93',
     x86_64: '750bbe20f9918f05c2be763e993d30bb5c0ba640769a42591c2a5293ff8a61cb'
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
