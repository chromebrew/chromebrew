require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.42.2'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.42.2.tar.xz'
  source_sha256 '4f9981a171919d3f3f4742fd50c0265947e67c531aff66fa46c7511a2629ce91'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.42.2_armv7l/libfilezilla-0.42.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.42.2_armv7l/libfilezilla-0.42.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.42.2_x86_64/libfilezilla-0.42.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1384630e06bff071f6cafb33bac189b14435f772fe378de259b92b71d641942c',
     armv7l: '1384630e06bff071f6cafb33bac189b14435f772fe378de259b92b71d641942c',
     x86_64: '5cfe289babc1b5a60dd80d552b9c325617355ffb9ece3a3e24d42179d1760cd6'
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
