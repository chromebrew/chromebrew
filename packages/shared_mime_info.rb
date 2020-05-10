require 'package'

class Shared_mime_info < Package
  description 'The shared-mime-info package contains the core database of common types and the update-mime-database command used to extend it.'
  homepage 'https://freedesktop.org/wiki/Software/shared-mime-info/'
  version '1.10'
  compatibility 'all'
  source_url 'http://freedesktop.org/~hadess/shared-mime-info-1.10.tar.xz'
  source_sha256 'c625a83b4838befc8cafcd54e3619946515d9e44d63d61c4adf7f5513ddfbebf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/shared_mime_info-1.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/shared_mime_info-1.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/shared_mime_info-1.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shared_mime_info-1.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '29434bf4c31cf050dad19b3b31b5da17fe8e3321405e94f49769102721994f58',
     armv7l: '29434bf4c31cf050dad19b3b31b5da17fe8e3321405e94f49769102721994f58',
       i686: 'e5523070be234c8902f700b96f15ff71d825beb61c332941df44271ab876127a',
     x86_64: 'c408efcebe364232ba42bde95f4a67d5398cb827003bd91081b14c8172709a69',
  })

  depends_on 'glib'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make -j1'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To update the database, execute the following:".lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
