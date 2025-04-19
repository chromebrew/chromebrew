require 'package'

class Angle_grinder < Package
  description 'Slice and dice logs on the command line'
  homepage 'https://github.com/rcoh/angle-grinder'
  version '0.19.6'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/rcoh/angle-grinder/releases/download/v#{version}/agrind-x86_64-unknown-linux-gnu.tar.gz"
  source_sha256 '3c3c3611c5ee86edabddcf5546715fef30e1644e474bd4a29b2eb1f8f074d626'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'agrind', "#{CREW_DEST_PREFIX}/bin/agrind", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'agrind -h' to get started.\n"
  end
end
