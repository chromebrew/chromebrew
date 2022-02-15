require 'package'

class Docbook_xsl_nons < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  @_ver = '1.79.2'
  version "#{@_ver}-2"
  license 'custom'
  compatibility 'all'
  source_url "https://github.com/docbook/xslt10-stylesheets/releases/download/release/#{@_ver}/docbook-xsl-nons-#{@_ver}.zip"
  source_sha256 'ba41126fbf4021e38952f3074dc87cdf1e50f3981280c7a619f88acf31456822'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xsl_nons/1.79.2-2_armv7l/docbook_xsl_nons-1.79.2-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xsl_nons/1.79.2-2_armv7l/docbook_xsl_nons-1.79.2-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xsl_nons/1.79.2-2_i686/docbook_xsl_nons-1.79.2-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xsl_nons/1.79.2-2_x86_64/docbook_xsl_nons-1.79.2-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '06af54afe6fc9395a43fd9ac1771d348f80e5914ecd0881313e5697dad3d11c5',
     armv7l: '06af54afe6fc9395a43fd9ac1771d348f80e5914ecd0881313e5697dad3d11c5',
       i686: '594d32e423a401d903c69c58e3c0f6c9397a1ce80d5da6e777739b25a37bbce3',
     x86_64: 'b7e2266597a34c278188e8a0e6ff9efc1c3947db7ceb46d50f5f92ad3c8b9940'
  })

  depends_on 'docbook_xml'
  depends_on 'xmlcatmgr'
  depends_on 'libxml2'

  def self.patch
    downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/docbook-xsl/trunk/765567_non-recursive_string_subst.patch'
    unless Digest::SHA256.hexdigest(File.read('765567_non-recursive_string_subst.patch')) == '193ec26dcb37bdf12037ed4ea98d68bd550500c8e96b719685d76d7096c3f9b3'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
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
        install -Dt "#{@pkgroot}"/"$fn" -m644 "$fn"/*.{xml,xsl,dtd,ent}
        done
      )
    ADDFILES_HEREDOC
    File.write('add_files.sh', @ADDFILES_SH, perm: 0o755)
    system './add_files.sh || true'
  end

  def self.preinstall
    # Docbook common preinstall block
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xml"

    if File.exist?("#{CREW_PREFIX}/etc/xml/catalog") && !File.zero?("#{CREW_PREFIX}/etc/xml/catalog")
      puts "#{CREW_PREFIX}/etc/xml/catalog exists" if @opt_verbose
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/catalog" if @opt_verbose
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/catalog"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/catalog"
    end

    if File.exist?("#{CREW_PREFIX}/etc/xml/docbook-xml") && !File.zero?("#{CREW_PREFIX}/etc/xml/docbook-xml")
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
