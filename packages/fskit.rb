require 'package'

class Fskit < Package
  description 'Filesystem utility library and SDK'
  homepage 'https://github.com/jcnelson/fskit'
  version '2feb33'
  source_url 'https://github.com/jcnelson/fskit/archive/2feb33a84932980e4ed9691242537771dd4e80f4.tar.gz'
  source_sha256 'c3f0506eb5d9345e5ea91086ebb2b2afcee889eed55792715c8ab5e523e02031'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-2feb33-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-2feb33-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-2feb33-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fskit-2feb33-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'df4308ee69d9e77c1c48e435f0d3173442b2155af4ca12614ad4b8a290def107',
     armv7l: 'df4308ee69d9e77c1c48e435f0d3173442b2155af4ca12614ad4b8a290def107',
       i686: '2a77491b23249a084335e3ff5ac9ed16bac64972be617dfbf6c195104c24c061',
     x86_64: '3544dae79049282a668fa02af3c59907ca78c3ca06be83dac4dda2491ae93651',
  })

  depends_on 'attr'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
