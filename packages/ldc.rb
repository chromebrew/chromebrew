require 'package'

class Ldc < Package
  description 'D language compiler using LLVM.'
  homepage 'https://github.com/ldc-developers/ldc'
  version '1.40.0'
  license 'BSD-3, Boost-1.0, MIT, NCSA and Artistic-1.0 or GPL-2+'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/ldc-developers/ldc/releases/download/v#{version}/ldc2-#{version}-linux-x86_64.tar.xz"
  source_sha256 '0da61ed2ea96583aa0ccbeb00f8d78983b23d1e87b84a6f2098eb12059475b27'

  depends_on 'curl'
  depends_on 'ncurses'
  depends_on 'zlib'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.rm Dir['lib/*.o', 'lib/*.a']
    Dir['lib/*'].each do |lib|
      FileUtils.install lib, CREW_DEST_LIB_PREFIX, mode: 0o644
    end
    Dir['bin/*'].each do |bin|
      FileUtils.install bin, "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    end
    FileUtils.install 'etc/ldc2.conf', "#{CREW_DEST_PREFIX}/etc", mode: 0o644
    FileUtils.install 'etc/bash_completion.d/ldc2', "#{CREW_DEST_PREFIX}/etc/bash.d", mode: 0o644
  end
end
