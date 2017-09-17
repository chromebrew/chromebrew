require 'package'

class Libwayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.32.92'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.13.92.tar.xz'
  source_sha256 '1253392261ccb44b312ec0486457c28d24c2f9d8940162181ed5ddc568b8f858'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.32.92-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.32.92-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.32.92-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.32.92-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'be74f12aa6e33fd0edb6fabc6cf495b881ce47517dec861c7461dd017a29cfd0',
     armv7l: 'be74f12aa6e33fd0edb6fabc6cf495b881ce47517dec861c7461dd017a29cfd0',
       i686: 'f6bab1538ee845e1674f4fc7c72ce4d8e092ac4c13bcc0eb8af45cdc0eb3d34f',
     x86_64: '91163ec6410bd211d3b0dc8b514da2428e45c102a79255012380705bc709a5ec',
  })

  depends_on 'libffi'
  depends_on 'expat'
  depends_on 'libxml2'

  def self.build
    system "./configure --disable-documentation"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
