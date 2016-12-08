require 'package'

class Pkg-config < Package
  version '29.1'
  source_url 'https://pkg-config.freedesktop.org/releases/pkg-config-0.29.1.tar.gz'
  source_sha1 '271ce928f6d673cc16cbced2bfd14a5f2e5d3d37'

  depends_on 'buildessential'

  def self.build
    system "configure --prefix=/usr/local --with-internal-glib --disable-host-tool"
    system "make"
  end

  def self.install
    system "make  install"
    #remove the man pages we couldn't install
  end
end
