require 'package'

class Qtfm < Package
  description 'Lightweight desktop independent Qt file manager'
  homepage 'https://qtfm.eu/'
  version '6.1.9'
  source_url 'https://github.com/rodlie/qtfm/archive/6.1.9.tar.gz'
  source_sha256 'ff7ab3244999653fd7f8fb9dc1bd06a599d18faaa7c17b1bc4e2d8830ba9feb5'

  binary_url ({
    x86_64: 'file:///home/chronos/user/Downloads/qtfm-6.1.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    x86_64: '4f2c3627f10189a5b801e05b048039b6ee7884f211c655694d96ad1351e240e1'
  })

  depends_on 'qtbase'
  depends_on 'imagemagick7'
  depends_on 'ffmpeg'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'qmake',
             "PREFIX=#{CREW_PREFIX}",
             "LIBDIR=#{CREW_LIB_PREFIX}",
             'CONFIG+=with_includes',
             'CONFIG+=with_magick',
             'CONFIG+=with_ffmpeg',
             'CONFIG+=sharedlib',
             '..'
      system 'make', "-j#{CREW_NPROC}"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    end
  end
end
