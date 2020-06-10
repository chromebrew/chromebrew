require 'package'

class Sshfs < Package
  description 'A network filesystem client to connect to SSH servers.'
  homepage 'https://github.com/libfuse/sshfs'
  version '2.10'
  compatibility 'all'
  source_url 'https://github.com/libfuse/sshfs/releases/download/sshfs-2.10/sshfs-2.10.tar.gz'
  source_sha256 '70845dde2d70606aa207db5edfe878e266f9c193f1956dd10ba1b7e9a3c8d101'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sshfs-2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sshfs-2.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sshfs-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sshfs-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '22670d1a6127f7c1e7181af517f0e9242cf7f88645a861f80541f8196bdd815f',
     armv7l: '22670d1a6127f7c1e7181af517f0e9242cf7f88645a861f80541f8196bdd815f',
       i686: 'ebd6c89d54f1ec9fca31869ad9a41d0d6c422d648658a1296f4bd31249c7b125',
     x86_64: 'cef0929354e03eb6b82046218aca8b95284d71249288604c4ce41a699daef1f0',
  })

  depends_on 'glib'
  depends_on 'fuse'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
