require 'package'

class Rclone < Package
  description 'Rclone is a command-line program to manage files on cloud storage.'
  homepage 'https://rclone.org/'
  version '1.73.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
     armv7l: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
       i686: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-386.zip",
     x86_64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-amd64.zip"
  })
  source_sha256({
    aarch64: '7f1094e0528dda0ffe5b1bade42f50bd6b377d5cb00fea3d6cbc700a27a0f4cf',
     armv7l: '7f1094e0528dda0ffe5b1bade42f50bd6b377d5cb00fea3d6cbc700a27a0f4cf',
       i686: '4a770bfa2ec438d32f80863039c9a036cf87ab54bf95dd201ce942660a1b9056',
     x86_64: '00a1d8cb85552b7b07bb0416559b2e78fcf9c6926662a52682d81b5f20c90535'
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
