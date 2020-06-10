require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program'
  homepage 'http://mypaint.org/'
  version '1.2.1'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint/releases/download/v1.2.1/mypaint-1.2.1.tar.xz'
  source_sha256 'ed2349382f6a0c583d7defae06427e97ac7d14acb77b9e2c0fc7171ddd96d3c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint-1.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint-1.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint-1.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint-1.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34fa83b9be46e7bb03e914abe51abe7e17da0d7bf6967c8ff2c77413f8edcab2',
     armv7l: '34fa83b9be46e7bb03e914abe51abe7e17da0d7bf6967c8ff2c77413f8edcab2',
       i686: '03fb94655a4fe7876ec7f9c3b86adc7e95cd43cc4263a505b5541649f4407d66',
     x86_64: 'a32e94eb92824d65544c35d09ef5d3e9d69b5ce504a820a46bd2ea48471cd125',
  })

  depends_on 'scons' => :build
  depends_on 'mypaint_brushes'
  depends_on 'pygobject'
  depends_on 'librsvg'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    system 'pip install numpy'
    system "echo '#!/bin/bash' > mypaint.sh"
    system "echo 'GDK_BACKEND=x11' >> mypaint.sh"
    system "echo 'gdk-pixbuf-query-loaders --update-cache' >> mypaint.sh"
    system "echo '#{CREW_PREFIX}/bin/mypaint.run \"\$@\"' >> mypaint.sh"
    system 'scons'
  end

  def self.install
    system "scons", "prefix=#{CREW_DEST_PREFIX}", "install"
    system 'pip uninstall numpy -y'
    system "pip install numpy --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/mypaint"
    FileUtils.touch "#{CREW_DEST_HOME}/.config/mypaint/accelmap.conf"
    FileUtils.touch "#{CREW_DEST_HOME}/.config/mypaint/settings.json"
    FileUtils.rm "#{CREW_DEST_PREFIX}/lib/pkgconfig/libmypaint.pc"
    FileUtils.rm Dir.glob("#{CREW_DEST_PREFIX}/include/libmypaint/mypaint-*.h")
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/mypaint", "#{CREW_DEST_PREFIX}/bin/mypaint.run"
    FileUtils.install 'mypaint.sh', "#{CREW_DEST_PREFIX}/bin/mypaint", :mode => 0755
  end
end
