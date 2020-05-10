require 'package'

class Aview < Package
  description 'aview is an high quality ascii-art image(pnm) browser and animation(fli/flc) player usefull especially with lynx browser.'
  homepage 'http://aa-project.sourceforge.net/aview/'
  version '1.3.0rc1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/aa-project/aview/1.3.0rc1/aview-1.3.0rc1.tar.gz'
  source_sha256 '42d61c4194e8b9b69a881fdde698c83cb27d7eda59e08b300e73aaa34474ec99'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aview-1.3.0rc1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aview-1.3.0rc1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aview-1.3.0rc1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aview-1.3.0rc1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7dac7b7bb1df20b2f3c5f4b3072d7c687d00187a7f65e25e7d754b658215bcd',
     armv7l: 'b7dac7b7bb1df20b2f3c5f4b3072d7c687d00187a7f65e25e7d754b658215bcd',
       i686: '4646662cc91ca8049a577bb0a0ceb2545645250c6bc05a124fd2c8c2eb536c05',
     x86_64: '70d29a20c0ade541d6f0aba440412d844a4815f8c0317a00d7c13005e1232395',
  })

  depends_on 'aalib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-x'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
