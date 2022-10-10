require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.39.1'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'file:///home/chronos/user/chromebrew/release/x86_64/libfilezilla-0.39.1.tar.bz2'
  source_sha256 'f3d6c0df28f33f52cf253cb03fc51579752ae4daef2aac7345a6bd7de623a6c5'

  binary_url({
    x86_64: 'file:///home/chronos/user/chromebrew/release/x86_64/libfilezilla-0.39.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '16cb148d8865f337480e3cffe4e8244a3a3f09aae6aa42e374fb2d97f2ba144e'
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
