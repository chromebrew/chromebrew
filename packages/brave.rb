require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.12.53'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/brave/brave-browser/releases/download/v1.12.53/brave-v1.12.53-linux-x64.zip'
    source_sha256 'a9355a56bc4df692bcff8045cc938d6c61c1c2a480e1aed907553e209b25c09b'
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
