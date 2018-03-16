require 'package'

class Cracklib < Package
  description 'The CrackLib package contains a library used to enforce strong passwords by comparing user selected passwords to words in chosen word lists.'
  homepage 'https://github.com/cracklib/cracklib'
  version '2.9.6'
  source_url 'https://github.com/cracklib/cracklib/releases/download/cracklib-2.9.6/cracklib-2.9.6.tar.gz'
  source_sha256 '17cf76943de272fd579ed831a1fd85339b393f8d00bf9e0d17c91e972f583343'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3b4dfb4640d3144efead15ecd89f2c4deb00411961148ac283f29852fb4c9863',
     armv7l: '3b4dfb4640d3144efead15ecd89f2c4deb00411961148ac283f29852fb4c9863',
       i686: '8bcedd92ba9f1b20c02863d762920715141147f576ccfa7ff58fbb8aa0e3a098',
     x86_64: 'b849e7c6f03b14c88c6fdeac85faf3b2a3dbc8004573034e1779f0fe4592490f',
  })

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
