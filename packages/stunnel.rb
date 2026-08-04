require 'buildsystems/autotools'

class Stunnel < Autotools
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.79'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/mtrojnar/stunnel.git'
  git_hashtag "stunnel-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a80a9dd3a7f31a740ed926adaf41867f01175218417e5c5e37d989dfcfde0dd',
     armv7l: '9a80a9dd3a7f31a740ed926adaf41867f01175218417e5c5e37d989dfcfde0dd',
       i686: '45e5a3b88201859af59e8fb9f2334e890ad0d76e3e3944f3a73f7c7776144aa1',
     x86_64: '2a1faf8c8a4e10a4fa483b9116a8462747d6983cc2ae097aca4d2b63400a4d57'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :executable
  depends_on 'tcpwrappers' => :library

  def self.patch
    # The aclocal & automake versions are hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp
    automake_version = `automake --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    system "sed -i \"s,am__api_version='1.17',am__api_version='#{automake_version}',g\" aclocal.m4"
    system "sed -i 's/m4_if([$1], [1.17]/m4_if([$1], [#{automake_version}]/g' aclocal.m4"
    system "sed -i 's,1.17,#{aclocal_version},g' aclocal.m4"
    system "sed -i 's,1.17,#{aclocal_version},g' configure"
    system 'automake'
  end

  def self.postbuild
    # Fix bash: /usr/local/bin/stunnel3: /usr/bin/perl: bad interpreter: No such file or directory
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' #{CREW_DEST_PREFIX}/bin/stunnel3"
  end
end
