require 'package'

class Funny_manpages < Package
  description 'funny unix manpages'
  homepage 'https://github.com/ltworf/funny-manpages'
  @_ver = '2.3'
  version "#{@_ver}-1"
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/ltworf/funny-manpages.git'
  git_hashtag @_ver

  depends_on 'mandb'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man3/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man6/"
    FileUtils.install Dir.glob('man/*.1fun'), "#{CREW_DEST_MAN_PREFIX}/man1", mode: 0o644, verbose: true
    FileUtils.install Dir.glob('man/*.3fun'), "#{CREW_DEST_MAN_PREFIX}/man3", mode: 0o644, verbose: true
    FileUtils.install Dir.glob('man/*.6fun'), "#{CREW_DEST_MAN_PREFIX}/man6", mode: 0o644, verbose: true
    FileUtils.symlink 'grope.1fun', "#{CREW_DEST_MAN_PREFIX}/man1/egrope.1fun", verbose: true
    FileUtils.symlink 'grope.1fun', "#{CREW_DEST_MAN_PREFIX}/man1/fgrope.1fun", verbose: true
  end
end
