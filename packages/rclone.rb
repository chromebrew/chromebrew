require 'package'

class Rclone < Package
  description 'Rclone is a command-line program to manage files on cloud storage.'
  homepage 'https://rclone.org/'
  version '1.73.5'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
     armv7l: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-arm-v7.zip",
       i686: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-386.zip",
     x86_64: "https://github.com/rclone/rclone/releases/download/v#{version}/rclone-v#{version}-linux-amd64.zip"
  })
  source_sha256({
    aarch64: '9dbb4d6aaf3c7a8ca5cec5dfc865269824133aa562811442335a7aba102e4c46',
     armv7l: '9dbb4d6aaf3c7a8ca5cec5dfc865269824133aa562811442335a7aba102e4c46',
       i686: '1479619fa2c41f7e3428ac7da29d4fc3e4220ead0ac44cd50897e4f90370beae',
     x86_64: '932cf4b7484de74d82b4875488e0009469fd21f9904673385184520fe11a1bf0'
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
