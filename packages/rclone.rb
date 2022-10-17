require 'package'

class Rclone < Package
  description 'Rclone is a command-line program to manage files on cloud storage.'
  homepage 'https://rclone.org/'
  version '1.59.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/rclone/rclone/releases/download/v1.59.2/rclone-v1.59.2-linux-arm-v7.zip',
     armv7l: 'https://github.com/rclone/rclone/releases/download/v1.59.2/rclone-v1.59.2-linux-arm-v7.zip',
       i686: 'https://github.com/rclone/rclone/releases/download/v1.59.2/rclone-v1.59.2-linux-386.zip',
     x86_64: 'https://github.com/rclone/rclone/releases/download/v1.59.2/rclone-v1.59.2-linux-amd64.zip'
  })
  source_sha256({
    aarch64: 'da638646b76966fe9ba2ab4a49aa9fa74324e58d5abaec2ebf9657069a905699',
     armv7l: 'da638646b76966fe9ba2ab4a49aa9fa74324e58d5abaec2ebf9657069a905699',
       i686: '27f59f2bcc5b8938d0c3d2d080e15ee67ce8c9a44147b52da52d1183afdd8ce7',
     x86_64: '81e7be456369f5957713463e3624023e9159c1cae756e807937046ebc9394383'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.install 'rclone', "#{CREW_DEST_PREFIX}/bin/rclone", mode: 0o755
    FileUtils.install 'rclone.1', "#{CREW_DEST_MAN_PREFIX}/man1/rclone.1", mode: 0o644
  end
end
