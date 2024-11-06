require 'package'

class Docbook_xsl_nons < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  @_ver = '1.79.2'
  version "#{@_ver}-3"
  license 'custom'
  compatibility 'all'
  source_url "https://github.com/docbook/xslt10-stylesheets/releases/download/release/#{@_ver}/docbook-xsl-nons-#{@_ver}.zip"
  source_sha256 'ba41126fbf4021e38952f3074dc87cdf1e50f3981280c7a619f88acf31456822'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b2d037e40db4e9620283d65b54f74179e3ecdfc6aed68f8b6181b9f52f984c2',
     armv7l: '8b2d037e40db4e9620283d65b54f74179e3ecdfc6aed68f8b6181b9f52f984c2',
       i686: 'f9d1fe2df8bae0e071ba3634027cf1b9f4992c0b99b15d0b54459c74e6e337b4',
     x86_64: 'eab7666304dd3ea6fc347523b3e341e805fa80c21b0598ac66adb9126e7c1bf6'
  })

  depends_on 'docbook_xml'
  depends_on 'libxml2'
  depends_on 'xmlcatmgr'

  no_upstream_update

  def self.patch
    downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/docbook-xsl/trunk/765567_non-recursive_string_subst.patch',
               '193ec26dcb37bdf12037ed4ea98d68bd550500c8e96b719685d76d7096c3f9b3'

    system 'patch -Np2 -i 765567_non-recursive_string_subst.patch'
  end

  def self.install
    ENV['XML_CATALOG_FILES'] = "#{CREW_DEST_PREFIX}/etc/xml/catalog"
    @pkgroot = "#{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons"
    @ADDFILES_SH = <<~ADDFILES_HEREDOC
      #!/usr/bin/env bash
      set -ex

      install -Dt @pkgroot -m644 VERSION{,.xsl}
      (
        shopt -s nullglob  # ignore missing files
        echo "ignore missing files"
        for fn in assembly catalog.xml common docsrc eclipse epub epub3 \
        extensions for highlighting html htmlhelp images javahelp lib log \
        manpages params profiling roundtrip slides template tests tools \
        webhelp website xhtml xhtml-1_1 xhtml5
        do
        install -Dt "#{@pkgroot}"/"$fn" -m644 "$fn"/*.{xml,xsl,dtd,ent} || true
        done
      )
    ADDFILES_HEREDOC
    File.write('add_files.sh', @ADDFILES_SH, perm: 0o755)
    system './add_files.sh || true'
  end

  def self.preinstall
    # Docbook common preinstall block
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xml"

    if File.exist?("#{CREW_PREFIX}/etc/xml/catalog") && !File.empty?("#{CREW_PREFIX}/etc/xml/catalog")
      puts "#{CREW_PREFIX}/etc/xml/catalog exists" if @opt_verbose
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/catalog" if @opt_verbose
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/catalog"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/catalog"
    end

    if File.exist?("#{CREW_PREFIX}/etc/xml/docbook-xml") && !File.empty?("#{CREW_PREFIX}/etc/xml/docbook-xml")
      puts "#{CREW_PREFIX}/etc/xml/docbook-xml not empty" if @opt_verbose
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/docbook-xml" if @opt_verbose
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/docbook-xml"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/docbook-xml"
    end

    # End Docbook common preinstall block
  end

  def self.postinstall
    <<~CMD.each_line(chomp: true) do |cmd|
      xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl-nons/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl-nons/#{@_ver} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl-nons/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl-nons/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{@_ver}-nons '#{CREW_PREFIX}/etc/xml/catalog'
    CMD
      system cmd
    end
    # Check:
    <<~CMD.each_line(chomp: true) do |cmd|
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog https://cdn.docbook.org/release/xsl-nons/current/
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog https://cdn.docbook.org/release/xsl-nons/#{@_ver}/
    CMD
      system cmd if @opt_verbose
    end
  end
end
