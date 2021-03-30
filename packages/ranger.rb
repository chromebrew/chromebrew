require 'package'

class Ranger < Package
  description 'A VIM-inspired filemanager for the console.'
  homepage 'http://ranger.nongnu.org/'
  version '1.8.1-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/ranger/ranger/archive/v1.8.1.tar.gz'
  source_sha256 'ab0e32159cde196df4ff14e9c516aaf8ac2db79e3fdee17e59f327d677a96949'

  depends_on 'less'
  depends_on 'ncursesw'
  depends_on 'python27'

  def self.build
   system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
