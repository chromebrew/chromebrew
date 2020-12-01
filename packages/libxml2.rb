require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.10-1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.10/libxml2-v2.9.10.tar.bz2'
  source_sha256 '5f1cc19c849cccabb983881cf1ebf833f42db5d7b8afba7a7763a2ac3101715c'



  depends_on 'zlibpkg'

  def self.patch
    # Patch to work with icu .68.1
    url_patch1 = "https://gitlab.gnome.org/GNOME/libxml2/-/commit/b516ed189eb440e909f36baca1557b98e4d9ffd7.patch"
    uri_patch1 = URI.parse url_patch1
    filename_patch1 = 'patch1'
    sha256sum_patch1 = 'f02a435761f26ff664041d49f9d05924dc627bf103c7f542feee891f69aa84a2'

    puts "Downloading patch1".yellow
    system('curl', '-s', '--insecure', '-L', '-#', url_patch1, '-o', filename_patch1)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
      Digest::SHA256.hexdigest( File.read( filename_patch1 ) ) == sha256sum_patch1
    puts "patch1 downloaded".lightgreen
    system 'patch -p 1 < patch1'
  end
    
  def self.build
    system './autogen.sh'
    # libxml2-python built in another package (libxml2_python)
    system "./configure #{CREW_OPTIONS} --enable-shared --disable-static --with-pic \
--without-python --without-lzma --with-zlib --with-icu --with-threads --with-history"
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
