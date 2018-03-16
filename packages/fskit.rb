require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version 'dd9a8'
  source_url 'https://github.com/jcnelson/fskit/archive/dd9a8dc844b81afc63e5067397786a32ecb66008.tar.gz'
  source_sha256 'fe682890ebab9226d65fc6ebfb8b3619c0d5a93e3161787cea9d01ad23d3a83a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-dd9a8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b51b018c892a80340f4957b64df87ea55f1a5dbe7bd5dc574bd504b8cefc3429',
     armv7l: 'b51b018c892a80340f4957b64df87ea55f1a5dbe7bd5dc574bd504b8cefc3429',
       i686: '7463ea0b68a5b29ea3b4162ccade4556d380ed55ba6c391de74c9821b8156388',
     x86_64: '7ed7cade6d97d596a894b024785d910fa378d11017fb83487ab8a43ac446a784',
  })

  depends_on 'attr'

  def self.patch
    # for x86_64 architecture, build library should be modified to #{CREW_PREFIX}/lib64
    if ARCH == "x86_64"
      puts "Patch build file for x86_64 ..."
      `sed -i -- 's/lib/lib64/g' buildconf.mk` # replace lib by lib64
    end
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
