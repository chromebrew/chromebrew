require 'package'

class Libdc1394 < Package
  description 'libdc1394 is a library that provides a complete high level application programming interface (API) for developers who wish to control IEEE 1394 based cameras'
  homepage 'https://damien.douxchamps.net/ieee1394/libdc1394/'
  version '2.2.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libdc1394/libdc1394-2/2.2.0/libdc1394-2.2.0.tar.gz'
  source_sha256 'c6e6175c32c5567c5d4245176e75d1dfdd353902dd640e1de26cdefe5146fe6c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdc1394-2.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdc1394-2.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdc1394-2.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdc1394-2.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9b7d5faf499e68792355cce360192bc48b8379d897096b966aecb3714c929442',
     armv7l: '9b7d5faf499e68792355cce360192bc48b8379d897096b966aecb3714c929442',
       i686: '38f1b4636ffc6a4e7b49fbe5691c87d6c38042b0ebadb521c740db9cc9906a20',
     x86_64: 'fe06f9509d4ddb10d2c98f813965f93381453ef87d82dc93f8169884be889b8d',
  })

  depends_on 'freeglut'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-x'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
