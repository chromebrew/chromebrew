require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.10.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.0/libxml2-v2.10.0.tar.bz2'
  source_sha256 'c44124d025162767a1d3fe35b556c5855e6be7240e3dc3159490e91d5cadbba3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.9.12-1_armv7l/libxml2-2.9.12-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.9.12-1_armv7l/libxml2-2.9.12-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.0_i686/libxml2-2.10.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxml2/2.10.0_x86_64/libxml2-2.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a625e8e0e08c69f0bf0d77c8207ffc17504f6cd9dd417d309740ca8ddcfb888b',
     armv7l: 'a625e8e0e08c69f0bf0d77c8207ffc17504f6cd9dd417d309740ca8ddcfb888b',
       i686: '602ec20ae5de3ee3cd20aa7b084a29503c01876959e71dcab6ec4a5e77b94066',
     x86_64: '14eab43697a8d3cc844ecad6f2ce85491ba0808866cf42d3191b0eb7b405d7da'
  })

  depends_on 'gcc'
  depends_on 'icu4c'
  depends_on 'readline'
  depends_on 'zlibpkg'

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
