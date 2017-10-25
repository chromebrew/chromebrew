require 'package'

class Dfc < Package
  description 'dfc displays file system space usage using graphs and colors.'
  homepage 'https://projects.gw-computing.net/projects/dfc'
  version '3.1.1'
  source_url 'https://projects.gw-computing.net/attachments/download/615/dfc-3.1.1.tar.gz'
  source_sha256 '962466e77407dd5be715a41ffc50a54fce758a78831546f03a6bb282e8692e54'

  depends_on 'cmake'
  depends_on 'gettext'

  def self.build
    system "cmake . -DPREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=RELEASE"
  end

  def self.install
    system  "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
