require 'package'

class Meld < Package
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  version '3.22.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/meld/-/archive/3.22.0/meld-3.22.0.tar.gz'
  source_sha256 '6332dda01925a2ee367b4b2c50da9a89e040b6656f6643c4aae037c20690a8a2'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.cp_r ".", "#{CREW_DEST_PREFIX}/share/meld"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/meld/bin/meld", "#{CREW_DEST_PREFIX}/bin", force: true
  end

end