require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.15.4'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/brave/brave-browser/releases/download/v1.15.4/brave-v1.15.4-linux-x64.zip'
    source_sha256 '072f32c7546595d3839c9bcf07c4e3c44a14027688a05f18724cf5afbb0c75c5'
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
