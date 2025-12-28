require 'package'

class Rclone < Package
  description 'Rclone is a command-line program to manage files on cloud storage.'
  homepage 'https://rclone.org/'
  version '1.72.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
     armv7l: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
       i686: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-386.zip",
     x86_64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-amd64.zip"
  })
  source_sha256({
    aarch64: 'cbff78f41ad97b5eedab77f42a2e8ef609a776901c849089a75c7fa35f43142e',
     armv7l: 'cbff78f41ad97b5eedab77f42a2e8ef609a776901c849089a75c7fa35f43142e',
       i686: 'd9bcc34e25b64f639a51e7be77549b2ec20eae70ba9c768104490b17952081d8',
     x86_64: 'b5c9b2fb6ada8a400c5fc5d48cd112dc1adea21a3b73b03857059374dd8a78d0'
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
