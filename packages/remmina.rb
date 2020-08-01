require 'package'

class Remmina < Package
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.2.30'
  compatibility 'all'
  source_url 'https://github.com/FreeRDP/Remmina/archive/v1.2.30.tar.gz'
  source_sha256 'cf9528709fe531830f949bc4adcc806b86606942e7ee552fd6177fcd81d4d33f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/remmina-1.2.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/remmina-1.2.30-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/remmina-1.2.30-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/remmina-1.2.30-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ad40d6de21df5ae704d03140f9b0e1ff4c1640f843655d640ea974a8834e14a',
     armv7l: '5ad40d6de21df5ae704d03140f9b0e1ff4c1640f843655d640ea974a8834e14a',
       i686: '645cf56246561bfb177bc8b6b64de3fd8dfa1cbfcb30a4a132b24fff4dd9195e',
     x86_64: '1b50f77517a34bfb2964e3183c60d3ac9d97fa628694771536cbeda1e82f7898',
  })

  depends_on 'avahi'
  depends_on 'freerdp'
  depends_on 'gtkvte'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'libvncserver'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DLIBSSH_THREADS_LIBRARY=#{CREW_PREFIX}/include/libssh",
             "-DCMAKE_C_FLAGS='-I#{CREW_PREFIX}/include/harfbuzz'",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DWITH_APPINDICATOR=OFF',
             '-DWITH_TELEPATHY=OFF',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
