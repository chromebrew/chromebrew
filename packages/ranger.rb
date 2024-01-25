require 'package'

class Ranger < Package
  description 'A VIM-inspired filemanager for the console.'
  homepage 'http://ranger.nongnu.org/'
  version '1.8.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/ranger/ranger/archive/v1.8.1.tar.gz'
  source_sha256 'ab0e32159cde196df4ff14e9c516aaf8ac2db79e3fdee17e59f327d677a96949'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '7e254e34970e1edf6b433e2fafa8bce85597b91000a2cd1e18a1863900732690',
     armv7l: '7e254e34970e1edf6b433e2fafa8bce85597b91000a2cd1e18a1863900732690',
       i686: '81df73eb3a29c5e5ec0ff3a4ff0e054dfb5bb9e619e0ffaa3681b84939d3397a',
     x86_64: '61ded76a93aa9206d72a2618732677990706ffe3666498fe3705a153ec40493e'
  })

  depends_on 'less'
  depends_on 'ncurses'
  depends_on 'python2'

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
