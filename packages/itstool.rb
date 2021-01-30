require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  version '2.0.6-1'
  compatibility 'all'
  source_url 'https://github.com/itstool/itstool/archive/2.0.6.tar.gz'
  source_sha256 'bda0b08e9a1db885c9d7d1545535e9814dd8931d5b8dd5ab4a47bd769d0130c6'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/itstool-2.0.6-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '765e60cddd633a23262c94f0b9093d3b1ffcfe40eba35ca4b533ef85e2112949',
      armv7l: '765e60cddd633a23262c94f0b9093d3b1ffcfe40eba35ca4b533ef85e2112949',
        i686: '596bacc10fced4176a5d79e50739c02f299a3998398ae635b949a4fb8ad16478',
      x86_64: '64c99cf974fec8958a31b3cc642d93ed68b9458ec7c403e93734e344afc191ed',
  })

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

   def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "pip3 uninstall -y itstool"
    system "pip3 install --upgrade --no-warn-script-location itstool --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end

end
