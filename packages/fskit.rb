require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version 'dd9a8d'
  compatibility 'all'
  source_url 'https://github.com/jcnelson/fskit/archive/dd9a8dc844b81afc63e5067397786a32ecb66008.tar.gz'
  source_sha256 'fe682890ebab9226d65fc6ebfb8b3619c0d5a93e3161787cea9d01ad23d3a83a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8d-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8d-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8d-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8d-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0efdae023da0bae9937978163a17248ba26ad6a29af52c7dbbcd98fbb17ae2d0',
     armv7l: '0efdae023da0bae9937978163a17248ba26ad6a29af52c7dbbcd98fbb17ae2d0',
       i686: '65c827cd622753d13d1dda7f26dbe437365c8af6285754873db16d7d980d72e2',
     x86_64: 'd4cc3783a929b3cb95652bad97dfe9cb0797aa431b3db2daecb829f34980f1db',
  })

  depends_on 'attr'

  def self.patch
    system "sed -i 's,#include <attr/xattr\.h>,#include <attr/attributes.h>\n#include <sys/xattr.h>,g' include/fskit/*.h"
  end

  def self.build
    system "make",
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "PKGCONFIGDIR=#{CREW_LIB_PREFIX}/pkgconfig"
  end

  def self.install
    system "make",
           "PREFIX=#{CREW_DEST_PREFIX}",
           "LIBDIR=#{CREW_DEST_LIB_PREFIX}",
           "PKGCONFIGDIR=#{CREW_DEST_LIB_PREFIX}/pkgconfig",
           "install"
  end
end
