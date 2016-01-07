require 'package'

class RubyLatest < Package
  version '2.2.4'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.4.tar.gz'
  source_sha1 '818e5e157f76d4912ba3a7c7b4fc5156105e83c3'

  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
