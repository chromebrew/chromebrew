require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.github.io/'
  version '2.2.4'
  source_url 'https://github.com/libgd/libgd/archive/gd-2.2.4.tar.gz'
  source_sha1 '630daec16fe06e4e916fd0fa8499c8fa5c0dcbca'

  depends_on 'cmake'
  depends_on 'libpng'

  def self.build
    FileUtils.mkdir('build')
    FileUtils.cd('build') do
      system "cmake -DCMAKE_INCLUDE_PATH=/usr/local/include -DCMAKE_INSTALL_PREFIX=/usr/local .."
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
