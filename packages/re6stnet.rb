require 'package'
class Re6stnet < Package
  description 'Resilient, Scalable, IPv6 Network'
  homepage 'https://re6st.nexedi.com/'
  version '0.509'
  source_url 'https://lab.nexedi.com/nexedi/chromebrew-buildout-re6st/repository/archive.tar.bz2?ref=1bc16d97519af4329b01514634e648db0a7be333'
  source_sha256 '02e90c41ed7511216b7ab283d8b7893882a3349d7c383e7b983561299972a9ce'

  binary_url ({
    x86_64: 'https://softinst105421.host.vifib.net/public/re6stnet-0.509-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: 'b9b8cc48e5a7a1fa202a89c8807d4aa63a8db79353ab6dc992608b608130a52b',
  })

  depends_on 'python27' => :build
  depends_on 'filecmd' => :build
  depends_on 'libiconv' => :build
  depends_on 'glibc'

  @re6st_dir = 	"#{CREW_PREFIX}/opt/re6st"

  def self.build
    system "mkdir -p #{@re6st_dir}/bin && cp buildout.cfg #{@re6st_dir} && cp bin/grandenet #{@re6st_dir}/bin"
    system "gcc shill_wrapper.c -o #{@re6st_dir}/bin/shill_wrapper -ldl -Wall -fPIC -pie"
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
