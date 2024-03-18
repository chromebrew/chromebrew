require 'package'

class Docbook_xml50 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '5.0'
  version "#{@_ver}-3"
  license 'MIT'
  compatibility 'all'
  source_url "https://docbook.org/xml/#{@_ver}/docbook-#{@_ver}.zip"
  source_sha256 '3dcd65e1f5d9c0c891b3be204fa2bb418ce485d32310e1ca052e81d36623208e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fcaedafc069a5be2f3eb4cf7dd051fef685baf6206c3fee32cbf8acc8b1ff87f',
     armv7l: 'fcaedafc069a5be2f3eb4cf7dd051fef685baf6206c3fee32cbf8acc8b1ff87f',
       i686: '4baf10466bdcb1c8a31626ecc7ba4fa02f89eda1c33a08639642d3d45af5210c',
     x86_64: '3ac628bda7909fdaee75d7e0fc67a51b9c4bd931741910c069c31603c9de55d2'
  })

  depends_on 'docbook_xml'
  depends_on 'libxml2'
  depends_on 'xmlcatmgr'

  no_upstream_update

  def self.install
    system "xmlcatalog --noout --create docbook-#{@_ver}.xml"
    # DTD
    system <<~DTD
      xmlcatalog --noout --add 'public' \
        '-//OASIS//DTD DocBook XML #{@_ver}//EN' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/dtd/#{@_ver}/docbook.dtd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'system' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/dtd/docbook.dtd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/dtd/#{@_ver}/docbook.dtd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'system' \
        'http://docbook.org/xml/#{@_ver}/dtd/docbook.dtd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/dtd/#{@_ver}/docbook.dtd' docbook-#{@_ver}.xml
    DTD
    # RNG
    system <<~RNG
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbook.rng' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/rng/docbook.rng' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng' docbook-#{@_ver}.xml
    RNG
    # RNG+XInclude
    system <<~RNG_XINCLUDE
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbookxi.rng' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/rng/docbookxi.rng' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng' docbook-#{@_ver}.xml
    RNG_XINCLUDE
    # RNC
    system <<~RNC
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbook.rnc' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/rng/docbook.rnc' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc' docbook-#{@_ver}.xml
    RNC
    # RNC+XInclude
    system <<~RNC_XINCLUDE
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbookxi.rnc' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/rng/docbookxi.rnc' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc' docbook-#{@_ver}.xml
    RNC_XINCLUDE
    # XSD
    system <<~XSD
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/docbook.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbook.xsd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/xsd/docbook.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbook.xsd' docbook-#{@_ver}.xml
    XSD
    # XSD + XInclude
    system <<~XSD_XINCLUDE
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/docbookxi.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbookxi.xsd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/xsd/docbookxi.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbookxi.xsd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/xi.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xi.xsd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/xsd/xi.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xi.xsd' docbook-#{@_ver}.xml
    XSD_XINCLUDE
    # XLink + XML
    system <<~XLINK_XML
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/xlink.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xlink.xsd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/xsd/xlink.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xlink.xsd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/xml.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xml.xsd' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/xsd/xml.xsd' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xml.xsd' docbook-#{@_ver}.xml
    XLINK_XML
    # Schematron
    system <<~SCHEMATRON
      xmlcatalog --noout --add 'uri' \
        'http://www.oasis-open.org/docbook/xml/#{@_ver}/sch/docbook.sch' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch' docbook-#{@_ver}.xml
      xmlcatalog --noout --add 'uri' \
        'http://docbook.org/xml/#{@_ver}/sch/docbook.sch' \
        'file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch' docbook-#{@_ver}.xml
    SCHEMATRON
    # Build XML catalog files for each Schema
    @ADDFILES_SH = <<~ADDFILES_HEREDOC
      #!/usr/bin/env bash
      set -ex

      for s in dtd rng sch xsd; do
        _schema_catalog=${s}/catalog.xml
        xmlcatalog --noout --create ${_schema_catalog}
        case $s in
          dtd)
            xmlcatalog --noout --add 'public' \
              '-//OASIS//DTD DocBook XML #{@_ver}//EN' \
              'docbook.dtd' ${_schema_catalog}
            xmlcatalog --noout --add 'system' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/dtd/docbook.dtd' \
              'docbook.dtd' ${_schema_catalog}
            ;;
          sch)
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            ;;
          rng)
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbookxi.${s}' \
              'docbookxi.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbookxi.${s}' \
              'docbookxi.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbook.rnc' \
              'docbook.rnc' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbook.rnc' \
              'docbook.rnc' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbookxi.rnc' \
              'docbookxi.rnc' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbookxi.rnc' \
              'docbookxi.rnc' ${_schema_catalog}
            ;;
          xsd)
            # https://docbook.org/xml/5.0/xsd/docbook.xsd
            # https://docbook.org/xml/5.0/xsd/xml.xsd
            # https://docbook.org/xml/5.0/xsd/xlink.xsd
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbookxi.${s}' \
              'docbookxi.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbookxi.${s}' \
              'docbookxi.${s}' ${_schema_catalog}
            # XLink + XML:
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/xlink.xsd' \
              'xlink.xsd' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/xlink.xsd' \
              'xlink.xsd' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/xml.xsd' \
              'xml.xsd' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/xml.xsd' \
              'xml.xsd' ${_schema_catalog}
            ;;
        esac
      done
    ADDFILES_HEREDOC
    File.write('add_files.sh', @ADDFILES_SH, perm: 0o755)
    system './add_files.sh || true'

    %w[dtd rng sch xsd].each do |type|
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/schema/#{type}/#{@_ver}/"
      FileUtils.cp Dir["#{type}/*"], "#{CREW_DEST_PREFIX}/share/xml/docbook/schema/#{type}/#{@_ver}/"
    end

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    # Conflicts with docbook_xml51
    # FileUtils.install 'tools/db4-entities.pl', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5"
    # Conflicts with docbook_xml51
    # FileUtils.install 'tools/db4-upgrade.xsl', "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5/", mode: 0o644

    # catalog configuration
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/xml"
    FileUtils.install "docbook-#{@_ver}.xml", "#{CREW_DEST_PREFIX}/etc/xml/docbook-#{@_ver}.xml", mode: 0o755
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
    system "xmlcatalog --noout --add \"delegatePublic\" \
        \"-//OASIS//ENTITIES DocBook XML\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add \"delegatePublic\" \
        \"-//OASIS//DTD DocBook XML\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add \"delegateSystem\" \
        \"http://www.oasis-open.org/docbook/\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        '#{CREW_PREFIX}/etc/xml/catalog'"
    system "xmlcatalog --noout --add \"delegateURI\" \
        \"http://www.oasis-open.org/docbook/\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        '#{CREW_PREFIX}/etc/xml/catalog'"
  end
end
