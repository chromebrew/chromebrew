require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '40.beta'
  compatibility 'all'
  source_url 'https://github.com/GNOME/yelp-tools/archive/40.beta.tar.gz'
  source_sha256 '57f80c0853a3bb44249e5febe39424876bb08f7c58650133dd5bc1a0b9a40808'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c8f68b2451729b757df1c9638cf96011590bda3964053784a0e70b02f3448df7',
     armv7l: 'c8f68b2451729b757df1c9638cf96011590bda3964053784a0e70b02f3448df7',
       i686: '3a10cfae2a539cd99705fb39b4e3f76fa8d9ffe149e4fa45b8ae23168f1fde7d',
     x86_64: 'cce94aa4c0dfd87c505e1194976fd59eb0c0654f36748fa3fad3ece67e5a1ed1'
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
