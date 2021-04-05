require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.22.67'
  license 'MPL-2'
  compatibility 'x86_64'
  source_url "https://github.com/brave/brave-browser/releases/download/v#{version}/brave-browser-#{version}-linux-amd64.zip"
  source_sha256 'd71ac5a00ad701a002958059c5bd86920e5965dc1ac857a7e0abf432e29fce8c'

  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier' # The hardware acceleration with Wayland is broken, so use x11

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
    FileUtils.ln_s CREW_LIB_PREFIX, "#{CREW_DEST_PREFIX}/share/#{ARCH_LIB}"
  end
end
