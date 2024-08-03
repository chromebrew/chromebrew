require 'buildsystems/autotools'

class Libarchive < Autotools
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version '3.7.4'
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version}.tar.xz"
  source_sha256 'f887755c434a736a609cbd28d87ddbfbe9d6a3bb5b703c22c02f6af80a802735'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c2e27421af7c3f046eda5b1699fc57483e3cefbfbcdec98fcf717255cde4b623',
     armv7l: 'c2e27421af7c3f046eda5b1699fc57483e3cefbfbcdec98fcf717255cde4b623',
       i686: '9264b769b88313287d575e55f5a8aff1c3ebbfa19013f459b09b9527f9d28721',
     x86_64: '68f0e3c3e2f8e1f123368310b3e5a64f8c08a6ebc30d0ba0905efe4d960c6c38'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'bzip2' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R
  depends_on 'expat' # R
  depends_on 'libxml2_autotools' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
