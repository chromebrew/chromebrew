require 'package'

class Libconfuse < Package
  description 'Small configuration file parser library for C.'
  homepage 'https://github.com/martinh/libconfuse'
  version '3.2.1'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/martinh/libconfuse/releases/download/v3.2.1/confuse-3.2.1.tar.xz'
  source_sha256 '23c63272baf2ef4e2cbbafad2cf57de7eb81f006ec347c00b954819824add25e'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libconfuse/3.2.1_armv7l/libconfuse-3.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libconfuse/3.2.1_armv7l/libconfuse-3.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libconfuse/3.2.1_i686/libconfuse-3.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libconfuse/3.2.1_x86_64/libconfuse-3.2.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c2bb1d942fe0cfd6545de8165ac1664fea1c4aa13e6d4a5c0f008aa98bc4202e',
     armv7l: 'c2bb1d942fe0cfd6545de8165ac1664fea1c4aa13e6d4a5c0f008aa98bc4202e',
       i686: '43abce4bd584a9953d7598ccfb36180322170f26f74331fc4b237e6abbbec64c',
     x86_64: '697f525ada438cb1662374dc2ec820e2dd0133b339244ced2b56da0f098036e5'
  })

  depends_on 'apr_iconv'
  depends_on 'intltool'

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
