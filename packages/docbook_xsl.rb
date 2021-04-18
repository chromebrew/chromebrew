require 'package'

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  @_ver = '1.79.2'
  version "#{@_ver}-2"
  license 'custom'
  compatibility 'all'
  source_url "https://github.com/docbook/xslt10-stylesheets/releases/download/release/#{@_ver}/docbook-xsl-#{@_ver}.zip"
  source_sha256 '853dce096f5b32fe0b157d8018d8fecf92022e9c79b5947a98b365679c7e31d7'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/docbook_xsl-1.79.2-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/docbook_xsl-1.79.2-2-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/docbook_xsl-1.79.2-2-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/docbook_xsl-1.79.2-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '98cc13cd1883b26708624d253cb54325f523d2f4bf43089a1008c7500c81f37c',
     armv7l: '98cc13cd1883b26708624d253cb54325f523d2f4bf43089a1008c7500c81f37c',
       i686: 'ff237f1f8c2be2482391150492a03f49518a20c30d36b9c9fa6302b1f265e0eb',
     x86_64: '4e53c3fe08e6b59c6e1a9bb2f1b9620e93af939c87a95ff3d97bb16095adde1a'
  })

  depends_on 'docbook_xml'
  depends_on 'xmlcatmgr'
  depends_on 'bash'

  def self.patch
    system 'curl -OLf "https://github.com/archlinux/svntogit-packages/raw/packages/docbook-xsl/trunk/765567_non-recursive_string_subst.patch"'
    unless Digest::SHA256.hexdigest(File.read('765567_non-recursive_string_subst.patch')) == '193ec26dcb37bdf12037ed4ea98d68bd550500c8e96b719685d76d7096c3f9b3'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    system 'patch -Np2 -i 765567_non-recursive_string_subst.patch'
  end

  def self.install
    ENV['XML_CATALOG_FILES'] = "#{CREW_DEST_PREFIX}/etc/xml/catalog"
    @pkgroot = "#{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}"
    @ADDFILES_SH = <<~ADDFILES_HEREDOC
      install -Dt @pkgroot -m644 VERSION{,.xsl}
      (
        shopt -s nullglob  # ignore missing files
        echo "ignore missing files"
        for fn in assembly catalog.xml common docsrc eclipse epub epub3 \
        extensions for highlighting html htmlhelp images javahelp lib log \
        manpages params profiling roundtrip slides template tests tools \
        webhelp website xhtml xhtml-1_1 xhtml5
        do
        install -Dt "#{@pkgroot}"/"$fn" -m644 "$fn"/*.{xml,xsl,dtd,ent}
        done
      )
    ADDFILES_HEREDOC
    IO.write('add_files.sh', @ADDFILES_SH, perm: 0o755)
    system "#{CREW_PREFIX}/bin/bash ./add_files.sh || true"
    system "install -Dt #{@pkgroot} -m644 VERSION.xsl"
    FileUtils.ln_s "#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}",
                   "#{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/"
    # For moreutils
    FileUtils.ln_s "#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}",
                   "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook-xsl"
  end

  def self.preinstall
    # Docbook common preinstall block
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xml"

    if File.exist?("#{CREW_PREFIX}/etc/xml/catalog") && !File.zero?("#{CREW_PREFIX}/etc/xml/catalog")
      puts "#{CREW_PREFIX}/etc/xml/catalog exists"
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/catalog"
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/catalog"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/catalog"
    end

    if File.exist?("#{CREW_PREFIX}/etc/xml/docbook-xml") && !File.zero?("#{CREW_PREFIX}/etc/xml/docbook-xml")
      puts "#{CREW_PREFIX}/etc/xml/docbook-xml not empty"
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/docbook-xml"
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/docbook-xml"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/docbook-xml"
    end

    # End Docbook common preinstall block
  end

  def self.postinstall
    system "xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl-ns/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl-ns/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl-ns/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl-ns/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver} '#{CREW_PREFIX}/etc/xml/catalog'"
    # Check:
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", 'https://cdn.docbook.org/release/xsl/current/'
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", "https://cdn.docbook.org/release/xsl/#{@_ver}/"
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", 'http://docbook.sourceforge.net/release/xsl/current/'
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", "http://docbook.sourceforge.net/release/xsl/#{@_ver}/"
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", 'http://docbook.sourceforge.net/release/xsl-ns/current/'
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", "http://docbook.sourceforge.net/release/xsl-ns/#{@_ver}/"
  end
end
