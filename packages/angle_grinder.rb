require 'package'

class Angle_grinder < Package
  description 'Slice and dice logs on the command line'
  homepage 'https://github.com/rcoh/angle-grinder'
  version '0.19.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/rcoh/angle-grinder/releases/download/v0.19.2/agrind-x86_64-unknown-linux-gnu.tar.gz'
  source_sha256 '8f81734e068fe8846dd706d38ecb5eb9d5f11a420e68ce585065a971ca54b5be'

  no_compile_needed

  def self.install
    FileUtils.install 'agrind', "#{CREW_DEST_PREFIX}/bin/agrind", mode: 0o755
  end
end
