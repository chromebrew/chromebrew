require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.20.108'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url "https://github.com/brave/brave-browser/releases/download/v#{version}/brave-browser-#{version}-linux-amd64.zip"
    source_sha256 '3a6b5f0ff3c5bc839e5992f9ace19257b5866c3c3eb9c6bb061767c43a40a60a'
    depends_on 'gtk3'
    depends_on 'xdg_base'
    depends_on 'sommelier' # The hardware acceleration with Wayland is broken, so use x11
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
    FileUtils.ln_s CREW_LIB_PREFIX, "#{CREW_DEST_PREFIX}/share/#{ARCH_LIB}"
  end
end
