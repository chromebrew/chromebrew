require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.2'
  compatibility 'all'
  license 'GPL-3'

  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag version

  def self.build
    system "mold -run cc -static #{CREW_COMMON_FLAGS} crew-mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end
