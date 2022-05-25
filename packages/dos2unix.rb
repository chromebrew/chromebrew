require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.4.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/dos2unix/dos2unix/7.4.0/dos2unix-7.4.0.tar.gz'
  source_sha256 'bac765abdbd95cdd87a71989d4382c32cf3cbfeee2153f0086cb9cf18261048a'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dos2unix/7.4.0_armv7l/dos2unix-7.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dos2unix/7.4.0_armv7l/dos2unix-7.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dos2unix/7.4.0_i686/dos2unix-7.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dos2unix/7.4.0_x86_64/dos2unix-7.4.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e485cc2a80abbd3f47110cca664d8e61ad17916fadbbf87012aa2b7baaeffaf3',
     armv7l: 'e485cc2a80abbd3f47110cca664d8e61ad17916fadbbf87012aa2b7baaeffaf3',
       i686: 'c93d6c2a9c908612c827f5361caa44c9c615bce5403ba1233eb90adb10173ece',
     x86_64: '249077651ae479e1888742a2925d41e003331f8836392986ed58b3fd18a6d123'
  })

  depends_on 'gettext' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp dos2unix #{CREW_DEST_PREFIX}/bin"
    system "cp mac2unix #{CREW_DEST_PREFIX}/bin"
    system "cp unix2dos #{CREW_DEST_PREFIX}/bin"
    system "cp unix2mac #{CREW_DEST_PREFIX}/bin"
  end
end
