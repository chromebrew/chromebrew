require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.44.1'
  compatibility 'all'
  source_url 'https://gitlab.com/graphviz/graphviz/-/archive/2.44.1/graphviz-2.44.1.tar.bz2'
  source_sha256 '0f8f3fbeaddd474e0a270dc9bb0e247a1ae4284ae35125af4adceffae5c7ae9b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'da98580f38a3061a10b951562da06f0802dc7524e7d17bbc1b33f57f6913a441',
     armv7l: 'da98580f38a3061a10b951562da06f0802dc7524e7d17bbc1b33f57f6913a441',
       i686: '3178c12127d2256d6859975726039c1d81ae3a53f07346dd6d2b1d457889e3e4',
     x86_64: '42842a1c3fc77efe32ee82cea9edd29c5024019053103347a4d4ff9da5d6fd2f',
  })

  depends_on 'libgd'
  depends_on 'pango'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DGLIBCONFIG_INCLUDE_DIR=#{CREW_LIB_PREFIX}/glib-2.0/include",
             "-DCMAKE_C_FLAGS='-I#{CREW_PREFIX}/include/harfbuzz'",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir CREW_DEST_PREFIX do
      FileUtils.mv 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end
end
