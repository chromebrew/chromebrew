require 'package'

class Ruby_latest < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.0'
  source_url 'http://cache.ruby-lang.org/pub/ruby/ruby-2.4.0.tar.xz'
  source_sha256 '3a87fef45cba48b9322236be60c455c13fd4220184ce7287600361319bb63690'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ruby_latest-2.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ruby_latest-2.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/ruby_latest-2.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/ruby_latest-2.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '021baa20aa4a2813bd7c3ce97326f0264b545f9e82efe6a6664b248fd39ba30a',
     armv7l: '021baa20aa4a2813bd7c3ce97326f0264b545f9e82efe6a6664b248fd39ba30a',
       i686: 'af4d41ef2cbcb83f407220da918ef8c8c4f67aa98bc95d4e7dbeefe6064a9e6b',
     x86_64: 'b4650e927bc857af2e9eaf582f739954c95f8a6c1711ea41303330e9ca22bf12',
  })

  depends_on 'readline'
  depends_on 'zlibpkg'
  depends_on 'openssl'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
