require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.28.33'
  license 'MPL-2'
  compatibility 'x86_64'
  source_url "https://github.com/brave/brave-browser/releases/download/v#{version}/brave-browser-nightly-#{version}-linux-amd64.zip"
  source_sha256 'd0d9e55f0815561091f6606d89ab5d44d8a6a9fe9ef462be9aca87a35b0b25ab'

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
