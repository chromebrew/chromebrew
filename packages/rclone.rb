require 'package'

class Rclone < Package
  description 'Rclone is a command-line program to manage files on cloud storage.'
  homepage 'https://rclone.org/'
  version '1.69.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
     armv7l: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
       i686: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-386.zip",
     x86_64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-amd64.zip"
  })
  source_sha256({
    aarch64: '0fcea9dfaecd7373e90d8a69d50ca1e43a5e9908e91b6ce5bd46b0b843c1596c',
     armv7l: '0fcea9dfaecd7373e90d8a69d50ca1e43a5e9908e91b6ce5bd46b0b843c1596c',
       i686: '8398f08dd40b5f3d90725f711c3deb76e6e696962868bc578329488561325a36',
     x86_64: '231841f8d8029ae6cfca932b601b3b50d0e2c3c2cb9da3166293f1c3eae7d79c'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.install 'rclone', "#{CREW_DEST_PREFIX}/bin/rclone", mode: 0o755
    FileUtils.install 'rclone.1', "#{CREW_DEST_MAN_PREFIX}/man1/rclone.1", mode: 0o644
  end
end
