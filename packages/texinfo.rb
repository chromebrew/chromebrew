require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.5-0'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-6.5.tar.xz'
  source_sha256 '77774b3f4a06c20705cc2ef1c804864422e3cf95235e965b1f00a46df7da5f62'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/texinfo-6.5-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f279aad0636d64d0cb14d603923c6755e1a72245b89b448f134284d86994666',
     armv7l: '9f279aad0636d64d0cb14d603923c6755e1a72245b89b448f134284d86994666',
       i686: '4ab3d66b3a15f1114008a46caa825d1b03ba79b242836c5954d11ee177767bd6',
     x86_64: 'ba12fa7582cdf7428c92be26c1dc31476bc73c21dfd42b84a3f0a8c5f525335b',
  })

  depends_on 'gettext' => :build
  depends_on 'perl'
  depends_on 'perl_locale_messages'
  depends_on 'perl_text_unidecode'
  depends_on 'perl_unicode_eastasianwidth'
  depends_on 'ncurses'

  def self.build
    # configure and make
    system './configure',
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}",
        '--with-external-Text-Unidecode',
        '--with-external-Unicode-EastAsianWidth'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end
