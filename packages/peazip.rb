require 'package'

class Peazip < Package
  description 'Free file archiver utility to open and extract RAR, TAR and ZIP archives'
  homepage 'https://peazip.github.io/'
  version ARCH.eql?('x86_64') ? '10.9.0' : '5.2.0'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.34' if ARCH.eql?('x86_64')
  source_url({
    aarch64: 'https://downloads.sourceforge.net/project/peazip/5.2.0/pea-gtk2-arm.tar.gz',
     armv7l: 'https://downloads.sourceforge.net/project/peazip/5.2.0/pea-gtk2-arm.tar.gz',
     x86_64: "https://github.com/peazip/PeaZip/releases/download/#{version}/peazip_portable-#{version}.LINUX.GTK2.x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '6724a5c4e273f086680ac30440a2014b647322d25ed9bba574b7b8edba61abcc',
     armv7l: '6724a5c4e273f086680ac30440a2014b647322d25ed9bba574b7b8edba61abcc',
     x86_64: '4811c25185ed0b9621157b9eb5aa20063b1854198fd0695bac46fc98a4dd7712'
  })

  depends_on 'gtk2'
  depends_on 'sommelier' => :logical

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
    if File.exist?("#{CREW_PREFIX}/opt/glibc-libs/libm.so.6") && !File.exist?("#{CREW_LIB_PREFIX}/libm.so.6")
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/opt/glibc-libs/libm.so.6", "#{CREW_DEST_LIB_PREFIX}/libm.so.6"
    end
    if File.exist?("#{CREW_PREFIX}/opt/glibc-libs/libpthread.so.0") && !File.exist?("#{CREW_LIB_PREFIX}/libpthread.so.0")
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/opt/glibc-libs/libpthread.so.0", "#{CREW_DEST_LIB_PREFIX}/libpthread.so.0"
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'peazip' to get started.\n"
  end
end
