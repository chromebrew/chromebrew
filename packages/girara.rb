require 'package'

class Girara < Package
  description 'Girara is a library that implements a user interface that focuses on simplicity and minimalism'
  homepage 'https://pwmt.org/projects/girara/'
  version '0.3.5'
  compatibility 'all'
  source_url 'https://pwmt.org/projects/girara/download/girara-0.3.5.tar.xz'
  source_sha256 'e33ba2a21dd57606439d37c829d48466a14e3e50a698e6bd678b511f5c59f4b5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/girara-0.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '82dff3ea4ff0099f016a5aee03c52115b3acea760e55ec7c25c624f337f4f934',
     armv7l: '82dff3ea4ff0099f016a5aee03c52115b3acea760e55ec7c25c624f337f4f934',
       i686: '40b3fa4edd6a75356e1ae9d9d9be6d44b6df5c3389e1aedb65aff5afbb7b3888',
     x86_64: '31702ec57e6ff9e1a1d096ecdf73ad2411e14b87c86cb6524175ee91f1dd1742',
  })

  depends_on 'gtk3'
  depends_on 'glib'
  depends_on 'jsonc'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
