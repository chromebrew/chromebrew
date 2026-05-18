require 'package'

class Mesen < Package
  description 'Multi-system emulator (NES, SNES, GB, GBA, PCE, SMS/GG, WS) for Windows, Linux and macOS'
  homepage 'https://www.mesen.ca/'
  version '2.1.1'
  license 'GPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/SourMesen/Mesen2/releases/download/#{version}/Mesen_#{version}_Linux_x64.zip"
  source_sha256 '7a9947575cc198209f743fef83fb2b702b786ea705506bdf3f2aea01ab7c1ce9'

  depends_on 'libice' => :library
  depends_on 'libsm' => :library
  depends_on 'sdl2' => :library

  no_compile_needed

  def self.install
    FileUtils.install 'Mesen', "#{CREW_DEST_PREFIX}/bin/mesen", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'mesen' to get started.\n"
  end
end
