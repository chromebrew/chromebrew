require 'package'

class Ag < Package
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.0.0'
  source_url 'https://github.com/ggreer/the_silver_searcher/archive/2.0.0.tar.gz'
  source_sha256 'ff7243863f22ed73eeab6f7a6d17cfff585a7eaa41d5ab3ae4f5d6db97701d5f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ag-2.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ag-2.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/ag-2.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/ag-2.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6035e9e040d74ffe76602e45c5330cfd5237c5bcc12a9e0d80a9ddc67152494',
     armv7l: 'b6035e9e040d74ffe76602e45c5330cfd5237c5bcc12a9e0d80a9ddc67152494',
       i686: 'dae0dcae1d6878f8919d0af87e142038c28df0df295f9bf4fa511ab728ff5070',
     x86_64: 'a12ab1ac7b0904e063e8a736ad77844aadb02a3f5e0b6cc5176eb80c657fa4e4',
  })

  depends_on "autoconf"
  depends_on "automake"
  depends_on "pkgconfig"
  depends_on "pcre"
  depends_on "xzutils"

  def self.build
    system "autoreconf", "-fiv"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end

end
