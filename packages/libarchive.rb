require 'buildsystems/autotools'

class Libarchive < Autotools
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version '3.7.2'
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version}.tar.xz"
  source_sha256 '04357661e6717b6941682cde02ad741ae4819c67a260593dfb2431861b251acb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27d7882d8f01b817ea8f2089fbbed808518135e16b8b9d1841db25d78b56888a',
     armv7l: '27d7882d8f01b817ea8f2089fbbed808518135e16b8b9d1841db25d78b56888a',
       i686: '476f5b9467a28fa8814efae881dbd7b1dc5ba77e011dade4cda532c775aa61e9',
     x86_64: '5a002f95983f1e11efc15f0b9b0d2a9fb2081895080b918f5944808a99cbb195'
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
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
