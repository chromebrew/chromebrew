require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.38.109'
  license 'MPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/brave/brave-browser/releases/download/v1.38.109/brave-browser-1.38.109-linux-amd64.zip'
  source_sha256 '9120b7eda8f8b986035d98ec782810b32ffc60e6aea3b2232795721a43731a36'

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
