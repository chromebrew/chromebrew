require 'package'

class Libksba < Package
  description 'Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy.'
  homepage 'https://www.gnupg.org/related_software/libksba/index.html'
  version '1.6.3'
  license 'LGPL-3+, GPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.6.3.tar.bz2'
  source_sha256 '3f72c68db30971ebbf14367527719423f0a4d5f8103fc9f4a1c01a9fa440de5c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3143a3ade1b121b8359f72da982aa9510e5846f1a4869f0d45690d6a03279d58',
     armv7l: '3143a3ade1b121b8359f72da982aa9510e5846f1a4869f0d45690d6a03279d58',
       i686: 'd427822f59b7a958fdbe3d6ec9793ab37c1e1a32cb33277d0cf380651abca2e4',
     x86_64: '6efc93e6a46d47947344ff7f8c277219edeee50de94d653501db712800ea25a3'
  })

  depends_on 'npth' => :build
  depends_on 'glibc' # R
  depends_on 'libgpgerror' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
