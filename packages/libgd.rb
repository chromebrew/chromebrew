require 'package'

class Libgd < Package
  version '2.0.33'
  source_url 'https://github.com/libgd/libgd/archive/GD_2_0_33.tar.gz'
  source_sha1 '489e25f18d3fc9d7f8b0e4889f98f5aa25363c3e'

  def self.build
    FileUtils.cd('src') do
      system "./configure --libdir=/usr/local/lib64/ CC=\"gcc -m64\" CFLAGS=\" -fPIC\""
      system "make"
    end
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
