require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '81.1.10.36'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/brave/brave-browser/releases/download/v1.10.36/brave-v1.10.36-linux-x64.zip'
    source_sha256 'b8e5de4ffd454b171a10e9be260523d414b32e45c05524b2bd8b4b9a96640251'
  end

  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
  end
end
