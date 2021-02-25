require 'package'

class Yelp_xsl < Package
  description 'yelp-xsl is a collection of programs and data files to help you build, maintain, and distribute documentation'
  homepage 'https://github.com/GNOME/yelp-xsl'
  version '40.beta'
  compatibility 'all'
  source_url 'https://github.com/GNOME/yelp-xsl/archive/40.beta.tar.gz'
  source_sha256 'f9145e36148ff473d501a5393e9d3b34c4450281cd6d6b8dac2c24aad4883d03'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_xsl-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '74ffc820d0c3cea9be8d2f299f6552223668226174aebba9a9d5921df56ba8ca',
     armv7l: '74ffc820d0c3cea9be8d2f299f6552223668226174aebba9a9d5921df56ba8ca',
       i686: '836738f78988eb6ca1331d08da02b365f4840001e3a131e15ea36516ec6ba55b',
     x86_64: '1bce675f4168fa9f44b7fc10ca7b33c7f6139b02671d891290c94f1f5069795e'
  })

  depends_on 'itstool'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
