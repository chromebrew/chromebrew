require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.11.48'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/brave/brave-browser/releases/download/v1.11.48/brave-v1.11.48-linux-x64.zip'
    source_sha256 'c1780ec5c4b41e13b2225fd1ed0c7e35af9e3200bf954a91b91c1f0a99cca5d5'
    depends_on 'gtk3'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
  end
end
