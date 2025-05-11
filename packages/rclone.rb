require 'package'

class Rclone < Package
  description 'Rclone is a command-line program to manage files on cloud storage.'
  homepage 'https://rclone.org/'
  version '1.69.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
     armv7l: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
       i686: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-386.zip",
     x86_64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-amd64.zip"
  })
  source_sha256({
    aarch64: '75bb29f677abe5eafd5c6f905c49dd6985a3007c1e7b3051f916694d04e67301',
     armv7l: '75bb29f677abe5eafd5c6f905c49dd6985a3007c1e7b3051f916694d04e67301',
       i686: '9768b667089223bc2724715da31e631f9f37ae962fde35fcaca7649dd3480e8c',
     x86_64: '14aaed7163df57894c96f8aca94757f19065f9cb3cb8a84ff9c33234271e1d69'
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
