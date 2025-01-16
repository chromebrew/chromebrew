require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.3' # Do not use @_ver here, it will break the installer.
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag version

  depends_on 'glibc' # R

  def self.build
    system 'mold', '-run', './build.sh'
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin", CREW_DEST_LIB_PREFIX, File.join(CREW_DEST_DIR, "#{CREW_LIB_PATH}/lib")]

    Dir.chdir('builddir') do
      FileUtils.install 'crew_mvdir.so', File.join(CREW_DEST_DIR, "#{CREW_LIB_PATH}/lib"), mode: 0o755
      FileUtils.install 'crew-mvdir.so.1', "#{CREW_DEST_LIB_PREFIX}/crew-mvdir.so.1", mode: 0o755
      FileUtils.install 'crew-mvdir', "#{CREW_DEST_PREFIX}/bin/crew-mvdir", mode: 0o755
    end
  end
end
