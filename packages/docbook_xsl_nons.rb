require 'package'

class Docbook_xsl_nons < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  version '1.79.2-2020-06-03'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/docbook/xslt10-stylesheets/releases/download/snapshot/2020-06-03/docbook-xsl-nons-snapshot.zip'
  source_sha256 'b6b10730f519c5f0125ba6349cc2bc2b9f7d9aee85f503b33b476b1c2ab29750'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95400370aa1a1ec02488fbf30b6d69a40d5feb979b1dd3495dbbae17b8796026',
     armv7l: '95400370aa1a1ec02488fbf30b6d69a40d5feb979b1dd3495dbbae17b8796026',
       i686: '09b53fc507c5daddd8e907fd4df7911b75a642895f0a52109134fefc22ada40a',
     x86_64: 'b2a6e1b7f80d9e0eaa0305afc21a404fcdcbedd96f8fe0d06d3d2792c349460e'
  })

  # depends_on 'ant' => :build # (If building from non-release source)
  # depends_on 'graphicsmagick' => :build # (If building from non-release source - but note that this isn't available on i686) 
  depends_on 'docbook_xml'
  depends_on 'libxml2' => :build
  depends_on 'xmlcatmgr'

  no_upstream_update

  # Patch and build are only for building from non-release snapshots.
  # def self.patch
  #   perl_files = `grep -rl "/usr/bin/perl" .`.chomp.split
  #   perl_files.each do |file|
  #     system "sed -i 's,/usr/bin/perl,/usr/bin/env perl,' #{file}"
  #   end
  # end

  # def self.build
  #   system 'make'
  #   system 'make check'
  #   system 'make dist'
  #   VERSION = `make version`.chomp
  # end

  def self.install
    ENV['XML_CATALOG_FILES'] = "#{CREW_DEST_PREFIX}/etc/xml/catalog"
    @pkgroot = "#{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version}-nons"
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
      xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl-nons/#{version} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version}-nons '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl-nons/#{version} #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version}-nons '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteSystem https://cdn.docbook.org/release/xsl-nons/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version}-nons '#{CREW_PREFIX}/etc/xml/catalog'
      xmlcatalog --noout --add rewriteURI https://cdn.docbook.org/release/xsl-nons/current #{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-#{version}-nons '#{CREW_PREFIX}/etc/xml/catalog'
    CMD
      system cmd
    end
    # Check:
    <<~CMD.each_line(chomp: true) do |cmd|
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog https://cdn.docbook.org/release/xsl-nons/current/
      xmlcatalog #{CREW_PREFIX}/etc/xml/catalog https://cdn.docbook.org/release/xsl-nons/#{version}/
    CMD
      system cmd if @opt_verbose
    end
  end
end
