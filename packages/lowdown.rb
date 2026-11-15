require 'package'

class Lowdown < Package
  description 'Simple markdown translator'
  homepage 'https://kristaps.bsd.lv/lowdown'
  version '3_2_1'
  license 'ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kristapsdz/lowdown.git'
  git_hashtag "VERSION_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd80f0e9173b29d5537177d632da362f98d042e013c8c24f39897623c7fff86b9',
     armv7l: 'd80f0e9173b29d5537177d632da362f98d042e013c8c24f39897623c7fff86b9',
     x86_64: '84177cd0013162e8be87ee1d19e1a8d9b7360c93877103b8d8a3351773ce34bc'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.build
    system './configure'
    # These constants need set inside Makefile
    system "sed -i '18iPREFIX = #{CREW_PREFIX}' Makefile"
    system "sed -i '19iLIBDIR = #{CREW_LIB_PREFIX}' Makefile"
    system "sed -i '20iDESTDIR = #{CREW_DEST_DIR}' Makefile"
    # The following lines fix Makefile:###: *** missing separator.
    system "sed -i '192d' Makefile"
    system "sed -i '188,190d' Makefile"
    system "sed -i '182,183d' Makefile"
    system "sed -i '178,179d' Makefile"
    system "sed -i '156,162d' Makefile"
    system 'make'
  end

  def self.install
    system 'make install install_libs'
  end
end
