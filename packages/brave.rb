require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.26.11'
  license 'MPL-2'
  compatibility 'x86_64'
  source_url "https://github.com/brave/brave-browser/releases/download/v#{version}/brave-browser-nightly-#{version}-linux-amd64.zip"
  source_sha256 '545bd0a9fbb20649837db333a8d945ab18cf8f6e70564368c4810b4ec66b59ac'

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
