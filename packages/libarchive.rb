require 'buildsystems/autotools'

class Libarchive < Autotools
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.7.4-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 'f887755c434a736a609cbd28d87ddbfbe9d6a3bb5b703c22c02f6af80a802735'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86a2891e468a8b0aba9f017ddb9986193dc1416c9971edd00a62e84c1132ccfe',
     armv7l: '86a2891e468a8b0aba9f017ddb9986193dc1416c9971edd00a62e84c1132ccfe',
       i686: '2aef89c9ed12b699ebb226a73acb7d6849825af6b0e9ef4604e685f85f15e594',
     x86_64: 'a055feffdd4c67283a1584b198073f48633d64f7f58297b1411bdfd011053fa8'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
