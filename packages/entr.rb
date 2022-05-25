require 'package'

class Entr < Package
  description 'Run arbitrary commands when files change'
  homepage 'http://entrproject.org/'
  version '4.0'
  license 'ISC'
  compatibility 'all'
  source_url 'http://entrproject.org/code/entr-4.0.tar.gz'
  source_sha256 '4ad4fe9108b179199951cfc78a581a8a69602b073dae59bcae4b810f6e1f6c8b'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/entr/4.0_armv7l/entr-4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/entr/4.0_armv7l/entr-4.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/entr/4.0_i686/entr-4.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/entr/4.0_x86_64/entr-4.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0245397ddc6c63266cb85893650b4e3f30ba9ba433c3bb6ce4f1e026b31d7f41',
     armv7l: '0245397ddc6c63266cb85893650b4e3f30ba9ba433c3bb6ce4f1e026b31d7f41',
       i686: '74adb77a26cc198d011f0e57f8311c41cd34b91243cb3456269f71ef1e2be273',
     x86_64: '6efb1d26f5472c55ac84d32807bae88c444df2bdb4128a9e2d6ba2349f60e591'
  })

  def self.build
    system 'cp Makefile.linux Makefile'
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
