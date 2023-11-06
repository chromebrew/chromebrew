require 'package'

class Ldc < Package
  description 'D language compiler using LLVM.'
  homepage 'https://github.com/ldc-developers/ldc'
  version '1.31.0'
  license 'BSD-3, Boost-1.0, MIT, NCSA and Artistic-1.0 or GPL-2+'
  compatibility 'x86_64'
  source_url 'https://github.com/ldc-developers/ldc/releases/download/v1.31.0/ldc2-1.31.0-linux-x86_64.tar.xz'
  source_sha256 '7dbd44786c0772ec41890a8c03e22b0985d6ef547c40943dd56bc6be21cf4d98'

  depends_on 'curl'
  depends_on 'ncurses'
  depends_on 'zlibpkg'

  no_compile_needed
  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.rm Dir['lib/*.o', 'lib/*.a']
    Dir['lib/*'].each do |lib|
      FileUtils.install lib, CREW_DEST_LIB_PREFIX.to_s, mode: 0o644
    end
    Dir['bin/*'].each do |bin|
      FileUtils.install bin, "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    end
    FileUtils.install 'etc/ldc2.conf', "#{CREW_DEST_PREFIX}/etc", mode: 0o644
    FileUtils.install 'etc/bash_completion.d/ldc2', "#{CREW_DEST_PREFIX}/etc/bash.d", mode: 0o644
  end
end
