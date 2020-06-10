require 'package'

class Elinks < Package
  description 'Full-Featured Text WWW Browser'
  homepage 'http://elinks.or.cz/'
  version '0.11.7'
  compatibility 'all'
  source_url 'http://elinks.or.cz/download/elinks-0.11.7.tar.bz2'
  source_sha256 '456db6f704c591b1298b0cd80105f459ff8a1fc07a0ec1156a36c4da6f898979'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-0.11.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-0.11.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-0.11.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-0.11.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0d84da6aae40b4ac0df284338634493925ad37ff8a3e5017383de8a8ca8c8db8',
     armv7l: '0d84da6aae40b4ac0df284338634493925ad37ff8a3e5017383de8a8ca8c8db8',
       i686: 'cffbb308ddf6d25d74d94d3f17e790b1f0d90ef9e6fea933180c50ef35006152',
     x86_64: '6473794b1cad1f09965ae540adf4f8fe0e8bb9a957d9d37477ff06e6f99095d0',
  })

  depends_on 'bz2'
  depends_on 'lzip'

  def self.build
    system "sh autogen.sh"
    system "./configure --without-x --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
