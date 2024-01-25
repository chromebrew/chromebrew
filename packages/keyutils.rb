require 'package'

class Keyutils < Package
  description 'Keyutils is a set of utilities for managing the key retention facility in the kernel, which can be used by filesystems, block devices and more to gain and retain the authorization and encryption keys required to perform secure operations.'
  homepage 'https://people.redhat.com/~dhowells/keyutils/'
  version '1.6.3'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18a3e216463811ab600854d806b41ddc87c2e07dfd05fde19ae2a84256fb591d',
     armv7l: '18a3e216463811ab600854d806b41ddc87c2e07dfd05fde19ae2a84256fb591d',
       i686: 'cf6a0538616941ddb4188f8c69bd10413451c03169c3ac65bd2f19ce403fec92',
     x86_64: '9f8ffd4e80ebe08b0b2244b558130157f1d93f26ff9b34378f76f2de140cc72f'
  })

  def self.patch
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i 's,ETCDIR		:= /etc,ETCDIR		:= #CREW_PREFIX#/etc,g' Makefile"
    system "sed -i 's,BINDIR		:= /bin,BINDIR		:= #CREW_PREFIX#/bin,g' Makefile"
    system "sed -i 's,SBINDIR		:= /sbin,SBINDIR		:= #CREW_PREFIX#/sbin,g' Makefile"
    system "sed -i 's,:= /lib*\$,:= #CREW_LIB_PREFIX#,g' Makefile"
    system "sed -i 's,:= /lib64*\$,:= #CREW_LIB_PREFIX#,g' Makefile"
    system "sed -i '1,/PREFIX/ {/PREFIX/a\
USRLIBDIR		:= #CREW_LIB_PREFIX#
}' Makefile"
    system "sed -i '1,/PREFIX/ {/PREFIX/a\
LIBDIR		:= #CREW_LIB_PREFIX#
}' Makefile"
    system "sed -i '/^CXXFLAGS/d' Makefile"
    system "sed -i '/^CFLAGS/d' Makefile"
    system "sed -i '1,/CPPFLAGS/ {/CPPFLAGS/a\
CFLAGS\t\t:= #{CREW_COMMON_FLAGS}
}' Makefile"
    system "sed -i '1,/CPPFLAGS/ {/CPPFLAGS/a\
CXXFLAGS\t\t:= #{CREW_COMMON_FLAGS}
}' Makefile"
    system "sed -i 's,/usr/local/lib/,#CREW_LIB_PREFIX#/,g' Makefile"
    system "sed -i 's,#CREW_LIB_PREFIX#,#{CREW_LIB_PREFIX},g' Makefile"
    system "sed -i 's,#CREW_PREFIX#,#{CREW_LIB_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.check
    system 'make test'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
