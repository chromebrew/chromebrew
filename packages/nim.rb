require 'package'

class Nim < Package
  description 'Nim is a statically typed compiled systems programming language.'
  homepage 'https://nim-lang.org/'
  version '2.2.12'
  license 'MIT'
  compatibility 'all'
  source_url "https://nim-lang.org/download/nim-#{version}.tar.xz"
  source_sha256 '2639a06a5ea7a7fcf57df1e7e1ef4d1b2bee58c7ac9bd00dbd2aa5bea1e5a56a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2e4d57db2fddf0120473135f211afb106ac279e3614e66e1ca95feff1413209',
     armv7l: 'f2e4d57db2fddf0120473135f211afb106ac279e3614e66e1ca95feff1413209',
       i686: 'e31c9827f2ab6006dc94b710235f7a312ab405ffa9462a86c68605e2fe3a2920',
     x86_64: '48cc4c585c8aebb9f159b2351aa92949730cf5d554d3997985a2063ff4455005'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'pcre' => :executable

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
