require 'package'

class Crew_mvdir < Package
  description 'Faster alternative to "rsync --remove-source-files dir1/ dir2/"'
  homepage 'https://github.com/chromebrew/crew-mvdir'
  version '0.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-mvdir.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4324373576d266422033fb835b4062c691398eb2b4f8ffbf12dc1931656981ae',
     armv7l: '4324373576d266422033fb835b4062c691398eb2b4f8ffbf12dc1931656981ae',
       i686: '5e424ec6654f40a69d57240845c809c73665033bc2a378ecf97ee4dec601d64a',
     x86_64: 'e7bd6d453cf491be2d1170f189ddb4d7aaf8e7d6b126a6cc34b77380dbbad04e'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
