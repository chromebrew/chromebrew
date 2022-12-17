require 'package'

class Crew_mvdir < Package
  description 'Alternative for "mv dir1/* dir2", with ability to override conflict files in destination'
  homepage 'https://chromebrew.github.io'
  version '0.1'
  compatibility 'all'
  license 'GPL-3'

  source_url 'https://github.com/supechicken/chromebrew/raw/master/src/mvdir.c'
  source_sha256 'SKIP'

  def self.build
    system "mold -run cc #{CREW_COMMON_FLAGS} mvdir.c crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end