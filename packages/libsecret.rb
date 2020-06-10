require 'package'

class Libsecret < Package
  description 'GObject based library for accessing the Secret Service API.'
  homepage 'https://github.com/GNOME/libsecret'
  version '0.18.6'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libsecret/archive/0.18.6.tar.gz'
  source_sha256 'f4fa198d4e131f94d9ec84cfeaf6c124245e7ff3c0af11c76cc35332bfae5585'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.18.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.18.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.18.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.18.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6bf08022d4db47fd7faf57c2fdbfb13ae3d66ccf7ebfa7a36ad6637d70705f3c',
     armv7l: '6bf08022d4db47fd7faf57c2fdbfb13ae3d66ccf7ebfa7a36ad6637d70705f3c',
       i686: 'e72fb2a7ddda1aa4abb22ea521b6e698667d6f1aee5d2fc7774cd25cb8acebe4',
     x86_64: '86dc9e5d3b2b360cb5f3396fcc0a83e3805dfcc877e583bf1a962ebf05d72d6f',
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'libgcrypt' => :build
  depends_on 'vala' => :build

  def self.build
    system './autogen.sh',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-gtk-doc',
           '--disable-gtk-doc-html',
           '--disable-gtk-doc-pdf',
           '--disable-manpages'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
