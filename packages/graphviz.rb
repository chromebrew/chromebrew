require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.44.0-1'
  source_url 'https://gitlab.com/graphviz/graphviz/-/archive/2.44.0/graphviz-2.44.0.tar.bz2'
  source_sha256 'eaff61ce05bf8196c596097bab6310fa6e7e96ee908a199a4bc83fbd5e7082d6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.44.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '31608ae44ed6971f1db667f6632884d3339cb6ca23726d37054d6530b5f62a74',
     armv7l: '31608ae44ed6971f1db667f6632884d3339cb6ca23726d37054d6530b5f62a74',
       i686: 'ced8535b2bf48eb70560d7a504919ec7cd961eabd4a1cad74693bdf9fac230da',
     x86_64: '010ce4c07b742c9ee8f59abb3672efb69f524a07315169495849f56f70e91608',
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
    case ARCH
    when 'x86_64'
      Dir.mkdir CREW_DEST_LIB_PREFIX
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv Dir.glob('lib/*'), 'lib64/'
      end
    end
  end
end
