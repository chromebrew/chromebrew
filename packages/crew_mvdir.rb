require 'package'

class Crew_mvdir < Package
  description 'Alternative for "rsync --remove-source-files dir1/ dir2/", with faster speed'
  homepage 'https://chromebrew.github.io'
  version '0.1'
  compatibility 'all'
  license 'GPL-3'

  source_url 'https://github.com/chromebrew/chromebrew/raw/master/src/mvdir.c' # we cannot get the commit before #7751 merged
  source_sha256 '0b7e3eae6d13c3e46e9ebd0c31eae5551e5c7640d2accaa1b5f855c8dedb8a21'

  no_shrink # upx: CantPackException: bad DT_GNU_HASH (1+ max_bucket)=0x1 < symbias=0x14

  def self.build
    system "mold -run cc #{CREW_COMMON_FLAGS} mvdir.c -o crew-mvdir"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
  end
end