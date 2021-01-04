require 'package'

class Peazip < Package
  description 'Free file archiver utility to open and extract RAR, TAR and ZIP archives'
  homepage 'https://peazip.github.io/'
  version '7.6.0'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://osdn.net/dl/peazip/pea-gtk2-arm.tar.gz'
    source_sha256 '6724a5c4e273f086680ac30440a2014b647322d25ed9bba574b7b8edba61abcc'
  when 'i686'
    source_url 'https://github.com/peazip/PeaZip/releases/download/7.6.0/peazip_portable-7.6.0.LINUX.GTK2.tar.gz'
    source_sha256 'bad059a252bdcb55c341a8b5cd1a4208c3b128a252079b36591684444d58afab'
  when 'x86_64'
    source_url 'https://github.com/peazip/PeaZip/releases/download/7.6.0/peazip_portable-7.6.0.LINUX.x86_64.GTK2.tar.gz'
    source_sha256 'fc04031fb7bcbc1959bd203b895bea209849744d470ea5b53670790a26606c1f'
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
    puts
    puts "Type 'peazip' to get started.".lightgreen
    puts
  end
end
