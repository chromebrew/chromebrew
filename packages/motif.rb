require 'package'

class Motif < Package
  description 'Open Motif'
  homepage 'https://github.com/libass/libass'
  version '2.3.8'
  source_url 'https://downloads.sourceforge.net/project/motif/Motif%202.3.8%20Source%20Code/motif-2.3.8.tar.gz'
  source_sha256 '859b723666eeac7df018209d66045c9853b50b4218cecadb794e2359619ebce7' 

  # binary_url ({
  #    aarch64: 'file:///home/chronos/user/Downloads/motif/motif-2.3.8-chromeos-aarch64.tar.xz'
  # })
  # binary_sha256 ({
  #    aarch64: 'b9a8d12260d88c0d1d40e64db579e32f7744a0e1f391c5a054a162aca392d9e9'
  # })

  #depends_on 'automake' => :build
  #depends_on 'autoconf' => :build
  #depends_on 'libtool' => :build
  #depends_on 'fribidi'
  #depends_on 'fontconfig'  

  def self.build
    system "autoconf"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end

end

