require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.41.1'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.41.1.tar.bz2'
  source_sha256 'a4d55f82224057c8940a01565483b056bab321df140f9e64f20018f986200574'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.41.1_armv7l/libfilezilla-0.41.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.41.1_armv7l/libfilezilla-0.41.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.41.1_x86_64/libfilezilla-0.41.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '163c6a18072af9bc2211ec2888fbdca4871630dc272d914d8a5d7543aabe246b',
     armv7l: '163c6a18072af9bc2211ec2888fbdca4871630dc272d914d8a5d7543aabe246b',
     x86_64: '25d30d355121b112d1621bd7bbe1b043e11a90461b54100216a4bc653eeec207'
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
