require 'package'

class Tilp < Package
  description 'TiLP is a linking program for Texas Instruments\' graphing calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.18-1'
  source_url 'https://www.ticalc.org/pub/unix/tilp.tar.gz'
  source_sha256 '6ba834f7fdbbce9818ccaa864222aed2d1688b210e9ff2c59576d1fde5159cd7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libarchive'
  depends_on 'libglade'
  depends_on 'libusb'

  def self.install
    system 'wget http://lpg.ticalc.org/prj_tilp/download/install_tilp.sh'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('install_tilp.sh') ) == '6baf4b79100a938c2c36218d50c30a39c2beec17490784e3623d4aeebe9931ee'
    system "sed -i 's:/usr/bin/getent:#{CREW_PREFIX}/bin/getent:g' install_tilp.sh"
    system "PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} SRCDIR=#{CREW_DEST_PREFIX}/share bash install_tilp.sh"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/pkgconfig"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/appdata"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/locale"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/mime/packages"
    system "cp #{CREW_PREFIX}/bin/gfm #{CREW_DEST_PREFIX}/bin"
    system "cp #{CREW_PREFIX}/bin/tilp #{CREW_DEST_PREFIX}/bin"
    system "cp -r #{CREW_PREFIX}/include/tilp2 #{CREW_DEST_PREFIX}/include"
    system "cp #{CREW_LIB_PREFIX}/libticables2.so* #{CREW_DEST_LIB_PREFIX}"
    system "cp #{CREW_LIB_PREFIX}/libticalcs2.so* #{CREW_DEST_LIB_PREFIX}"
    system "cp #{CREW_LIB_PREFIX}/libticonv.so* #{CREW_DEST_LIB_PREFIX}"
    system "cp #{CREW_LIB_PREFIX}/libtifiles2.so* #{CREW_DEST_LIB_PREFIX}"
    system "cp #{CREW_LIB_PREFIX}/pkgconfig/ticables2.pc #{CREW_DEST_LIB_PREFIX}/pkgconfig"
    system "cp #{CREW_LIB_PREFIX}/pkgconfig/ticalcs2.pc #{CREW_DEST_LIB_PREFIX}/pkgconfig"
    system "cp #{CREW_LIB_PREFIX}/pkgconfig/ticonv.pc #{CREW_DEST_LIB_PREFIX}/pkgconfig"
    system "cp #{CREW_LIB_PREFIX}/pkgconfig/tifiles2.pc #{CREW_DEST_LIB_PREFIX}/pkgconfig"
    system "cp #{CREW_PREFIX}/share/appdata/gfm.appdata.xml #{CREW_DEST_PREFIX}/share/appdata"
    system "cp #{CREW_PREFIX}/share/appdata/tilp.appdata.xml #{CREW_DEST_PREFIX}/share/appdata"
    system "cp #{CREW_PREFIX}/share/applications/gfm.desktop #{CREW_DEST_PREFIX}/share/applications"
    system "cp #{CREW_PREFIX}/share/applications/tilp.desktop #{CREW_DEST_PREFIX}/share/applications"
    system "cp -r #{CREW_PREFIX}/share/gfm #{CREW_DEST_PREFIX}/share"
    system "cp #{CREW_PREFIX}/share/locale/de/LC_MESSAGES/libticalcs2.mo #{CREW_DEST_PREFIX}/share/locale"
    system "cp #{CREW_PREFIX}/share/locale/de/LC_MESSAGES/tilp2.mo #{CREW_DEST_PREFIX}/share/locale"
    system "cp #{CREW_PREFIX}/share/locale/fr/LC_MESSAGES/gfm.mo #{CREW_DEST_PREFIX}/share/locale"
    system "cp #{CREW_PREFIX}/share/locale/fr/LC_MESSAGES/libticables2.mo #{CREW_DEST_PREFIX}/share/locale"
    system "cp #{CREW_PREFIX}/share/locale/fr/LC_MESSAGES/libticalcs2.mo #{CREW_DEST_PREFIX}/share/locale"
    system "cp #{CREW_PREFIX}/share/locale/fr/LC_MESSAGES/libtifiles2.mo #{CREW_DEST_PREFIX}/share/locale"
    system "cp #{CREW_PREFIX}/share/locale/fr/LC_MESSAGES/tilp2.mo #{CREW_DEST_PREFIX}/share/locale"
    system "cp #{CREW_PREFIX}/share/mime/packages/tilp.xml #{CREW_DEST_PREFIX}/share/mime/packages"
    system "cp -r #{CREW_PREFIX}/share/tilp2 #{CREW_DEST_PREFIX}/share"
    system "rm -rf #{CREW_DEST_PREFIX}/share/tilp"
  end
end
