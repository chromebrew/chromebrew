require 'package'

class Yelp_tools < Package
  description 'yelp-tools is a collection of scripts and build utilities to help create, manage, and publish documentation for Yelp and the web'
  homepage 'https://github.com/GNOME/yelp-tools'
  version '3.27.90'
  compatibility 'all'
  source_url 'https://github.com/GNOME/yelp-tools/archive/3.27.90.tar.gz'
  source_sha256 'da584450bc2373d1a27a922e851f88256c49c9a49a15ed2762e493f37b52a692'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.27.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.27.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.27.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp_tools-3.27.90-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '987e8cfbb0143822f93eb0f81007b827f3b454f306c90e4a2bdc2e87d6b9ad65',
     armv7l: '987e8cfbb0143822f93eb0f81007b827f3b454f306c90e4a2bdc2e87d6b9ad65',
       i686: '833183e480c171f8ea45dd3033732365bc9d98b271197b2eb808195a31493d81',
     x86_64: 'a1a3ab4fc4dfdf533e0962926a59ea9c3b609977c01db6c4824921b19a2333e1',
  })

  depends_on 'yelp_xsl'
  depends_on 'libxslt'

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
