require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49f18debfacdb14a5c9bebc8537e2cb7415175dc5fca46f49393e79a30df166a',
     armv7l: '49f18debfacdb14a5c9bebc8537e2cb7415175dc5fca46f49393e79a30df166a',
       i686: '446dd4251251aea7ba3461e7f5453909f73dc815e8d422f284b57b4dd1cf7958',
     x86_64: '052256b4db73db3fafdea1d6ab681ec3e513ff648bcf430614423e56ccd31707'
  })

  depends_on 'glibc' # R

  def self.build
    system "cc #{CREW_COMMON_FLAGS} crew-mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end
