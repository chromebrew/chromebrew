require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.37.111'
  license 'MPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/brave/brave-browser/releases/download/v1.37.111/brave-browser-1.37.111-linux-amd64.zip'
  source_sha256 '05470901e9f19bd45cbb54008f0bf53b01360d0f4340c52ff805f3454c3d3da7'

  no_compile_needed

  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
    FileUtils.ln_s CREW_LIB_PREFIX, "#{CREW_DEST_PREFIX}/share/#{ARCH_LIB}"
  end
end
