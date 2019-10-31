require 'package'

class Openjpeg < Package
  description 'OpenJPEG is an open-source JPEG 2000 codec written in C language.'
  homepage 'https://github.com/uclouvain/openjpeg/'
  version '2.3.1'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.3.1.tar.gz'
  source_sha256 '63f5a4713ecafc86de51bfad89cc07bb788e9bba24ebbf0c4ca637621aadb6a9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir("builddir") do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DOPENJPEG_INSTALL_LIB_DIR=#{CREW_LIB_PREFIX}",
             "-DCMAKE_BUILD_TYPE=Release",
             ".."
      system 'make'
    end
  end

  def self.install
    Dir.chdir('builddir') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
