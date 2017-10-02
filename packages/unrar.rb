require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'http://www.rarlab.com/'
  version '5.5.8'
  source_url 'http://www.rarlab.com/rar/unrarsrc-5.5.8.tar.gz'
  source_sha256 '9b66e4353a9944bc140eb2a919ff99482dd548f858f5e296d809e8f7cdb2fcf4'

  def self.build
    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "make", "-j1", "all"
    system "make", "-j1", "lib"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_PREFIX}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp libunrar.so #{CREW_DEST_LIB_PREFIX}/libunrar.so"
  end
end
