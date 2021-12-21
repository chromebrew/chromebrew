require 'package'

class Peazip < Package
  description 'Free file archiver utility to open and extract RAR, TAR and ZIP archives'
  homepage 'https://peazip.github.io/'
  version '8.3.0'
  license 'LGPL-3'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://osdn.net/dl/peazip/pea-gtk2-arm.tar.gz'
    source_sha256 '6724a5c4e273f086680ac30440a2014b647322d25ed9bba574b7b8edba61abcc'
  when 'i686'
    source_url 'https://github.com/peazip/PeaZip/releases/download/8.3.0/peazip_portable-8.3.0.LINUX.GTK2.x86.tar.gz'
    source_sha256 'a96cb7b70e37b73460f0319c83c911cf4fac587b62f0ca8c777c593876b41d45'
  when 'x86_64'
    source_url 'https://github.com/peazip/PeaZip/releases/download/8.3.0/peazip_portable-8.3.0.LINUX.GTK2.x86_64.tar.gz'
    source_sha256 '6382c744b4f510198ab57a65fe5d3e924ba399d1003c1338de5dd750d070fe36'
  end

  depends_on 'gtk2'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/peazip"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/application"
    FileUtils.mv 'res/', "#{CREW_DEST_PREFIX}/share/peazip/"
    FileUtils.mv 'peazip', "#{CREW_DEST_PREFIX}/share/peazip/"
    FileUtils.mv 'FreeDesktop_integration/peazip.desktop', "#{CREW_DEST_PREFIX}/share/application/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/peazip/peazip", "#{CREW_DEST_PREFIX}/bin/peazip"
  end

  def self.postinstall
    puts "\nType 'peazip' to get started.\n".lightblue
  end
end
