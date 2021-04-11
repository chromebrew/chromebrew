require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.0-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://apache.claz.org/apr/apr-1.7.0.tar.bz2'
  source_sha256 'e2e148f0b2e99b8e5c6caa09f6d4fb4dd3e83f744aa72a952f94f5a14436f7ea'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --disable-maintainer-mode \
            --with-devrandom \
            --without-sendfile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/build-1" # Seems residual from build and isn't needed
  end
end
