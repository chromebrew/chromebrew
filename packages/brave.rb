require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.13.17'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/brave/brave-browser/releases/download/v1.13.17/brave-v1.13.17-linux-x64.zip'
    source_sha256 '4f2ebc2e2bcca6c594527542517381f689352b329774a6b7853535fb7fa2ff66'
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
