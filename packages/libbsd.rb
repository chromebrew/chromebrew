require 'package'

class Libbsd < Package
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  version '0.8.6'
  source_url 'https://libbsd.freedesktop.org/releases/libbsd-0.8.6.tar.xz'
  source_sha256 '467fbf9df1f49af11f7f686691057c8c0a7613ae5a870577bef9155de39f9687'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6a2e1c9c9e508c7cb6de108a07c4ab58e7852c88fba2850ea079462b473d98c3',
     armv7l: '6a2e1c9c9e508c7cb6de108a07c4ab58e7852c88fba2850ea079462b473d98c3',
       i686: 'a3424c0ebed1554656778248aaf19f8551aad8d6268d7e5197976fd0df6da9fe',
     x86_64: '9e939f8a7825ba19a5fcda1c07afe21cfb1c3f856ab0f0ec423c98d420c6b2da',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
