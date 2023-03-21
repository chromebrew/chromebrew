require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.2'
  compatibility 'all'
  license 'GPL-3'

  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag version

  no_zstd

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2_armv7l/crew_mvdir-0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2_armv7l/crew_mvdir-0.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2_i686/crew_mvdir-0.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2_x86_64/crew_mvdir-0.2-chromeos-x86_64.tar.xz'
  })

  binary_sha256({
    aarch64: 'd8a85c966d4769f7d89f9c24fa6d681bdefcff6922649eedfb697c6febe12d27',
     armv7l: 'd8a85c966d4769f7d89f9c24fa6d681bdefcff6922649eedfb697c6febe12d27',
       i686: '5b9657fae8a361678b3a868d486819cf7b3258ba6d4734d20f9a0ac8e9a5ad9b',
     x86_64: 'd02fa43e4f44e739222b8bd04c12fc0b479cc9968a904781d7fc306172786c81'
  })

  def self.build
    system "mold -run cc -static #{CREW_COMMON_FLAGS} crew-mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end
