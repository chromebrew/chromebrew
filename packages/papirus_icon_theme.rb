require 'package'

class Papirus_icon_theme < Package
  description 'SVG icon theme for Linux, based on Paper Icon Set'
  homepage 'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme'
  version '20250501'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git'
  git_hashtag version

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons/"
    FileUtils.cp_r Dir['*Papirus*'], "#{CREW_DEST_PREFIX}/share/icons/"
  end
end
