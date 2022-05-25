require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.2-2' # Do not use @_ver here, it will break the installer.
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag '0.2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-2_armv7l/crew_mvdir-0.2-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-2_armv7l/crew_mvdir-0.2-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-2_i686/crew_mvdir-0.2-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_mvdir/0.2-2_x86_64/crew_mvdir-0.2-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c6738e9eb4d6771c9349cbab24c5a0ff0802919e08931c979558bc0f2c33d719',
     armv7l: 'c6738e9eb4d6771c9349cbab24c5a0ff0802919e08931c979558bc0f2c33d719',
       i686: '94b576672248ce488bbc8c44f8ff83a5ef862264cd115ec5dea641d7ed2a740a',
     x86_64: '7e8c79bded2e1c3d07c8d25c9773a9a8ecb23cd2e20169ff26ec6c09e9eeae41'
  })

  depends_on 'glibc' # R

  def self.build
    system "mold -run cc #{CREW_COMMON_FLAGS} crew-mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end
