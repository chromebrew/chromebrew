require 'package'

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  version '1.79.2-5'
  license 'custom'
  compatibility 'all'
  source_url "https://github.com/docbook/xslt10-stylesheets/releases/download/release/#{version.split('-').first}/docbook-xsl-#{version.split('-').first}.zip"
  source_sha256 '853dce096f5b32fe0b157d8018d8fecf92022e9c79b5947a98b365679c7e31d7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b62ae6d5baf3b31f3c08850cf6fab86502c27a3410590384daee6b0a0e82ad47',
     armv7l: 'b62ae6d5baf3b31f3c08850cf6fab86502c27a3410590384daee6b0a0e82ad47',
       i686: '93aa4669b36e84f8b19447681109621eda935ae860946d3f9d84af3234b71015',
     x86_64: '0358b98fa34acc6681a7fff0431acc43753220ec8a2662fdef52b9dde0490c67'
  })

  depends_on 'docbook_xml'
  depends_on 'libxml2'
  depends_on 'xmlcatmgr'
  print_source_bashrc

  def self.patch
    downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/docbook-xsl/trunk/765567_non-recursive_string_subst.patch',
               '193ec26dcb37bdf12037ed4ea98d68bd550500c8e96b719685d76d7096c3f9b3'
    system 'patch -Np2 -i 765567_non-recursive_string_subst.patch'
  end

  def self.install
    ENV['XML_CATALOG_FILES'] = "#{CREW_DEST_PREFIX}/etc/xml/catalog"
    @pkgroot = "#{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first}"
    @ADDFILES_SH = <<~ADDFILES_HEREDOC
      #!/usr/bin/env bash
      set -ex

      install -Dt #{@pkgroot} -m644 VERSION{,.xsl}
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
    FileUtils.install 'VERSION.xsl', @pkgroot, mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first}",
                   "#{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/"
    # For moreutils
    FileUtils.ln_s "#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first}",
                   "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook-xsl"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Docbook_xml configuration
      XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/docbook_xml", @env)
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
      xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl/#{version.split('-').first} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl/#{version.split('-').first} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl/#{version.split('-').first} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl/#{version.split('-').first} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl-ns/#{version.split('-').first} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl-ns/#{version.split('-').first} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteSystem http://docbook.sourceforge.net/release/xsl-ns/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI http://docbook.sourceforge.net/release/xsl-ns/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version.split('-').first} '#{CREW_PREFIX}/etc/xml/catalog'
    CMD
      system cmd
    end

    # Check:
    <<~CMD.each_line(chomp: true) do |cmd|
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog https://cdn.docbook.org/release/xsl/current/
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog https://cdn.docbook.org/release/xsl/#{version.split('-').first}/
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog http://docbook.sourceforge.net/release/xsl/current/
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog http://docbook.sourceforge.net/release/xsl/#{version.split('-').first}/
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog http://docbook.sourceforge.net/release/xsl-ns/current/
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog http://docbook.sourceforge.net/release/xsl-ns/#{version.split('-').first}/
    CMD
      system cmd if @opt_verbose
    end
  end
end
