require 'package'

class Libspectre < Package
  description 'Small library for rendering Postscript documents'
  homepage 'https://www.freedesktop.org/wiki/Software/libspectre/'
  version '0.2.10'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://libspectre.freedesktop.org/releases/libspectre-0.2.10.tar.gz'
  source_sha256 'cf60b2a80f6bfc9a6b110e18f08309040ceaa755210bf94c465a969da7524d07'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libspectre/0.2.10_armv7l/libspectre-0.2.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libspectre/0.2.10_armv7l/libspectre-0.2.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libspectre/0.2.10_i686/libspectre-0.2.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libspectre/0.2.10_x86_64/libspectre-0.2.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd223b14ea07212f13a354c3bf35325c0294e6576c53508cd98b4ef5c678dc89e',
     armv7l: 'd223b14ea07212f13a354c3bf35325c0294e6576c53508cd98b4ef5c678dc89e',
       i686: 'db07ea04a737c42ad4a2f8ca7555bbd493bdf20489670b37f2a983d14b5ee843',
     x86_64: 'c919a94a979fc362af267b647412ff6f8d58d1bbc39de6250683129f9a08a4d8'
  })

  depends_on 'ghostscript' # = libgs
  depends_on 'libjpeg'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
