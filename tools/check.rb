def check_version(hash = {})
  pkg_version = %x[cat /usr/local/lib/crew/packages/#{hash[:pkg_name]}.rb | pcregrep -i -o1 'version (.+)'].strip
  cur_version = %x[wget -q -O- #{hash[:url]} | pcregrep -i -o1 \"#{hash[:pattern]}\" #{hash[:rest]}].strip

  pkg_name_f = hash[:pkg_name].rjust(16)
  pkg_ver_f = "crew(#{pkg_version})".ljust(14)
  cur_ver_f = "latest(#{cur_version})"

  fmt_s = "#{pkg_name_f}  ->  #{pkg_ver_f} #{cur_ver_f}"
  if pkg_version < cur_version || hash[:pkg_name] == 'jdk8'
    puts fmt_s
  end
end

task default: %w[nano]
task common: %w[openssl node python27 jdk8 node_current php7 nginx go readline ncurses curl binutils perl git sqlite nano]

desc "Check for new version of a2png"
task :a2png do
  check_version :pkg_name => "a2png",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of a2ps"
task :a2ps do
  check_version :pkg_name => "a2ps",
    :url        => "https://ftp.gnu.org/gnu/a2ps/",
    :pattern    => "\\-([\\d.]+)\\.tar\\.gz",
    :rest       => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of acl"
task :acl do
  check_version :pkg_name => "acl",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of ag"
task :ag do
  check_version :pkg_name => "ag",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of aircrack_ng"
task :aircrack_ng do
  check_version :pkg_name => "aircrack_ng",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of antiword"
task :antiword do
  check_version :pkg_name => "antiword",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of applewmproto"
task :applewmproto do
  check_version :pkg_name => "applewmproto",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of apr"
task :apr do
  check_version :pkg_name => "apr",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of apriconv"
task :apriconv do
  check_version :pkg_name => "apriconv",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of aprutil"
task :aprutil do
  check_version :pkg_name => "aprutil",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of aria2"
task :aria2 do
  check_version :pkg_name => "aria2",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of ascii"
task :ascii do
  check_version :pkg_name => "ascii",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of asciidoc"
task :asciidoc do
  check_version :pkg_name => "asciidoc",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of aspell"
task :aspell do
  check_version :pkg_name => "aspell",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of aspell_en"
task :aspell_en do
  check_version :pkg_name => "aspell_en",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of aspell_es"
task :aspell_es do
  check_version :pkg_name => "aspell_es",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of atomicparsely"
task :atomicparsely do
  check_version :pkg_name => "atomicparsely",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of attr"
task :attr do
  check_version :pkg_name => "attr",
    :url        => "http://download.savannah.nongnu.org/releases/attr/",
    :pattern    => "\\-([\\d.]+)\\.src\\.tar\\.gz",
    :rest       => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of autoconf"
task :autoconf do
  check_version :pkg_name => "autoconf",
    :url        => "https://ftp.gnu.org/gnu/autoconf/",
    :pattern    => "\\-([\\d.]+)\\.tar\\.gz",
    :rest       => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

# autoconf_archive

desc "Check for new version of automake"
task :automake do
  check_version :pkg_name => "automake",
    :url        => "https://ftp.gnu.org/gnu/automake/",
    :pattern	=> "\\-([\\d.]+)\\.tar\\.gz",
    :rest       => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of autossh"
task :autossh do

end

desc "Check for new version of aws"
task :aws do
  check_version :pkg_name => "aws",
    :url	=> "",
    :pattern	=> "",
    :rest	=> ""
end

desc "Check for new version of bacon"
task :bacon do
  check_version :pkg_name => "bacon",
    :url	=> "http://www.basic-converter.org/stable/",
    :pattern	=> "\\-([\\d.]+)\\.tar\\.gz<",
    :rest	=> ""
end

desc "Check for new version of bash_completion"
task :bash_completion do
  check_version :pkg_name => "bash_completion",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of bashdb"
task :bashdb do
  check_version :pkg_name => "bashdb",
    :url        => "",
    :pattern    => "",
    :rest       => ""
end

desc "Check for new version of bc"
task :bc do
  check_version :pkg_name => "bc",
    :url	=> "https://ftp.gnu.org/gnu/bc/",
    :pattern	=> "\\-([\\d.]+)\\.tar\\.gz",
    :rest	=> "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of bcif"
task :bcif do
  check_version :pkg_name => "bcif",
    :url	=> "http://www.researchandtechnology.net/bcif/downloads/",
    :pattern	=> "",
    :rest	=> ""
end

desc "Check for new version of bdwgc"
task :bdwgc do
  check_version :pkg_name => "bdwgc",
    :url	=> "",
    :pattern	=> "",
    :rest	=> ""
end

desc "Check for new version of bigreqsproto"
task :bigreqsproto do
  check_version :pkg_name => "bigreqsproto",
    :url	=> "",
    :pattern	=> "",
    :rest	=> ""
end

desc "Check for new version of bind"
task :bind do
  check_version :pkg_name => "bind",
    :url	=> "https://www.isc.org/downloads/bind/",
    :pattern	=> "\\-([\\d.]+)\\.tar\\.gz",
    :rest	=> "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of binutils"
task :binutils do
  check_version :pkg_name => "binutils",
    :url        => "https://ftp.gnu.org/gnu/binutils/",
    :pattern    => "\\-([\\d.]+)\\.tar\\.gz",
    :rest       => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of bison"
task :bison do
  check_version :pkg_name => "bison",
    :url	=> "http://mirror.keystealth.org/gnu/bison/",
    :pattern	=> "\\-([\\d.]+)\\.tar\\.gz",
    :rest	=> "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of buildessential"
task :buildessential do
  # not a real package per se, so skip
end

desc "Check for new version of bz2"
task :bz2 do
  check_version :pkg_name => "bz2",
    :url     => "http://www.bzip.org/index.html",
    :pattern => "current version is <b>([\\d.]+)",
    :rest    => ""
end

desc "Check for new version of chicken"
task :chicken do
  check_version :pkg_name => "chicken",
    :url     => "http://code.call-cc.org/",
    :pattern => "release is ([\\d.]+)",
    :rest    => ""
end

desc "Check for new version of clisp"
task :clisp do
  check_version :pkg_name => "clisp",
    :url     => "https://ftp.gnu.org/pub/gnu/clisp/release/latest",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => ""
end

desc "Check for new version of cmake"
task :cmake do
  check_version :pkg_name => "cmake",
    :url     => "https://cmake.org/download/",
    :pattern => "Latest\\s+Release\\s+\\(([\\d+.]+)\\)",
    :rest    => ""
end

desc "Check for new version of curl"
task :curl do
  check_version :pkg_name => "curl",
    :url     => "https://curl.haxx.se/download.html",
    :pattern => "curl ([\\d.]+)",
    :rest    => ""
end

desc "Check for new version of diffutils"
task :diffutils do
  check_version :pkg_name => "diffutils",
    :url     => "https://ftp.gnu.org/gnu/diffutils/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of di"
task :di do
  check_version :pkg_name => "di",
    :url     => "http://gentoo.com/di",
    :pattern => "Current Version: ([\\d.]+)",
    :rest    => ""
end

desc "Check for new version of elixir"
task :elixir do
  check_version :pkg_name => "elixir",
    :url     => "https://github.com/elixir-lang/elixir/releases/latest",
    :pattern => "v([\\d.]+)</a",
    :rest    => ""
end

desc "Check for new version of emacs"
task :emacs do
  check_version :pkg_name => "emacs",
    :url     => "https://ftp.gnu.org/gnu/emacs/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of erlang"
task :erlang do
  check_version :pkg_name => "erlang",
    :url     => "http://erlang.org/download/",
    :pattern => "otp_src_([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of expat"
task :expat do
  check_version :pkg_name => "expat",
    :url     => "http://expat.sourceforge.net/",
    :pattern => "Expat ([\\d.]+)",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of ffcall"
task :ffcall do
  check_version :pkg_name => "ffcall",
    :url     => "http://www.haible.de/bruno/packages-ffcall-README.html",
    :pattern => "ffcall-([\\d.]+)\.tar\.gz",
    :rest    => "| uniq"
end

desc "Check for new version of filecmd"
task :filecmd do
  check_version :pkg_name => "filecmd",
    :url     => "ftp://ftp.astron.com/pub/file/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of fish"
task :fish do
  check_version :pkg_name => "fish",
    :url     => "https://github.com/fish-shell/fish-shell/releases/latest",
    :pattern => "fish ([\\d.]+).+</a",
    :rest    => ""
end

desc "Check for new version of flex"
task :flex do
  check_version :pkg_name => "flex",
    :url     => "http://fossies.org/linux/misc/",
    :pattern => "flex-([\\d.]+)\\.tar\\.gz</b></a>",
    :rest    => ""
end

desc "Check for new version of fontconfig"
task :fontconfig do
  check_version :pkg_name => "fontconfig",
    :url     => "https://www.freedesktop.org/software/fontconfig/release/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of freetype"
task :freetype do
  check_version :pkg_name => "freetype",
    :url     => "http://download.savannah.gnu.org/releases/freetype/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of gawk"
task :gawk do
  check_version :pkg_name => "gawk",
    :url     => "http://ftp.gnu.org/gnu/gawk/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of gcc"
task :gcc do

end

desc "Check for new version of gdal"
task :gdal do
  check_version :pkg_name => "gdal",
    :url     => "http://download.osgeo.org/gdal/CURRENT/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz<",
    :rest    => ""
end

desc "Check for new version of gdbm"
task :gdbm do
  check_version :pkg_name => "gdbm",
    :url     => "https://ftp.gnu.org/gnu/gdbm/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of geos"
task :geos do
  check_version :pkg_name => "geos",
    :url     => "http://download.osgeo.org/geos/",
    :pattern => "\\-([\\d.]+)\\.tar\\.bz2<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of gettext"
task :gettext do
  check_version :pkg_name => "gettext",
    :url     => "https://ftp.gnu.org/pub/gnu/gettext/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of git"
task :git do
  check_version :pkg_name => "git",
    :url     => "https://github.com/git/git/releases",
    :pattern => "v([\\d.]+)<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of glibc"
task :glibc do
  check_version :pkg_name => "glibc",
    :url     => "https://ftp.gnu.org/pub/gnu/glibc/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of gpm"
task :gpm do
  check_version :pkg_name => "gmp",
    :url     => "https://ftp.gnu.org/pub/gnu/gmp/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of gnutls"
task :gnutls do
  # NOTE: This one will be problematic as they list a series and then
  #   have the actual versions in another directory ; rev on the
  #   series will have to be detected somehow
  check_version :pkg_name => "gnutls",
    :url     => "ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/",
    :pattern => "\\-([\\d.]+)\\.tar\\.xz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of go_bootstrap"
task :go_bootstrap do
  puts "Will have to manually check this one: https://storage.googleapis.com/golang/"
end

desc "Check for new version of go"
task :go do
  check_version :pkg_name => "go",
    :url     => "https://golang.org/dl/",
    :pattern => "go([\\d.]+)\\.src\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of gperf"
task :gperf do
  check_version :pkg_name => "gperf",
    :url     => "http://ftp.gnu.org/pub/gnu/gperf/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of graphicsmagick"
task :graphicsmagick do
  check_version :pkg_name => "graphicsmagick",
    :url     => "https://sourceforge.net/projects/graphicsmagick/files/",
    :pattern => "<span>Download GraphicsMagick-([\\d.]+)",
    :rest    => ""
end

desc "Check for new version of groff"
task :groff do
  check_version :pkg_name => "groff",
    :url     => "http://ftp.gnu.org/gnu/groff/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of htop"
task :htop do
  check_version :pkg_name => "htop",
    :url     => "http://hisham.hm/htop/releases/",
    :pattern => "([\\d.]+)\\/<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of imagemagick"
task :imagemagick do
  check_version :pkg_name => "imagemagick",
    :url     => "http://www.imagemagick.org/download/releases/",
    :pattern => "ImageMagick-([\\d.-]+)\\.tar\\.xz\\.",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of inetutils"
task :inetutils do
  check_version :pkg_name => "inetutils",
    :url     => "http://ftp.gnu.org/gnu/inetutils/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of jdk8"
task :jdk8 do
  # NOTE: package version uses Oracle's naming convention rather than the one used by the OpenJDK project's website so this will need special handling
  check_version :pkg_name => "jdk8",
    :url     => "http://download.java.net/openjdk/jdk8",
    :pattern => "(8 build b[\\d.]+)",
    :rest    => ""
end

desc "Check for new version of jq"
task :jq do
  check_version :pkg_name => "jq",
    :url     => "https://github.com/stedolan/jq/releases/latest",
    :pattern => "jq ([\\d.]+)</a",
    :rest    => ""
end

desc "Check for new version of jsonc"
task :jsonc do
  check_version :pkg_name => "jsonc",
    :url     => "https://github.com/json-c/json-c/releases/latest",
    :pattern => "release json-c-([\\d.-]+)",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of less"
task :less do
  check_version :pkg_name => "less",
    :url     => "ftp://ftp.gnu.org/gnu/less/",
    :pattern => "less-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -nr | head -1"
end

desc "Check for new version of leveldb"
task :leveldb do
  check_version :pkg_name => "leveldb",
    :url     => "https://github.com/google/leveldb/releases/latest",
    :pattern => "Release ([\\d.]+)</a",
    :rest    => ""
end

desc "Check for new version of libevent"
task :libevent do
  check_version :pkg_name => "libevent",
    :url     => "https://github.com/libevent/libevent/releases/latest",
    :pattern => "libevent-([\\d.]+)-stable\\.tar\\.gz<",
    :rest    => ""
end

desc "Check for new version of libffi"
task :libffi do
  check_version :pkg_name => "libffi",
    :url     => "ftp://sourceware.org/pub/libffi/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libgd"
task :libgd do
  check_version :pkg_name => "libgd",
    :url     => "https://github.com/libgd/libgd/releases/latest",
    :pattern => "LibGD ([\\d.]+)</a",
    :rest    => ""
end

desc "Check for new version of libjpeg"
task :libjpeg do
  check_version :pkg_name => "libjpeg",
    :url     => "http://www.ijg.org",
    :pattern => "current version is release ([\\d.a-z]+)",
    :rest    => ""
end

desc "Check for new version of libpcap"
task :libpcap do
  check_version :pkg_name => "libpcap",
    :url     => "http://www.tcpdump.org/release/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libpipine"
task :libpipeline do
  check_version :pkg_name => "libpipeline",
    :url     => "https://download.savannah.gnu.org/releases/libpipeline/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libpng"
task :libpng do
  check_version :pkg_name => "libpng",
    :url     => "https://github.com/glennrp/libpng/releases/latest",
    :pattern => "v([\\d.]+)</span",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libsigsegv"
task :libsigsegv do
  check_version :pkg_name => "libsigsegv",
    :url     => "ftp.gnu.org/gnu/libsigsegv/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz<",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libtiff"
task :libtiff do
  check_version :pkg_name => "libtiff",
    :url     => "ftp://download.osgeo.org/libtiff/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libtool"
task :libtool do
  check_version :pkg_name => "libtool",
    :url     => "ftp.gnu.org/gnu/libtool/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libunistring"
task :libunistring do
  check_version :pkg_name => "libunistring",
    :url     => "ftp.gnu.org/gnu/libunistring/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libunwind"
task :libunwind do
  check_version :pkg_name => "libunwind",
    :url     => "https://download.savannah.gnu.org/releases/libunwind/",
    :pattern => "\\-([\\d.]+)\\.tar\\.gz",
    :rest    => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libuv"
task :libuv do
  check_version :pkg_name => "libuv",
	:url      => "http://dist.libuv.org/dist/",
	:pattern  => "v([\\d.]+)\\/<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libxml2"
task :libxml2 do
  check_version :pkg_name => "libxml2",
	:url      => "http://xmlsoft.org/sources/",
	:pattern  => "libxml2\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of libxslt"
task :libxslt do
  check_version :pkg_name => "libxslt",
	:url      => "http://xmlsoft.org/sources/",
	:pattern  => "libxslt\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of llvm"
task :llvm do
  check_version :pkg_name => "llvm",
	:url      => "http://releases.llvm.org/download.html",
	:pattern  => "llvm\\-([\\d.]+)\\.src\\.tar\\.xz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of lua"
task :lua do
  check_version :pkg_name => "lua",
	:url      => "https://www.lua.org/ftp/",
	:pattern  => "([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new verion of lz4"
task :lz4 do
  check_version :pkg_name => "lz4",
	:url      => "https://github.com/lz4/lz4/releases/latest",
	:pattern  => "v([\\d.]+)</span",
	:rest     => ""
end

desc "Check for new version of m4"
task :m4 do
  check_version :pkg_name => "m4",
	:url      => "ftp://ftp.gnu.org/gnu/m4/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.xz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of mandb"
task :mandb do
  check_version :pkg_name => "mandb",
	:url      => "https://download.savannah.gnu.org/releases/man-db/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.xz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of mapserver"
task :mapserver do
  check_version :pkg_name => "mapserver",
	:url      => "ftp://download.osgeo.org/mapserver/",
	:pattern  => "mapserver\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of memcached"
task :memcached do
  check_version :pkg_name => "memcached",
	:url      => "https://memcached.org/files/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of mlocate"
task :mlocate do
  check_version :pkg_name => "mlocate",
	:url      => "https://fedorahosted.org/releases/m/l/mlocate/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.xz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of mongodb"
task :mongodb do
  check_version :pkg_name => "mongodb",
	:url      => "https://github.com/mongodb/mongo/releases",
	:pattern  => "r([\\d.]+)</span",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of moonbuggy"
task :moonbuggy do
  check_version :pkg_name => "moonbuggy",
	:url      => "http://m.seehuhn.de/programs/",
	:pattern  => "moon\\-buggy\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of mpc"
task :mpc do
  check_version :pkg_name => "mpc",
	:url      => "https://ftp.gnu.org/gnu/mpc/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of mpfr"
task :mpfr do
  check_version :pkg_name => "mpfr",
	:url      => "https://ftp.gnu.org/gnu/mpfr/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of nano"
task :nano do
  check_version :pkg_name => "nano",
	:url      => "ftp://ftp.gnu.org/pub/gnu/nano/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new verison of ncdu"
task :ncdu do
  check_version :pkg_name => "ncdu",
	:url      => "https://dev.yorhel.nl/download/",
	:pattern  => "ncdu\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of ncftp"
task :ncftp do
  check_version :pkg_name => "ncftp",
	:url      => "ftp://ftp.ncftp.com/ncftp/",
	:pattern  => "\\-([\\d.]+)\\-src\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of ncurses"
task :ncurses do
  check_version :pkg_name => "ncurses",
	:url      => "ftp://ftp.gnu.org/pub/gnu/ncurses/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of netcat"
task :netcat do
  check_version :pkg_name => "netcat",
	:url      => "https://sourceforge.net/projects/netcat/files/netcat/",
	:pattern  => "netcat\\-([\\d.]+)\\.tar\\.gz \\(",
	:rest     => ""
end

desc "Check for new version of nethack4"
task :nethack4 do
  puts "manual check because of page structure"
end

desc "Check for new version of nettle"
task :nettle do
  check_version :pkg_name => "nettle",
	:url      => "ftp://ftp.gnu.org/pub/gnu/nettle/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of newlisp"
task :newlisp do
  check_version :pkg_name => "newlisp",
	:url      => "http://www.newlisp.org/downloads/",
	:pattern  => "\\-([\\d.]+)\\.tgz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of nginx"
task :nginx do
  check_version :pkg_name => "nginx",
	:url      => "http://nginx.org/download/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of nmap"
task :nmap do
  check_version :pkg_name => "nmap",
	:url      => "https://nmap.org/dist/",
	:pattern  => "\\-([\\d.]+)\\.tgz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of node"
task :node do
  check_version :pkg_name => "node",
	:url      => "https://nodejs.org/dist/latest-v6.x/",
	:pattern  => "node\\-v([\\d.]+)\\.tar\\.xz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of node_current"
task :node_current do
  check_version :pkg_name => "node_current",
	:url      => "https://nodejs.org/dist/latest-v7.x/",
	:pattern  => "node\\-v([\\d.]+)\\.tar\\.xz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of npth"
task :npth do
  check_version :pkg_name => "npth",
	:url      => "https://www.gnupg.org/ftp/gcrypt/npth/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.bz2",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of openconnect"
task :openconnect do
  check_version :pkg_name => "openconnect",
	:url      => "ftp://ftp.infradead.org/pub/openconnect/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of openssl"
task :openssl do
  check_version :pkg_name => "openssl",
	:url      => "ftp://openssl.org/source/",
	:pattern  => "openssl\\-(1.0[\\d.\\w]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of optipng"
task :optipng do
  check_version :pkg_name => "optipng",
	:url      => "https://sourceforge.net/projects/optipng/files/OptiPNG/",
	:pattern  => "([\\d.]+)</a>",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of p7zip"
task :p7zip do
  check_version :pkg_name => "p7zip",
	:url      => "https://sourceforge.net/projects/p7zip/files/p7zip/",
	:pattern  => "([\\d.]+)</a>",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of pagemon"
task :pagemon do
  check_version :pkg_name => "pagemon",
	:url      => "http://kernel.ubuntu.com/~cking/tarballs/pagemon/",
	:pattern  => "\\-([\\d.\\w]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of patchelf"
task :patchelf do
  check_version :pkg_name => "patchelf",
	:url      => "http://nixos.org/releases/patchelf/",
	:pattern  => "patchelf\\-([\\d.]+)",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of patch"
task :patch do
  check_version :pkg_name => "patch",
	:url      => "http://ftp.gnu.org/gnu/patch/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of pciutils"
task :pciutils do
  check_version :pkg_name => "pciutils",
	:url      => "https://www.kernel.org/pub/software/utils/pciutils/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of pcre"
task :pcre do
  check_version :pkg_name => "pcre",
	:url      => "https://sourceforge.net/projects/pcre/files/pcre/",
	:pattern  => "([\\d.]+)</a>",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of perl"
task :perl do
  check_version :pkg_name => "perl",
	:url      => "https://www.perl.org/",
	:pattern  => "([\\d.]+) - download now",
	:rest     => ""
end

desc "Check for new version of php5"
task :php5 do
  check_version :pkg_name => "php5",
	:url      => "https://github.com/php/php-src/releases",
	:pattern  => "php\\-(5[\\d.]+)<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end


desc "Check for new version of php7"
task :php7 do
  check_version :pkg_name => "php7",
	:url      => "https://github.com/php/php-src/releases",
	:pattern  => "php\\-(7[\\d.]+)<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of pkgconfig"
task :pkgconfig do
  check_version :pkg_name => "pkgconfig",
	:url      => "http://pkgconfig.freedesktop.org/releases/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of postgres"
task :postgres do
  check_version :pkg_name => "postgres",
	:url      => "https://ftp.postgresql.org/pub/source",
	:pattern  => "v([\\d.]+)<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of powerline_fonts"
task :powerline_fonts do

end

desc "Check for new version of powerstat"
task :powerstat do
  check_version :pkg_name => "powerstat",
	:url      => "http://kernel.ubuntu.com/~cking/tarballs/powerstat/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of proj4"
task :proj4 do
  check_version :pkg_name => "proj4",
	:url      => "http://download.osgeo.org/proj/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of pv"
task :pv do
  check_version :pkg_name => "pv",
	:url      => "http://www.ivarch.com/programs/pv.shtml",
	:pattern  => "Current version: ([\\d.]+)",
	:rest     => ""
end

desc "Check for new version of pwgen"
task :pwgen do

end

desc "Check for new version of python27"
task :python27 do
  check_version :pkg_name => "python27",
	:url      => "https://www.python.org/ftp/python/",
	:pattern  => ">(2.7[\\d.]+)/<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of python34"
task :python34 do
  check_version :pkg_name => "python34",
	:url      => "https://www.python.org/ftp/python/",
	:pattern  => ">(3.4[\\d.]+)/<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of qemacs"
task :qemacs do
  check_version :pkg_name => "qemacs",
	:url      => "http://bellard.org/qemacs/",
	:pattern  => "QEmacs ([\\d.]+) is out",
	:rest     => ""
end

desc "Check for new version of readline"
task :readline do
  check_version :pkg_name => "readline",
	:url      => "http://ftp.gnu.org/gnu/readline/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of redis"
task :redis do
  check_version :pkg_name => "redis",
	:url      => "http://download.redis.io/releases/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of r"
task :r do
  check_version :pkg_name => "r",
	:url      => "https://cran.rstudio.com/banner.shtml",
	:pattern  => "R\\-([\\d.]+)\\.tar\\.gz<",
	:rest     => ""
end

desc "Check for new version of rsync"
task :rsync do
  check_version :pkg_name => "rsync",
	:url      => "http://rsync.samba.org/ftp/rsync/src/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of ruby_lastest"
task :ruby_latest do
  check_version :pkg_name => "ruby_latest",
	:url      => "http://cache.ruby-lang.org/pub/ruby/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.xz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of screenfetch"
task :screenfetch do
  check_version :pkg_name => "screenfetch",
	:url      => "https://github.com/KittyKatt/screenFetch/releases",
	:pattern  => "v([\\d.]+)<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of screen"
task :screen do
  check_version :pkg_name => "screen",
	:url      => "ftp://ftp.gnu.org/gnu/screen/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of scrollz"
task :scrollz do
  check_version :pkg_name => "scrollz",
	:url      => "http://www.scrollz.info/download/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of slang"
task :slang do
  check_version :pkg_name => "slang",
	:url      => "http://www.jedsoft.org/slang",
	:pattern  => "Version ([\\d.\\w]+)",
	:rest     => ""
end

desc "Check for new version of sluice"
task :sluice do
  check_version :pkg_name => "sluice",
	:url      => "http://kernel.ubuntu.com/~cking/tarballs/sluice/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of smemstat"
task :smemstat do
  check_version :pkg_name => "smemstat",
	:url      => "http://kernel.ubuntu.com/~cking/tarballs/smemstat/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of socat"
task :socat do
  check_version :pkg_name => "socat",
	:url      => "http://www.dest-unreach.org/socat/download/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of sqlite"
task :sqlite do
  check_version :pkg_name => "sqlite",
	:url      => "https://sqlite.org",
	:pattern  => "Version ([\\d.]+)<",
	:rest     => ""
end

desc "Check for new version of sshfs"
task :sshfs do
  check_version :pkg_name => "sshfs",
	:url      => "https://github.com/libfuse/sshfs/releases/latest",
	:pattern  => "SSHFS ([\\d.]+)<",
	:rest     => ""
end

desc "Check for new version of tcl"
task :tcl do
  check_version :pkg_name => "tcl",
	:url      => "https://tcl.tk/software/tcltk/download.html",
	:pattern  => "tcl([\\d.]+)\\-src\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of tcpdump"
task :tcpdump do
  check_version :pkg_name => "tcpdump",
	:url      => "http://www.tcpdump.org/release/",
	:pattern  => "([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

# TODO: tcpstat, website was down

desc "Check for new version of texinfo"
task :texinfo do
  check_version :pkg_name => "texinfo",
	:url      => "http://ftp.gnu.org/gnu/texinfo/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new versio of tig"
task :tig do
  check_version :pkg_name => "tig",
	:url      => "https://github.com/jonas/tig/releases/latest",
	:pattern  => "tig\\-([\\d.]+)<",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of tinycc"
task :tinycc do
  check_version :pkg_name => "tinycc",
	:url      => "http://download.savannah.gnu.org/releases/tinycc/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.bz2",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of tmux"
task :tmux do
  check_version :pkg_name => "tmux",
	:url      => "https://tmux.github.io/",
	:pattern  => "Download tmux ([\\d.]+)",
	:rest     => ""
end

desc "Check for new version of traceroute"
task :traceroute do
  check_version :pkg_name => "traceroute",
      :url      => "https://sourceforge.net/projects/traceroute/files/traceroute/",
      :pattern  => "traceroute\\-([\\d.]+)",
      :rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of tree"
task :tree do
  check_version :pkg_name => "tree",
	:url      => "http://mama.indstate.edu/users/ice/tree/src/",
	:pattern  => "\\-([\\d.]+)\\.tgz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of unrar"
task :unrar do
  check_version :pkg_name => "unrar",
	:url      => "http://www.rarlab.com/rar_add.htm",
	:pattern  => "unrarsrc\\-([\\d.]+)\\.tar\\.gz",
	:rest     => ""
end

desc "Check for new version of unzip"
task :unzip do

end

desc "Check for new version of vifm"
task :vifm do
  check_version :pkg_name => "vifm",
    :url      => "https://sourceforge.net/projects/vifm/files/vifm/",
    :pattern  => "vifm\\-([\\d.]+)",
    :rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of vim"
task :vim do
  check_version :pkg_name => "vim",
	:url      => "ftp://ftp.vim.org/pub/vim/unix/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.bz2",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of xzutils"
task :xzutils do
  check_version :pkg_name => "xzutils",
	:url      => "http://tukaani.org/xz/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of yasm"
task :yasm do
  check_version :pkg_name => "yasm",
	:url      => "http://www.tortall.net/projects/yasm/releases/",
	:pattern  => "\\-([\\d.]+)\\.tar\\.gz",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of zlibpkg"
task :zlibpkg do
  check_version :pkg_name => "zlibpkg",
	:url      => "http://www.zlib.net/",
	:pattern  => "zlib ([\\d.]+)",
	:rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of zsh"
task :zsh do
  check_version :pkg_name => "zsh",
    :url      => "https://sourceforge.net/projects/zsh/files/zsh/",
    :pattern  => "([\\d.]+)</a>",
    :rest     => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of units"
task :units do
  check_version :pkg_name => "units",
    :url        => "https://ftp.gnu.org/gnu/units/",
    :pattern    => "\\-([\\d.]+)\\.tar\\.gz",
    :rest       => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end

desc "Check for new version of weather"
task :weather do
  check_version :pkg_name => "weather",
    :url        => "http://fungi.yuggoth.org/weather/src/",
    :pattern    => "\\-([\\d.]+)\\.tar\\.gz",
    :rest       => "| sort -t. -k 1,1nr -k 2,2nr -k 3,3nr -k 4,4nr | head -1"
end
