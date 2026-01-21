require 'package'

class Libdom < Package
  description 'Implementation of the W3C DOM, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.4.2'
  license 'MIT'
  compatibility 'all'
  source_url "https://download.netsurf-browser.org/libs/releases/libdom-#{version}-src.tar.gz"
  source_sha256 'd05e45af16547014c2b0a3aecf3670fa13d419f505b3f5fc7ac8a1491fc30f3c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d1b7040757bc891e9e903f83d0eba1b9c5902febcccd5f70f5f74d92715bab3',
     armv7l: '5d1b7040757bc891e9e903f83d0eba1b9c5902febcccd5f70f5f74d92715bab3',
       i686: '322cfc4248244456efa557c84e9f00cefc113e685de00d80bee11512414b0c6b',
     x86_64: 'cc409f900097045236cd6d63716d51ffbf27f9d225a52be16eb8119962bf6524'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'libhubbub' # R
  depends_on 'libparserutils' # R
  depends_on 'libwapcaplet' # R

  @env = {
    'PREFIX' => CREW_PREFIX,
    'LIBDIR' => "lib#{CREW_LIB_SUFFIX}",
    'DESTDIR' => CREW_DEST_DIR,
    'COMPONENT_TYPE' => 'lib-shared'
  }

  def self.patch
    # Fix error: �~@~Xcalloc�~@~Y sizes specified with �~@~Xsizeof�~@~Y in the earlier argument and not in the later argument.
    system 'sed -i "s/sizeof(\*parser), 1/1, sizeof(*parser)/" bindings/xml/expat_xmlparser.c'
    system 'sed -i "s/sizeof(\*t), size/size, sizeof(*t)/" src/core/node.c'
    system 'sed -i "s/sizeof(dom_string \*), hds_COUNT/hds_COUNT, sizeof(dom_string *)/" src/html/html_document.c'
    system 'sed -i "s/sizeof(dom_string \*),/DOM_HTML_ELEMENT_TYPE__COUNT,/" src/html/html_document.c'
    system 'sed -i "s/DOM_HTML_ELEMENT_TYPE__COUNT)/sizeof(dom_string *))/" src/html/html_document.c'
  end

  def self.build
    system @env, 'make'
  end

  def self.install
    system @env, 'make install'
  end
end
