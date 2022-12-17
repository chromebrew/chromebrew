require 'package'

class Crew_mvdir < Package
  description 'Alternative for "rsync --remove-source-files dir1/ dir2/", with faster speed'
  homepage 'https://chromebrew.github.io'
  version '0.1'
  compatibility 'all'
  license 'GPL-3'

  source_url 'https://github.com/supechicken/chromebrew/raw/use_rename/src/mvdir.c'
  source_sha256 'SKIP'

  no_shrink # upx: CantPackException: bad DT_GNU_HASH (1+ max_bucket)=0x1 < symbias=0x14

  def self.build
    system "mold -run cc #{CREW_COMMON_FLAGS} mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end