require 'package'

class Mypaint < Package
  description 'MyPaint is a simple drawing and painting program'
  homepage 'http://mypaint.org/'
  version '2.0.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/mypaint/mypaint/releases/download/v2.0.1/mypaint-2.0.1.tar.xz'
  source_sha256 'f3e437d7cdd5fd28ef6532e8ab6b4b05d842bcdd644f16a0162dad3d8e57bb16'

  depends_on 'scons' => :build
  depends_on 'py3_numpy'
  depends_on 'mypaint_brushes'
  depends_on 'pygobject'
  depends_on 'librsvg'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    @mypaint_sh = <<~EOF
      #!/bin/bash
      GDK_BACKEND=x11' >> mypaint.sh"
      gdk-pixbuf-query-loaders --update-cache'
      #{CREW_PREFIX}/bin/mypaint.elf \"\$@\"'
    EOF
    IO.write("#{CREW_DEST_PREFIX}/bin/mypaint.sh", @mypaint_sh)
    system 'scons'
  end

  def self.install
    system 'scons', "prefix=#{CREW_DEST_PREFIX}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/mypaint", "#{CREW_DEST_PREFIX}/bin/mypaint.elf"
    FileUtils.install 'mypaint.sh', "#{CREW_DEST_PREFIX}/bin/mypaint", :mode => 0755
  end
end
