require 'package'

class Nim < Package
  description 'Nim is a statically typed compiled systems programming language.'
  homepage 'https://nim-lang.org/'
  version '1.6.10'
  license 'MIT'
  compatibility 'all'
  source_url 'https://nim-lang.org/download/nim-1.6.10.tar.xz'
  source_sha256 '13d7702f8b57087babe8cd051c13bc56a3171418ba867b49c6bbd09b29d24fea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56bb6808eebaa0468fd5e23d22321d091113da09221ed9b5d86b20452ceb3201',
     armv7l: '56bb6808eebaa0468fd5e23d22321d091113da09221ed9b5d86b20452ceb3201',
       i686: '55f1f066de4b66b0bb741c1469eb05a414bd85432aa7d682d3ec1f270d213ada',
     x86_64: '1ca13bf167be97ac2bc1036a2b6a5e1ef27dcf148c8f836a36120b21d9c869e8'
  })

  depends_on 'pcre'

  def self.patch
    system 'sed -i "s,^ucpu=.*,ucpu=\"arm\"," build.sh' if ARCH == 'aarch64'
    system "sed -i \"s,/usr/local,#{CREW_DEST_PREFIX},g\" install.sh"
  end

  def self.build
    if ARCH == 'i686'
      # Fix fatal error: nimbase.h: No such file or directory.
      system 'CFLAGS+=" -I$(pwd)/lib" ./build.sh'
    else
      system './build.sh'
    end
    system 'bin/nim c koch'
    system './koch boot -d:release'
    if ARCH == 'i686'
      # Fix SYS_getrandom undeclared. See https://github.com/nim-lang/Nim/issues/19052.
      system './koch tools -d:nimNoGetRandom'
    else
      system './koch tools'
    end
  end

  def self.install
    system "./install.sh #{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nim/bin/nim", "#{CREW_DEST_PREFIX}/bin/nim"
  end
end
