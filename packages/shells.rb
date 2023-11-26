require 'package'

class Shells < Package
  description 'Launch your Shells™ virtual desktop'
  homepage 'https://www.shells.com/'
  version '0.2b'
  license 'Proprietary'
  compatibility 'x86_64'
  source_url 'https://static.atonline.net/download/cswvf-5htgl5-77xz-glna-lowp-45nddony/shells-go-debian-buster-0.2b.tar.bz2'
  source_sha256 '6d1a8267056c5c372f2bc1918e022f618006e2bcec1869cf2bfbb7d33e8dbc84'

  depends_on 'xcb_util_wm'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'shells-go', "#{CREW_DEST_PREFIX}/bin/shells"
  end

  def self.postinstall
    puts "\nType 'shells' to get started.\n".lightblue
  end
end
