require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.61.0'
  source_url 'https://curl.haxx.se/download/curl-7.61.0.tar.xz'
  source_sha256 'ef6e55192d04713673b4409ccbcb4cb6cd723137d6e10ca45b0c593a454e1720'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.61.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.61.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.61.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.61.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa84e0d50c5f50f7bbe16ef84dead422a74c1b86836793c7779f8450602c2ff5',
     armv7l: 'fa84e0d50c5f50f7bbe16ef84dead422a74c1b86836793c7779f8450602c2ff5',
       i686: '199f1ed50293b6f8167b343edeb261e7e5d92934019a76d71c06d3a6938a73b9',
     x86_64: 'd59e500171ebe3369683425a5d68d90996f17f12cb21d5071134250fa815f427',
  })

  depends_on 'groff' => :build
  depends_on 'rtmpdump'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-debug',
      '--disable-dependency-tracking',
      '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'test'
  end
end
