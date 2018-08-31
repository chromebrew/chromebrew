require 'package'
class Re6stnet < Package
  description 'Resilient, Scalable, IPv6 Network'
  homepage 'https://re6st.nexedi.com/'
  version '0.509'
  source_url 'https://lab.nexedi.com/nexedi/chromebrew-buildout-re6st/repository/archive.tar.bz2?ref=5cb542c266b398fd2a36d16c9f8cb1fb9fc1d567'
  source_sha256 '6872b0275ff11d264241e098133b2f490a04273dfb1db5bf91547ceb0c320763'

  binary_url ({
    x86_64: 'https://softinst105421.host.vifib.net/public/re6stnet-0.509-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '506d8e7f959bbe05c6e68672b5e488ecfc4e87a3782aafe73a4621b34a6cf0c8',
  })

  depends_on 'python27' => :build
  depends_on 'filecmd' => :build
  depends_on 'libiconv' => :build

  @re6st_dir = 	"#{CREW_PREFIX}/opt/re6st"

  def self.build
    system "mkdir -p #{@re6st_dir}/bin && cp buildout.cfg #{@re6st_dir} && cp bin/grandenet #{@re6st_dir}/bin"
    system "SSL_CERT_DIR=/etc/ssl/certs ./bin/buildout buildout:directory=#{@re6st_dir}"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/opt/ "
    system "cp -r #{@re6st_dir} #{CREW_DEST_DIR}#{@re6st_dir}"
    system "rm -rf #{CREW_DEST_DIR}#{@re6st_dir}/download-cache"
    system "ln -fs #{@re6st_dir}/bin/grandenet #{CREW_PREFIX}/sbin/grandenet"
    system "ln -fs #{@re6st_dir}/bin/re6stnet #{CREW_PREFIX}/sbin/re6stnet"
    system "ln -fs #{@re6st_dir}/bin/re6st-conf #{CREW_PREFIX}/bin/re6st-conf"
    system "ln -fs #{@re6st_dir}/bin/re6st-registry #{CREW_PREFIX}/bin/re6st-registry"
  end

  def self.postinstall
    puts "To initiate re6stnet, run #{CREW_PREFIX}/sbin/grandenet"
  end
end
