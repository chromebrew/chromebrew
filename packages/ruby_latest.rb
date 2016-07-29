require 'package'

class Ruby_latest < Package
  version '2.3.1'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz'
  source_sha2 'b87c738cb2032bf4920fef8e3864dc5cf8eae9d89d8d523ce0236945c5797dcd'

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
