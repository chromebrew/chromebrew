require 'package'

class Angle_grinder < Package
  description 'Slice and dice logs on the command line'
  homepage 'https://github.com/rcoh/angle-grinder'
  version '0.19.4'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/rcoh/angle-grinder/releases/download/v#{version}/agrind-x86_64-unknown-linux-gnu.tar.gz"
  source_sha256 '2c9472b93e1250545167eacadda0ad1b72f1770208cefa969d1a24ab735c32ee'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'agrind', "#{CREW_DEST_PREFIX}/bin/agrind", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'agrind -h' to get started.\n"
  end
end
