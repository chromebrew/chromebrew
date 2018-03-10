require 'package'

class Cracklib < Package
  description 'The CrackLib package contains a library used to enforce strong passwords by comparing user selected passwords to words in chosen word lists.'
  homepage 'https://github.com/cracklib/cracklib'
  version '2.9.6'
  source_url 'https://github.com/cracklib/cracklib/releases/download/cracklib-2.9.6/cracklib-2.9.6.tar.gz'
  source_sha256 '17cf76943de272fd579ed831a1fd85339b393f8d00bf9e0d17c91e972f583343'

  depends_on 'glibc'
  depends_on 'zlibpkg'
    
       
  def self.build
    system "sed -i '/skipping/d' util/packer.c"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-static"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
    
  def self.test
    system "make test"
  end
end
