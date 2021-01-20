require 'package'

class Papirus_icon_theme < Package
  description 'SVG icon theme for Linux, based on Paper Icon Set'
  homepage 'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme'
  version '20200801'
  compatibility 'all'
  source_url 'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/20200801.tar.gz'
  source_sha256 '30c1f537b8fd5c4e5991fcd96d62cf2119a3a844b6e8fc55a4a08841b49137fd'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons/"
    FileUtils.cp_r Dir.glob('*Papirus*'), "#{CREW_DEST_PREFIX}/share/icons/"
  end
end
