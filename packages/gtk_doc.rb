require 'package'

# There are alot of patches to grab here ~ They've all come from Void-Packages (xbps-src)

class Gtk_doc < Package
  description 'Documentation tool for public library API'
  homepage 'https://www.gtk.org/gtk-doc/'
  version '1.32'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gtk-doc/1.32/gtk-doc-1.32.tar.xz'
  source_sha256 'de0ef034fb17cb21ab0c635ec730d19746bce52984a6706e7bbec6fb5e0b907c'

  depends_on 'docbook_xml'
  depends_on 'docbook_xsl'
  depends_on 'itstool'
  depends_on 'libxslt'
  depends_on 'docbook_xml43'

  def self.patch
    puts
    puts 'Grabbing patches'.lightblue
    system 'curl --ssl -L -o "output-reproducible.patch" "https://git.io/JUlWD" --progress-bar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('output-reproducible.patch') ) == '701fe4124a94b124e943e9220f4ea42de7fe191379f41c349cc2f69ece37af24'
    system 'curl --ssl -L -o "tree-structure-without-using-anytree.patch" "https://git.io/JUlOD" --progress-bar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('tree-structure-without-using-anytree.patch') ) == '8423045330d66f119d1a1caab6d08b1121230d3103de405840be1743af71c8b3'
    system 'curl --ssl -L -o "support-deprecated-struct-members.patch" "https://git.io/JUl3O" --progress-bar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('support-deprecated-struct-members.patch') ) == '3f9c3c68640c76c10d9262e0678828374d8dbbb9cd9d30b64f2aed7a78277d1f'
    system 'curl --ssl -L -o "typedef-can-be-followed-by-decorator.patch" "https://git.io/JUl3C" --progress-bar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('typedef-can-be-followed-by-decorator.patch') ) == '16c4d633ddf0e72a7146cf6427b15c9a3780d5b6e36185baaead2e529741da2c'
    system 'curl --ssl -L -o "IGNORE_DEPRECATIONS-lines.patch" "https://git.io/JUl3o" --progress-bar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('IGNORE_DEPRECATIONS-lines.patch') ) == '7b4703006fa03a58faa72287e043f31893f8bbb2ea69ee15a2c5b29e5ff56534'
    system 'curl --ssl -L -o  "revert_fix_build.patch" "https://git.io/JUl3H" --progress-bar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('revert_fix_build.patch') ) == 'e1520094c3cc110767f840f7a710ce56cdaae4650316a5407337425dd37969c4'
    puts
    puts 'Applying patches'.lightblue
    system 'patch -Np1 -i revert_fix_build.patch'
    system 'patch -Np1 -i IGNORE_DEPRECATIONS-lines.patch'
    system 'patch -Np1 -i typedef-can-be-followed-by-decorator.patch'
    system 'patch -Np1 -i support-deprecated-struct-members.patch'
    system 'patch -Np1 -i tree-structure-without-using-anytree.patch'
    system 'patch -Np1 -i output-reproducible.patch'
    puts
  end
  def self.build
      system "./configure #{CREW_OPTIONS} --with-xml-catalog=#{CREW_PREFIX}/etc/xml/catalog.xml"
      system 'make'
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
