require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.2-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag '0.2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-1_armv7l/crew_mvdir-0.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-1_armv7l/crew_mvdir-0.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-1_i686/crew_mvdir-0.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-1_x86_64/crew_mvdir-0.2-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9ff299429cf50479d2cdfcade11603819797c9e10fd1d5415acbede7a04caf60',
     armv7l: '9ff299429cf50479d2cdfcade11603819797c9e10fd1d5415acbede7a04caf60',
       i686: '7a8b93d1711e96b4251c79f8e374ab331963f4948886c098895c7d8b11ed4f93',
     x86_64: '6fa2c5216648703eb85caf927253d87b1a5bc367511e802b23f55c68e13b53e7'
  })

  no_zstd

  def self.build
    system "mold -run cc -static #{CREW_COMMON_FLAGS} crew-mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end
