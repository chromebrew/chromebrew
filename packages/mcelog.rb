require 'package'

class Mcelog < Package
  description 'logs and accounts machine checks (in particular memory, IO, and CPU hardware errors) on modern x86 Linux systems.'
  homepage 'https://www.mcelog.org/'
  version '162'
  source_url 'https://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git/snapshot/mcelog-162.tar.gz'
  source_sha256 '875e98572e86240ea319ab1f69ee6d744eb8b73ac5d700e474f6410d0f52d3fc'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.patch
    system "sed -i 's,prefix := /usr,prefix := #{CREW_PREFIX},' Makefile"
    system "sed -i 's,etcprefix :=,etcprefix := #{CREW_PREFIX},' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
