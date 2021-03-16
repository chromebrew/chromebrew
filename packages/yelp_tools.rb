require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '40.rc'
  compatibility 'all'
  source_url 'https://github.com/GNOME/yelp-tools/archive/40.rc.tar.gz'
  source_sha256 '072420dbbec6a7b5b3647fcfc15c284b02a21220c78ba140d727cd2992500902'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5dca4c043e28eb89a87a56cf4518c9d3e67f6ff0522c52cf7ce3cff38d4c8920',
     armv7l: '5dca4c043e28eb89a87a56cf4518c9d3e67f6ff0522c52cf7ce3cff38d4c8920',
       i686: '8cd244466690065e37ff4c5b2aea2680a506fb70195c30b0bde916b3f70bf3ba',
     x86_64: '57b5663d5fcd6755d35fdf0973be36997cc22129b3d1ca7d2a4e4812d2922b01'
  })

  depends_on 'yelp_xsl'
  depends_on 'libxslt'
  depends_on 'lxml'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
