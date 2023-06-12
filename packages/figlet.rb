require 'package'

class Figlet < Package
  description 'FIGlet is a program for making large letters out of ordinary text.'
  homepage 'http://www.figlet.org/'
  version '2.2.5-a565ae1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/cmatsuoka/figlet.git'
  git_hashtag 'a565ae1e8f8254044219260dda2a6b51984930dc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/figlet/2.2.5-a565ae1_armv7l/figlet-2.2.5-a565ae1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/figlet/2.2.5-a565ae1_armv7l/figlet-2.2.5-a565ae1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/figlet/2.2.5-a565ae1_i686/figlet-2.2.5-a565ae1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/figlet/2.2.5-a565ae1_x86_64/figlet-2.2.5-a565ae1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '49d91067c62e2bf4d74047211638a4319c3190c82b3636709cc055d011a26665',
     armv7l: '49d91067c62e2bf4d74047211638a4319c3190c82b3636709cc055d011a26665',
       i686: 'f50377baacc1c0e7f8c07065837408d4ffbfbeda0ce7d35194f99304ced70914',
     x86_64: 'bf7c55cceb0b1eb05c92e278c7792b3d80c1730edf14238e5382d6bf1f524f56'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
