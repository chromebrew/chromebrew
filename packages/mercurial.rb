require 'package'

class Mercurial < Package
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '5.7.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.mercurial-scm.org/release/mercurial-5.7.1.tar.gz'
  source_sha256 'cb5139144ccb2ef648f36963c8606d47dea1cb0e22aa2c055d6f860ce3fde7b0'

  depends_on 'python3'
  depends_on 'gettext'
  depends_on 'py3_docutils' => :build


  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", 'all'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
