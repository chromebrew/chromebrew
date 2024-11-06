require 'package'

class Ladspa < Package
  description 'Linux Audio Developer\'s Simple Plugin API'
  homepage 'https://www.ladspa.org/'
  version '1.17'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://www.ladspa.org/download/ladspa_sdk_1.17.tgz'
  source_sha256 '27d24f279e4b81bd17ecbdcc38e4c42991bb388826c0b200067ce0eb59d3da5b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '595b2783890ec41817e5bd269dcdb80c44326b1746d9815e151c9b5554040471',
     armv7l: '595b2783890ec41817e5bd269dcdb80c44326b1746d9815e151c9b5554040471',
       i686: '79594f7df9ba24fbc487285d88531198d8749cb0915744e7a808e2adb79dd93c',
     x86_64: '353b796ab639640a367524a3c24531346d0c9f69aa161807c1346e357cf4325b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libsndfile' # R

  def self.patch
    Dir.chdir('src') do
      system 'sed', '-i', '-e', "s,/usr,$(DESTDIR)#{CREW_PREFIX},g", '-e', "s,lib,#{ARCH_LIB},", 'Makefile'
    end
  end

  def self.build
    Dir.chdir('src') do
      system 'make'
    end
  end

  def self.install
    Dir.chdir('src') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
