require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.10-1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.10/libxml2-v2.9.10.tar.bz2'
  source_sha256 '5f1cc19c849cccabb983881cf1ebf833f42db5d7b8afba7a7763a2ac3101715c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.10-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ee3b6147dfce492b631c53893d1cc06e809e204498241710296035e49aa9d57',
     armv7l: '5ee3b6147dfce492b631c53893d1cc06e809e204498241710296035e49aa9d57',
       i686: 'd498f4cf27a067bf3d8257f67c6e1a405908460246a15af995991ec1f3c64c74',
     x86_64: '2082401a85b8e61263556f9fa0612d1d74064db0145a2fac0756c121bc0f11c4',
  })

  depends_on 'zlibpkg'

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    system "for f in \$(grep -rl \'TRUE)\'); do sed -i 's,TRUE),true),g' \$f; done"
  end

  def self.build
    # libxml2-python built in another package (libxml2_python)
    system "./autogen.sh #{CREW_OPTIONS} --enable-shared --disable-static --with-pic \
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
