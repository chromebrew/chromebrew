# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  version '2.3.4'
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{version}.tar.gz"
  source_sha256 '179f9ebe265e67e4ab2c26cad2b7de4b6a77c6c212f966903382869f06be6505'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.4_armv7l/talloc-2.3.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.4_armv7l/talloc-2.3.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.4_i686/talloc-2.3.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/talloc/2.3.4_x86_64/talloc-2.3.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4e8214c3b9f7e072b8ff7d8727673f7a66483ee06ec062cab80f2b8ea1d4173b',
     armv7l: '4e8214c3b9f7e072b8ff7d8727673f7a66483ee06ec062cab80f2b8ea1d4173b',
       i686: '9a4b85aa6ec7afee4b5d3b527a35965870cc2a43c04df9559129b58211baba62',
     x86_64: 'b437d15d5afc458ed6317a420a1cf13b206fb34259b2070f0da5f5d27644475d'
  })

  depends_on 'libbsd'
  depends_on 'libxcrypt'
  depends_on 'docbook_xsl' => :build

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace \
      --enable-talloc-compat1"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
