require 'package'

class Fceux < Package
  description 'NES/FDS emulator with TAS support'
  homepage 'https://fceux.com/'
  version '2.6.5'
  compatibility 'x86_64'
  license 'GPLv2'
  source_url "https://github.com/FinnBaltazar1111/fceux/releases/download/v#{version}/fceux-#{version}-amd64.deb"
  source_sha256 "7a740608aad4157aec6010cea29aecc30f5e7341667375b49bc38df770c5ca49"
  
  depends_on 'ffmpeg'
  depends_on 'libarchive'
  depends_on 'libsdl2'
  depends_on 'mesa_utils'
  depends_on 'minizip'
  depends_on 'numactl'
  depends_on 'qt5_base' 
  depends_on 'zlib'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/"
    FileUtils.cp_r ".", "#{CREW_DEST_PREFIX}"
  end

  def self.postinstall
    ExitMessage.add "\nFCEUX installation complete. Run \"fceux\" command (located in #{CREW_PREFIX}/fceux) to use.\n"
  end
end
