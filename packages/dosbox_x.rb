require 'package'

class Dosbox_x < Package
  description 'An x86 emulator with DOS.'
  homepage 'https://dosbox-x.com/'
  version '0.83.1'
  compatibility 'all'
  source_url 'https://github.com/joncampbell123/dosbox-x/archive/dosbox-x-v0.83.1.tar.gz'
  source_sha256 '222c6c4e2ec15bfab0e327b9ba4af92a3fcdd0ff76f1917529a11503ab4a2833'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dosbox_x-0.83.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dosbox_x-0.83.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dosbox_x-0.83.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dosbox_x-0.83.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '839c4fef89a682fd9bc7bc761b42a112b7bf9e8ab6e33febe37ca3a80ef58aaa',
     armv7l: '839c4fef89a682fd9bc7bc761b42a112b7bf9e8ab6e33febe37ca3a80ef58aaa',
       i686: '27a8b791fa8079e871ac68d58ae41e925b568b604659d063b4d3c7b32d578305',
     x86_64: '28d8a38df1329b5059e81f84a37eafc155bfff5445bf3ded2eed8bc92e8d25b6',
  })

  depends_on 'ffmpeg'
  depends_on 'libglu'
  depends_on 'libpng'
  depends_on 'libsdl'

  def self.patch
    system 'filefix'
    system "sed -i 's,--prefix=/usr,#{CREW_OPTIONS},' build"
  end

  def self.build
    system './build'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "Type 'dosbox-x' to get started.".lightblue
    puts
  end
end
