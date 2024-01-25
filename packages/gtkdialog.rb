require 'package'

class Gtkdialog < Package
  description 'Gtkdialog is a small utility for fast and easy GUI building.'
  homepage 'https://code.google.com/archive/p/gtkdialog/'
  version '0.8.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/gtkdialog/gtkdialog-0.8.3.tar.gz'
  source_sha256 'ff89d2d7f1e6488e5df5f895716ac1d4198c2467a2a5dc1f51ab408a2faec38e'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '8185be58027fe00733c033561df5376f5e41f59d9966ca70a7500cf99c56c444',
     armv7l: '8185be58027fe00733c033561df5376f5e41f59d9966ca70a7500cf99c56c444',
       i686: '0ee37eac4701018f42ca5c68235c0f076d4d9e2974bbbb0cb759a07a1df97f9d',
     x86_64: 'c83761ad0523adea05546fea20352a9133e362aefd7ea74737e2e4099b783fa0'
  })

  depends_on 'gtk2'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
