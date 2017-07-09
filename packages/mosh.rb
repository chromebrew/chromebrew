require 'package'

class Mosh < Package
  description 'Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.'
  homepage 'https://mosh.org/'
  version '1.3.2'
  source_url 'https://mosh.org/mosh-1.3.2.tar.gz'
  source_sha256 'da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/mosh-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/mosh-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/mosh-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/mosh-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3d73351c544564df8129057bd2004c77259d9a4c86edb31abae929a99fa4d381',
     armv7l: '3d73351c544564df8129057bd2004c77259d9a4c86edb31abae929a99fa4d381',
       i686: '33b8add3d09107e5dfe7b07c1a8a7972e04e1e5cb772a96f8f465a079184a901',
     x86_64: '7644ad75af42f77b989c0e0d8513a1d9635a74ca9bf2953abc422d643fa27052',
  })

  depends_on 'protobuf'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
