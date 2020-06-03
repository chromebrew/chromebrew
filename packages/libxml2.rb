require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.10'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.10/libxml2-v2.9.10.tar.bz2'
  source_sha256 '5f1cc19c849cccabb983881cf1ebf833f42db5d7b8afba7a7763a2ac3101715c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6c7da2f6074adc4022ade9e72a070037657a1c708150404c5b9c7d07634c5390',
     armv7l: '6c7da2f6074adc4022ade9e72a070037657a1c708150404c5b9c7d07634c5390',
       i686: '9baf9a41ad01e2b6d09f09c9a65a74b37ac839e53ce00c0ebf048bc1d1d7b01f',
     x86_64: '4c1305434bbac822e6d08234d3058e94bca0ab95591ca25a0ccc8675cd16c48e',
  })
 
  depends_on 'zlibpkg'

  def self.build
    system './autogen.sh'
    # libxml2-python built in another package (libxml2_python)
    system "./configure #{CREW_OPTIONS} --enable-shared --disable-static --with-pic \
--without-python --without-lzma --with-zlib --with-icu --with-threads --with-history"
    system 'make'
  end

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system 'rm', 'test/ebcdic_566012.xml'

    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
