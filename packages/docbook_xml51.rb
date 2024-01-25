require 'package'

class Docbook_xml51 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '5.1'
  version "#{@_ver}-3"
  license 'MIT'
  compatibility 'all'
  source_url "https://docbook.org/xml/#{@_ver}/docbook-v#{@_ver}-os.zip"
  source_sha256 'b3f3413654003c1e773360d7fc60ebb8abd0e8c9af8e7d6c4b55f124f34d1e7f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '540df829dc7cba3edba8180004eceb50613e9b73300f34b87c1b4fe204b1ed2d',
     armv7l: '540df829dc7cba3edba8180004eceb50613e9b73300f34b87c1b4fe204b1ed2d',
       i686: 'ac490b002ad995daf9f79d532a72b548257cebec3bed3e134941d79773ed2599',
     x86_64: '1922bb026b236b87ace2598753705817a32e32366ed5d20ad7c32c844191a75c'
  })

  depends_on 'docbook_xml'
  depends_on 'libxml2'
  depends_on 'xmlcatmgr'

  def self.install
    system "xmlcatalog --noout --create docbook-#{@_ver}.xml"

    {
      # RNG
      "http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbook.rng" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng",
                     "http://docbook.org/xml/#{@_ver}/rng/docbook.rng" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng",
    # RNG+XInclude
    "http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbookxi.rng" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng",
                   "http://docbook.org/xml/#{@_ver}/rng/docbookxi.rng" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng",
      # RNC
      "http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbook.rnc" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc",
                     "http://docbook.org/xml/#{@_ver}/rng/docbook.rnc" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc",
    # RNC+XInclude
    "http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbookxi.rnc" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc",
                   "http://docbook.org/xml/#{@_ver}/rng/docbookxi.rnc" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc",
      # Schematron
      "http://www.oasis-open.org/docbook/xml/#{@_ver}/sch/docbook.sch" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch",
                     "http://docbook.org/xml/#{@_ver}/sch/docbook.sch" => "file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch"
    }.each_pair do |k, v|
      system 'xmlcatalog', '--noout', '--add', 'uri', k, v, "docbook-#{@_ver}.xml"
    end

    # Build XML catalog files for each Schema
    @ADDFILES_SH = <<~ADDFILES_HEREDOC
      #!/usr/bin/env bash
      set -ex

      for s in schemas/rng schemas/sch; do
        _schema_catalog=${s}/catalog.xml
        xmlcatalog --noout --create ${_schema_catalog}
        case $s in
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
        esac
      done
    ADDFILES_HEREDOC
    File.write('add_files.sh', @ADDFILES_SH, perm: 0o755)
    system './add_files.sh || true'

    %w[rng sch].each do |type|
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/schema/#{type}/#{@_ver}/"
      FileUtils.cp Dir["schemas/#{type}/*"], "#{CREW_DEST_PREFIX}/share/xml/docbook/schema/#{type}/#{@_ver}/"
    end

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'tools/db4-entities.pl', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5"
    FileUtils.install 'tools/db4-upgrade.xsl', "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5/"

    # catalog configuration
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/xml"
    FileUtils.install "docbook-#{@_ver}.xml", "#{CREW_DEST_PREFIX}/etc/xml/docbook-#{@_ver}.xml", mode: 0o644
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
    { 'delegatePublic' => '-//OASIS//ENTITIES DocBook XML',
      'delegateSystem' => 'http://www.oasis-open.org/docbook/',
         'delegateURI' => 'http://www.oasis-open.org/docbook/' }.each_pair do |k, v|
      system 'xmlcatalog', '--noout', '--add', k, v, "file://#{CREW_PREFIX}/etc/xml/docbook-xml",
             "#{CREW_PREFIX}/etc/xml/catalog"
    end
  end
end
