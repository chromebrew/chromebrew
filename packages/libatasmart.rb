require 'package'

class Libatasmart < Package
  description 'LIBATASMART ATA S.M.A.R.T. Reading and Parsing Library'
  homepage 'http://git.0pointer.net/libatasmart.git/'
  version '0.19'    
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'http://git.0pointer.net/libatasmart.git/'
  git_hashtag "v#{version}"
  git_branch 'master'

  def self.build
    system "./autogen.sh"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
