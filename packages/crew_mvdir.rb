require 'package'

class Crew_mvdir < Package
  description 'Alternative for "rsync --remove-source-files dir1/ dir2/", with faster speed'
  homepage 'https://chromebrew.github.io'
  version '0.1'
  compatibility 'all'
  license 'GPL-3'

  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag 'ca2bec1fcf76394387a880f1745e57393b7a63c2'

  binary_url ({
    aarch64: 'https://github.com/chromebrew/crew-mvdir/releases/download/0.1/crew_mvdir-0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://github.com/chromebrew/crew-mvdir/releases/download/0.1/crew_mvdir-0.1-chromeos-armv7l.tar.zst',
       i686: 'https://github.com/chromebrew/crew-mvdir/releases/download/0.1/crew_mvdir-0.1-chromeos-i686.tar.zst',
     x86_64: 'https://github.com/chromebrew/crew-mvdir/releases/download/0.1/crew_mvdir-0.1-chromeos-x86_64.tar.zst'
  })

  binary_sha256 ({
    aarch64: '02c2e0a70b1ebf403a02fdb8affec4ac4b9ab1f6e8b0b99898077bbcd2d8806f',
     armv7l: '02c2e0a70b1ebf403a02fdb8affec4ac4b9ab1f6e8b0b99898077bbcd2d8806f',
       i686: '2ec5fd0c56e9b771a618c0e3c2795ec4d27b151836a72e9fa307d30195ba9b4e',
     x86_64: 'b026992a3fc4b801d0799a117eabe1f725de8986a11d3c3f216823def9acd43d'
  })

  def self.build
    system "mold -run cc -static #{CREW_COMMON_FLAGS} crew-mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end