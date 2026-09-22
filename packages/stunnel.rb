require 'buildsystems/autotools'

class Stunnel < Autotools
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.82'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/mtrojnar/stunnel.git'
  git_hashtag "stunnel-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2806af8dda82a6cf9a50e3b460bab97e567fcd0abbb157646b7040ce0231fe38',
     armv7l: '2806af8dda82a6cf9a50e3b460bab97e567fcd0abbb157646b7040ce0231fe38',
       i686: '7b986a840042cf225e484ba9a6cdb1a36eb21ea517973cf65b136b93339c3123',
     x86_64: 'a364e95a8c439dc1d5828e2894e3d98cd8e19332e54c42f4ecf312aac4721145'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :executable
  depends_on 'tcpwrappers' => :library

  autotools_skip_autoreconf

  def self.patch
    # The aclocal & automake versions are hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp
    automake_version = `automake --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    package_automake_version = File.open('Makefile.in', &:readline).split[5]
    package_automake_major_version = package_automake_version.rpartition('.')[0]
    system "sed -i \"s,am__api_version='#{package_automake_version}',am__api_version='#{automake_version}',g\" aclocal.m4"
    system "sed -i 's/m4_if([$1], [#{package_automake_version}]/m4_if([$1], [#{automake_version}]/g' aclocal.m4"
    system "sed -i 's,#{package_automake_version},#{aclocal_version},g' aclocal.m4"
    system "sed -i 's,#{package_automake_major_version},#{aclocal_version},g' aclocal.m4"
    system "sed -i 's,#{package_automake_version},#{aclocal_version},g' configure"
    system "sed -i 's,#{package_automake_major_version},#{aclocal_version},g' configure"
    system 'automake'
  end

  def self.postbuild
    # Fix bash: /usr/local/bin/stunnel3: /usr/bin/perl: bad interpreter: No such file or directory
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' #{CREW_DEST_PREFIX}/bin/stunnel3"
  end
end
