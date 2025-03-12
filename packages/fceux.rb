require 'package'

class Fceux < Package
  description 'NES/FDS emulator with TAS support'
  homepage 'https://fceux.com/'
  version '2.6.5'
  compatibility 'x86_64'
  license 'GPLv2'
  source_url "https://github.com/FinnBaltazar1111/fceux/releases/download/v#{version}/fceux-#{version}-amd64.deb"
  source_sha256 "7b85f7682ac89a148b8c2a43dd4b8c71e8effd719a3d8f251f119e56ba63052f"
  
  depends_on 'qt5_base'
  depends_on 'minizip'
  depends_on 'libsdl2'
  depends_on 'ffmpeg'
  depends_on 'libarchive'
  depends_on 'zlib'
  depends_on 'mesa_utils'
  depends_on 'numactl'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/"
    FileUtils.cp_r ".", "#{CREW_DEST_PREFIX}"
  end

  def self.postinstall
    ExitMessage.add "\nInstallation complete. FCEUX executable is located in \"#{CREW_PREFIX}/bin/fceux\".\n"
  end
end