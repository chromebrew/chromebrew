require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://www.balena.io/etcher/'
  compatibility 'x86_64, i686'
  @_ver = '1.5.115'
  version @_ver
  case ARCH
  when 'x86_64'
    source_url "https://github.com/balena-io/etcher/releases/download/v#{@_ver}/balena-etcher-electron_#{@_ver}_amd64.deb"
    source_sha256 'ff8da25c9e92424280031626ae1c2e595a1edfd4e6a0c220dfd190fd893f2bd4'
  when 'i686'
    source_url "https://github.com/balena-io/etcher/releases/download/v#{@_ver}/balena-etcher-electron_#{@_ver}_i386.deb"
    source_sha256 'c6af91ec0e7649be643bbd12765d1bc8a19d181c55f0135e10d3e9ed8d85c577'
  end

  depends_on 'gtk2'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'lzma'
  depends_on 'libnotify'
  depends_on 'nspr'
  depends_on 'libgconf'
  depends_on 'alien' => :build
  depends_on 'libxscrnsaver'
  depends_on 'sommelier'

  def self.build
    Dir.chdir('../') do
      system "alien -tc balena-etcher-electron_#{@_ver}_*.deb"
      system "tar xf balena-etcher-electron-#{@_ver}.tgz"
    end
  end
    
  def self.install
    ENV['CREW_NOT_STRIP'] = '1'
    Dir.chdir('../') do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      FileUtils.mv 'usr/share/', CREW_DEST_PREFIX
      FileUtils.mv 'opt/', CREW_DEST_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/opt/balenaEtcher/balena-etcher-electron", "#{CREW_DEST_PREFIX}/bin/balena-etcher-electron"
    end
  end
    
  def self.postinstall
    puts
    puts "To get started, type 'balena-etcher-electron'.".lightblue
    puts
  end
end