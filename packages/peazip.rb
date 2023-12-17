require 'package'

class Peazip < Package
  description 'Free file archiver utility to open and extract RAR, TAR and ZIP archives'
  homepage 'https://peazip.github.io/'
  license 'LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  case ARCH
  when 'aarch64', 'armv7l'
    version '5.2.0'
    source_url 'https://downloads.sourceforge.net/project/peazip/5.2.0/pea-gtk2-arm.tar.gz'
    source_sha256 '6724a5c4e273f086680ac30440a2014b647322d25ed9bba574b7b8edba61abcc'
  when 'x86_64'
    version '8.6.0'
    source_url 'https://github.com/peazip/PeaZip/releases/download/8.6.0/peazip_portable-8.6.0.LINUX.GTK2.x86_64.tar.gz'
    source_sha256 '8d430a24dc6aaf21931aa82e46e91e36fcf82eaeb9a53906b3cce360668a443b'
  end

  depends_on 'gtk2'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/peazip"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/application"
    case ARCH
    when 'aarch64', 'armv7l'
      FileUtils.mv 'FreeDesktop_integration/peazip.desktop', "#{CREW_DEST_PREFIX}/share/application/"
    when 'x86_64'
      FileUtils.mv 'pea', "#{CREW_DEST_PREFIX}/share/peazip/"
      FileUtils.cp 'res/share/batch/freedesktop_integration/peazip.desktop', "#{CREW_DEST_PREFIX}/share/application/"
      FileUtils.ln_s "#{CREW_PREFIX}/share/peazip/pea", "#{CREW_DEST_PREFIX}/bin/pea"
    end
    FileUtils.mv 'peazip', "#{CREW_DEST_PREFIX}/share/peazip/"
    FileUtils.mv 'res/', "#{CREW_DEST_PREFIX}/share/peazip/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/peazip/peazip", "#{CREW_DEST_PREFIX}/bin/peazip"
  end

  def self.postinstall
    puts "\nType 'peazip' to get started.\n".lightblue
  end
end
