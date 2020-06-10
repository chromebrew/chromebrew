require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.23.18.1'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit/releases/download/0.23.18.1/p11-kit-0.23.18.1.tar.gz'
  source_sha256 '34c3bd8c0050dd7c4e6228aecf0f168de0a1b34562ddbf74a1c70904c2523c6f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.18.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.18.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.18.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.18.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd9e24ea10a619d622b2ae47cab26e7e53f35767eddf2705e551c9c26c6cebd81',
     armv7l: 'd9e24ea10a619d622b2ae47cab26e7e53f35767eddf2705e551c9c26c6cebd81',
       i686: 'ae93ca980625bd990428c37beee0debc92bcb50a9bf25b1a3a889f6759ae15a1',
     x86_64: '92f3d0916b20eb2019fc4372f855d34e18d1a661aada22bfac72df0abb58464f',
  })

  depends_on 'libffi'
  depends_on 'libtasn1'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared',
           '--with-pic'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
