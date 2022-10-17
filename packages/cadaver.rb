require 'package'

class Cadaver < Package
  description 'cadaver is a command-line WebDAV client for Unix. It supports file upload, download, on-screen display, namespace operations (move/copy), collection creation and deletion, and locking operations.'
  homepage 'http://www.webdav.org/cadaver/'
  version '0.23.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://www.webdav.org/cadaver/cadaver-0.23.3.tar.gz'
  source_sha256 'fd4ce68a3230ba459a92bcb747fc6afa91e46d803c1d5ffe964b661793c13fca'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cadaver/0.23.3_armv7l/cadaver-0.23.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cadaver/0.23.3_armv7l/cadaver-0.23.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cadaver/0.23.3_i686/cadaver-0.23.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cadaver/0.23.3_x86_64/cadaver-0.23.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd9a7268a76a9c4f3968b27e3c90d281f8f1b10a77d2ffd1baea583747a55ccd3',
     armv7l: 'd9a7268a76a9c4f3968b27e3c90d281f8f1b10a77d2ffd1baea583747a55ccd3',
       i686: '2c87f25d8cddc458250816f2cd6eb9a65ea7c59f5ab1c2cd50a3bca58ef6910f',
     x86_64: 'db2900a257601dbdaae05477c7eecfda2cf6ed8e7e91e42cedf0cd59887aa19c'
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
