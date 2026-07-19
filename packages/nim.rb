require 'package'

class Nim < Package
  description 'Nim is a statically typed compiled systems programming language.'
  homepage 'https://nim-lang.org/'
  version '2.2.10'
  license 'MIT'
  compatibility 'all'
  source_url "https://nim-lang.org/download/nim-#{version}.tar.xz"
  source_sha256 '7957b7ed004206bcf10bcc4f3b4744153878e62f2431552a9a8e9d3f40e8d5d5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f85c1f3ba80dd5dd62a79bd3d227bdecd52b14354e334dff8b9ea453377e3768',
     armv7l: 'f85c1f3ba80dd5dd62a79bd3d227bdecd52b14354e334dff8b9ea453377e3768',
       i686: '53d3bfc6d0f5e86dc190239a85078c799a29179468423504bf97bd3510ea666d',
     x86_64: '3ede3dededc6d8378647a3055b25cdc5dcde4b8629f2ca210b94fc03d6339272'
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
