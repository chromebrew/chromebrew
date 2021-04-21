require 'package'

class Docbook_xsl_nons < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  @_ver = '1.79.2'
  version "#{@_ver}-1"
  license 'custom'
  compatibility 'all'
  source_url "https://github.com/docbook/xslt10-stylesheets/releases/download/release/#{@_ver}/docbook-xsl-nons-#{@_ver}.zip"
  source_sha256 'ba41126fbf4021e38952f3074dc87cdf1e50f3981280c7a619f88acf31456822'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/docbook_xsl_nons-1.79.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/docbook_xsl_nons-1.79.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/docbook_xsl_nons-1.79.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/docbook_xsl_nons-1.79.2-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'dbc2f81d3557aea2e40e87f4d1d68adc0b36c4a549f20813e66ab54d6e357030',
     armv7l: 'dbc2f81d3557aea2e40e87f4d1d68adc0b36c4a549f20813e66ab54d6e357030',
       i686: '1ec31fedd6f78376aaf36c67ab6d8a985ad198fad674742b7a48654a9e687647',
     x86_64: 'a0a9096b8900966146d924cd86ef43b10b973422186cc5f25520897417fdb707'
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
    @pkgroot = "#{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons"
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
    system "xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl-nons/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl-nons/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl-nons/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl-nons/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'"
    # Check:
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", 'https://cdn.docbook.org/release/xsl-nons/current/'
    system 'xmlcatalog', "#{CREW_PREFIX}/etc/xml/catalog", "https://cdn.docbook.org/release/xsl-nons/#{@_ver}/"
  end
end
