require 'package'

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  compatibility 'all'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  @_ver = '1.79.2'
  version @_ver
  source_url "https://github.com/docbook/xslt10-stylesheets/releases/download/release/#{@_ver}/docbook-xsl-#{@_ver}.zip"
  source_sha256 '853dce096f5b32fe0b157d8018d8fecf92022e9c79b5947a98b365679c7e31d7'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '78f0e12c3db339ebd0d9f7d78016c89aaaa94d0649d9dc8ac342211cf09f25ad',
     armv7l: '78f0e12c3db339ebd0d9f7d78016c89aaaa94d0649d9dc8ac342211cf09f25ad',
       i686: '1e125577e569c168d646544bc8547eecc76e21b6ad6f85088e74711b8421d88d',
     x86_64: 'dbba4c5f2c095d0254664db90aaf921d1f182f570a66fb7cf1e4f36732e58e54'
  })

  depends_on 'xmlcatmgr'
  depends_on 'docbook_xsl_nons'
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
        extensions fo highlighting html htmlhelp images javahelp lib log \
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
    # Docbook common postinstall block
    ENV['XML_CATALOG_FILES'] = "#{CREW_PREFIX}/etc/xml/catalog"

    xml_catalog_files_in_bashrc = `grep -c "XML_CATALOG_FILES" ~/.bashrc || true`
    unless xml_catalog_files_in_bashrc.to_i.positive?
      puts "Putting \"export XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog\" in ~/.bashrc".lightblue
      system "echo 'export XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
    # End Docbook common postinstall block

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
