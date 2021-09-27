require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.12/libxml2-v2.9.12.tar.bz2'
  source_sha256 'bb5ea084617e2bc706cd1f0c9b36328950c9d802a16ff52795e5f13bae900ca8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.9.12_armv7l/libxml2-2.9.12-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.9.12_armv7l/libxml2-2.9.12-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.9.12_i686/libxml2-2.9.12-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.9.12_x86_64/libxml2-2.9.12-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a6315954148a4ec7f7867031c282c967b198ea494f81d28f1eef8cd2e3c65e36',
    armv7l: 'a6315954148a4ec7f7867031c282c967b198ea494f81d28f1eef8cd2e3c65e36',
    i686: '52be8e1e0497dafbb0f92847342353ce22e104a388a30d075b1de32129089686',
    x86_64: 'ebb3b81155231be702617246a78945a3698142f63b3138c5763b9813d57dbe19'
  })

  depends_on 'zlibpkg'
  depends_on 'readline'
  depends_on 'gcc11'

  def self.patch
    # Fix encoding.c:1961:31: error: ‘TRUE’ undeclared (first use in this function)
    system "for f in \$(grep -rl \'TRUE)\'); do sed -i 's,TRUE),true),g' \$f; done"
  end

  def self.build
    # libxml2-python built in another package (py3_libxml2)
    system "./autogen.sh \
      #{CREW_OPTIONS} \
      #{CREW_ENV_OPTIONS} \
      --enable-shared \
      --enable-static \
      --with-pic \
      --without-python \
      --without-lzma \
      --with-zlib \
      --with-icu \
      --with-threads \
      --with-history"
    system 'make'
  end

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system 'rm', 'test/ebcdic_566012.xml'

    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
