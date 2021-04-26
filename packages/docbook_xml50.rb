require 'package'

class Docbook_xml50 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '5.0'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://docbook.org/xml/#{@_ver}/docbook-#{@_ver}.zip"
  source_sha256 '3dcd65e1f5d9c0c891b3be204fa2bb418ce485d32310e1ca052e81d36623208e'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/docbook_xml50-5.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/docbook_xml50-5.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/docbook_xml50-5.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/docbook_xml50-5.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2ab82950132df3cd03fa314553cd961aa22f559d95dca84943e75c55158a8a3b',
     armv7l: '2ab82950132df3cd03fa314553cd961aa22f559d95dca84943e75c55158a8a3b',
       i686: '0f60fb72a56090a498bf7959ec4c566f0e7b6b9e8ecb6eacaaeb7b115b08c2a0',
     x86_64: '3206419c30af448462552a504c545b22f53b3acfc8806347c667d1bdba6d21f0'
  })

  depends_on 'docbook_xml'
  depends_on 'xmlcatmgr'
  depends_on 'bash'

  def self.install
    system "xmlcatalog --noout --create docbook-#{@_ver}.xml"
    # DTD
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//DTD DocBook XML #{@_ver}//EN' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/dtd/#{@_ver}/docbook.dtd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'system' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/dtd/docbook.dtd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/dtd/#{@_ver}/docbook.dtd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'system' \
      'http://docbook.org/xml/#{@_ver}/dtd/docbook.dtd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/dtd/#{@_ver}/docbook.dtd' docbook-#{@_ver}.xml"
    # RNG
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbook.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbook.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng' docbook-#{@_ver}.xml"
    # RNG+XInclude
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbookxi.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbookxi.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng' docbook-#{@_ver}.xml"
    # RNC
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbook.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbook.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc' docbook-#{@_ver}.xml"
    # RNC+XInclude
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbookxi.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbookxi.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc' docbook-#{@_ver}.xml"
    # XSD
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/docbook.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbook.xsd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/xsd/docbook.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbook.xsd' docbook-#{@_ver}.xml"
    # XSD + XInclude
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/docbookxi.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbookxi.xsd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/xsd/docbookxi.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/docbookxi.xsd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/xi.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xi.xsd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/xsd/xi.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xi.xsd' docbook-#{@_ver}.xml"
    # XLink + XML
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/xlink.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xlink.xsd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/xsd/xlink.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xlink.xsd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/xsd/xml.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xml.xsd' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/xsd/xml.xsd' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/xsd/#{@_ver}/xml.xsd' docbook-#{@_ver}.xml"
    # Schematron
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/sch/docbook.sch' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/sch/docbook.sch' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch' docbook-#{@_ver}.xml"
    # Build XML catalog files for each Schema
    @ADDFILES_SH = <<~ADDFILES_HEREDOC
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
    IO.write('add_files.sh', @ADDFILES_SH, perm: 0o755)
    system "#{CREW_PREFIX}/bin/bash -x ./add_files.sh | true"

    system "#{CREW_PREFIX}/bin/bash -c \"for type in dtd rng sch xsd; do
      mkdir -p #{CREW_DEST_PREFIX}/share/xml/docbook/schema/\\\${type}/#{@_ver}
      install -m644 \\\${type}/* #{CREW_DEST_PREFIX}/share/xml/docbook/schema/\\\${type}/#{@_ver}
    done\""
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "install -m755 tools/db4-entities.pl #{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5"
    system "install -m644 tools/db4-upgrade.xsl #{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5/"

    # catalog configuration
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/xml"
    system "install -m644 docbook-#{@_ver}.xml  #{CREW_DEST_PREFIX}/etc/xml/docbook-#{@_ver}.xml"
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
