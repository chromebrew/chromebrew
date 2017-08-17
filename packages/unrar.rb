require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'http://www.rarlab.com/'
  version '5.5.7'
  source_url 'http://www.rarlab.com/rar/unrarsrc-5.5.7.tar.gz'
  source_sha256 '8aef0a0d91bf9c9ac48fab8a26049ac7ac49907e75a2dcbd511a4ba375322d8f'

  def self.build
    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "make", "-j1", "all"
    system "make", "-j1", "lib"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}/usr/local", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}/usr/local", "install-lib"
  end
end
