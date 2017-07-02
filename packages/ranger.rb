require 'package'

class Ranger < Package # the name of the package
  description 'A VIM-inspired filemanager for the console.'
  homepage 'http://ranger.nongnu.org/'
  version '1.8.1' # the current version of the package
  source_url 'https://github.com/ranger/ranger/archive/v1.8.1.tar.gz' # the source files for the package
  source_sha256 'ab0e32159cde196df4ff14e9c516aaf8ac2db79e3fdee17e59f327d677a96949'

  depends_on 'less'
  depends_on 'ncurses'
  depends_on 'python'

  def self.build
   system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
end
