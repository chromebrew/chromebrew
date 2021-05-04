require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program'
  homepage 'http://mypaint.org/'
  version '1.2.1-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint/releases/download/v1.2.1/mypaint-1.2.1.tar.xz'
  source_sha256 'ed2349382f6a0c583d7defae06427e97ac7d14acb77b9e2c0fc7171ddd96d3c7'

  depends_on 'scons' => :build
  depends_on 'mypaint_brushes'
  depends_on 'pygobject'
  depends_on 'librsvg'
  depends_on 'xdg_base'
  depends_on 'sommelier'
  depends_on 'py3_numpy'

  def self.build
    system "echo '#!/bin/bash' > mypaint.sh"
    system "echo 'GDK_BACKEND=x11' >> mypaint.sh"
    system "echo 'gdk-pixbuf-query-loaders --update-cache' >> mypaint.sh"
    system "echo '#{CREW_PREFIX}/bin/mypaint.run \"\$@\"' >> mypaint.sh"
    system 'scons'
  end

  def self.install
    system "scons", "prefix=#{CREW_DEST_PREFIX}", "install"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/mypaint"
    FileUtils.touch "#{CREW_DEST_HOME}/.config/mypaint/accelmap.conf"
    FileUtils.touch "#{CREW_DEST_HOME}/.config/mypaint/settings.json"
    FileUtils.rm "#{CREW_DEST_PREFIX}/lib/pkgconfig/libmypaint.pc"
    FileUtils.rm Dir.glob("#{CREW_DEST_PREFIX}/include/libmypaint/mypaint-*.h")
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/mypaint", "#{CREW_DEST_PREFIX}/bin/mypaint.run"
    FileUtils.install 'mypaint.sh', "#{CREW_DEST_PREFIX}/bin/mypaint", :mode => 0755
  end
end
