require 'package'

class Charm < Package
  description 'Charm is a full-featured, cross-platfom blogging client for LiveJournal, Atom (Movable Type, Blogger), and MetaWeb (WordPress).'
  homepage 'http://ljcharm.sourceforge.net/'
  version '1.9.2'
  license 'charm'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/ljcharm/charm/charm-1.9.2/charm-1.9.2.tar.gz'
  source_sha256 'ae2d536303e770ceb002f69c1e71f6a8532c8d5dd075d2f5c1bf09ad02c3c015'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
    system "install -Dm644 sample.charmrc #{CREW_DEST_HOME}/.charmrc"
  end

  def self.postinstall
    puts
    puts "To configure, edit $HOME/.charmrc".lightblue
    puts
  end
end
