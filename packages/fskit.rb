require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version 'dd9a8d'
  source_url 'https://github.com/jcnelson/fskit/archive/dd9a8dc844b81afc63e5067397786a32ecb66008.tar.gz'
  source_sha256 'fe682890ebab9226d65fc6ebfb8b3619c0d5a93e3161787cea9d01ad23d3a83a'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8d-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '22c2b4d3adb6a374f267983ff164a6ad63f9aa762f47921c99eebe01031438a6',
  })

  depends_on 'attr'

  def self.patch
    system "wget", "https://github.com/JL2210/patches/raw/master/fskit-dd9a8-xattr.patch"
    system "patch -Np1 -i fskit-dd9a8-xattr.patch"
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
