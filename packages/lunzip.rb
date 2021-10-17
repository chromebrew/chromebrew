require 'package'

class Lunzip < Package
  description 'Lunzip is a decompressor for lzip files.'
  homepage 'https://www.nongnu.org/lzip/lunzip.html'
  version '1.12'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lunzip/lunzip-1.12.tar.gz'
  source_sha256 'e55b4aaac5666b6ccad8459e52f8adb6869ce259f686e960129ae1e1bdf52ad2'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lunzip/1.12_armv7l/lunzip-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lunzip/1.12_armv7l/lunzip-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lunzip/1.12_i686/lunzip-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lunzip/1.12_x86_64/lunzip-1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '39afb5aeded95b64f63917732adeb2dd347cd5960615d3c741dc8e558394c178',
     armv7l: '39afb5aeded95b64f63917732adeb2dd347cd5960615d3c741dc8e558394c178',
       i686: '5786e83b5177866d795a4fb8c0e43beb12a6bf647cb5777a76c4704c3aaf2eb3',
     x86_64: '4f81c90fe8cdef3aa10c0e050ae939ef47a8716a46129b362a7a1a0cfff35d11',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              CC=#{CREW_TGT}-gcc \
              CFLAGS='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
