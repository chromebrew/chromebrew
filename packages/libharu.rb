require 'package'

class Libharu < Package
  description 'libHaru is a free, cross platform, open source library for generating PDF files.'
  homepage 'http://libharu.org/'
  version '2.3.0'
  source_url 'https://github.com/libharu/libharu/archive/RELEASE_2_3_0.tar.gz'
  source_sha256 '8f9e68cc5d5f7d53d1bc61a1ed876add1faf4f91070dbc360d8b259f46d9a4d2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libharu-2.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libharu-2.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libharu-2.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libharu-2.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '565b8d263ffbb640aa3c928a1cd563b809f0ed91557ff8b509713387926e5921',
     armv7l: '565b8d263ffbb640aa3c928a1cd563b809f0ed91557ff8b509713387926e5921',
       i686: 'bf59630d01e74a2e57bf0f68ad6d27c988081a1b428c9b657aba192a49bf5ee1',
     x86_64: 'c14377ac7ffb373b6f7e911333fed79fb879993c512e1875224defba894b7e31',
  })

  depends_on 'libpng'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      if ARCH == 'x86_64'
        FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
        FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/lib/*"), "#{CREW_DEST_LIB_PREFIX}"
      end
      FileUtils.rm_f "#{CREW_DEST_PREFIX}/INSTALL"
      FileUtils.rm_f "#{CREW_DEST_PREFIX}/README"
    end
  end
end
